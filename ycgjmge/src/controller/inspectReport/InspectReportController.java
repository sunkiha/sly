package controller.inspectReport;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.jpush.api.common.resp.APIConnectionException;
import cn.jpush.api.common.resp.APIRequestException;
import cn.jpush.api.push.model.Platform;
import cn.jpush.api.push.model.PushPayload;
import cn.jpush.api.push.model.audience.Audience;
import cn.jpush.api.push.model.notification.AndroidNotification;
import cn.jpush.api.push.model.notification.IosNotification;
import cn.jpush.api.push.model.notification.Notification;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;

import comm.BaseController;
import comm.M;
import comm.RecordBean;
import comm.S;

public class InspectReportController extends BaseController {
	JSONObject rm;

	public void inspectReportList() {
		render("inspectReportList.jsp");
	}

	public void seeMoreImg() {
		String id = getPara("id");
		List<Record> imgsList = Db.find(
				"SELECT path FROM `inspect_report_img` where fid=?", id);
		setAttr("imgList", imgsList);
		render("seeMoreImg.jsp");
	}

	public void seeReply() {
		String id = getPara("id");
		setAttr("id", id);
		render("inspectReportListReply.jsp");
	}

	public void toAddBeiyun() {
		render("addBeiyun.jsp");
	}

	public void toModBeiyun() {
		render("modBeiyun.jsp");
	}

	// json----------------
	public void getInspectreportListReply() {
		String id = getPara("id");
		rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		List<Object> paras = new ArrayList<Object>();
		StringBuffer where = new StringBuffer(" where ");
		where.append("  irr.userInfoId=u.id and irr.inspectReportId = ? ");
		paras.add(id);
		/*
		 * if(S.notEmpty(week)){ where.append(" and week=?"); paras.add(week); }
		 */
		Page<Record> replyPage = Db.paginate(
				pageNumber,
				pageSize,
				"select irr.*,u.username ",
				"from `inspect_report_reply` irr,userinfo u  "
						+ where.toString() + " order by irr." + sortField + " "
						+ sortOrder, paras.toArray());
		rm.put("data", replyPage.getList());
		rm.put("total", replyPage.getTotalRow());
		renderJson(rm);
	}

	public void getInspectReportList() {
		rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		StringBuffer where = new StringBuffer(" where ");
		where.append(" ir.status=0 and u.id=ir.userInfoId ");
		List<Object> paras = new ArrayList<Object>();
		/*
		 * if(S.notEmpty(week)){ where.append(" and week=?"); paras.add(week); }
		 */
		Page<Record> userInfoPage = Db
				.paginate(
						pageNumber,
						pageSize,
						"select ir.*,u.username,u.nickname,(SELECT path from inspect_report_img iri WHERE iri.fid=ir.id LIMIT 1) path",
						"from inspect_report ir,userinfo u  "
								+ where.toString() + " order by ir."
								+ sortField + " " + sortOrder, paras.toArray());
		rm.put("data", userInfoPage.getList());
		rm.put("total", userInfoPage.getTotalRow());
		renderJson(rm);
	}

	public void doctorReply() throws Exception {
		String id = getPara("id");
		final String content = getPara("content");
		Record inspectReportReply = new RecordBean();
		String inspectReportReplyId = S.oid();
		inspectReportReply.set("id", inspectReportReplyId);
		inspectReportReply.set("inspectReportId", id);
		inspectReportReply.set("content", content);
		inspectReportReply.set("userInfoId", "inspectreportreplydoctor1");
		inspectReportReply.set("name", "医生");
		Db.save("inspect_report_reply", inspectReportReply);
		final Map<String, String> extras = new HashMap<String, String>();
		extras.put("type", S.inspectReport);
		extras.put("inspectReportId", id);
		extras.put("inspectReportReplyId", inspectReportReplyId);
		extras.put("createDate", new Date().toLocaleString());
		/*
		 * PushPayload payload = PushPayload.newBuilder()
		 * .setPlatform(Platform.all()).setAudience(Audience.all())
		 * .setNotification(Notification.android(content, "医生回复", extras))
		 * .build();
		 */
		final String uId = Db.findById("inspect_report", id).getStr(
				"userInfoId");
		new Thread(new Runnable() {

			@Override
			public void run() {
				PushPayload payload = PushPayload
						.newBuilder()
						.setPlatform(Platform.android_ios())
						.setAudience(Audience.alias(uId))
						// 以用户id为alias值作为设备唯一标记
						.setNotification(
								Notification
										.newBuilder()
										.setAlert(content)
										.addPlatformNotification(
												AndroidNotification
														.newBuilder()
														.setTitle("医生回复")
														.addExtras(extras)
														.build())
										.addPlatformNotification(
												IosNotification.newBuilder()
														.incrBadge(1)
														.addExtras(extras)
														.build()).build())
						.build();
				try {
					S.getJPushClient().sendPush(payload);
				} catch (APIConnectionException e) {
					e.printStackTrace();
				} catch (APIRequestException e) {
					e.printStackTrace();
				}
			}
		}).start();

		rm = new JSONObject();
		rm.put(S.code, 0);
		renderJson(rm);
	}

	public void deleteReply() {
		String id = getPara("id");
		Db.deleteById("inspect_report_reply", id);
		rm = new JSONObject();
		rm.put(S.code, 0);
		renderJson(rm);
	}

	public void delInspectReport() {
		String id = getPara("id");
		Db.update("UPDATE `inspect_report` SET  `status` = '1' WHERE id=?", id);
		rm = new JSONObject();
		rm.put(S.code, 0);
		renderJson(rm);
	}

	public void addBeiyun() {
		UploadFile uFile = getFile("statusPic");
		int day = getParaToInt("day");
		Record rd = Db.findFirst("select * from beiyunCareRemind where day=?",
				day);
		if (rd != null) {
			setAttr("msg", "此天数已经添加");
			render("../msg.jsp");
			return;
		}
		String statusPic;
		Record huaiyunRemind = new RecordBean();
		if (uFile != null) {
			statusPic = S.oid();
			huaiyunRemind.set("statusPic", statusPic);
			File file = new File("F:/yunyu/" + statusPic + ".png");
			uFile.getFile().renameTo(file);
		}
		String talk = getPara("talk");
		huaiyunRemind.set("day", day);
		huaiyunRemind.set("talk", talk);
		Db.save("beiyunCareRemind", huaiyunRemind);
		setAttr("msg", "添加成功");
		render("../msg.jsp");
	}

	public void modHuaiyun() {
		UploadFile uFile = getFile("statusPic");
		String id = getPara("id");
		String week = getPara("week");
		Record rd = Db.findFirst(
				"select * from huaiyunCareRemind where week=?", week);
		if (rd != null) {
			String idt = rd.get("id") + "";
			if (!id.equals(idt)) {// 当前的id不等于当前周数的id 说明已经有此周
				setAttr("msg", "此周已经添加");
				render("../msg.jsp");
				return;
			}
		}
		String statusPic;
		Record huaiyunRemind = new RecordBean();
		if (uFile != null) {
			statusPic = S.oid();
			huaiyunRemind.set("statusPic", statusPic);
			File file = new File("F:/yunyu/" + statusPic + ".png");
			uFile.getFile().renameTo(file);
		}

		String talk = getPara("talk");
		huaiyunRemind.set("id", id);
		huaiyunRemind.set("week", week);
		huaiyunRemind.set("talk", talk);
		Db.update("huaiyunCareRemind", huaiyunRemind);
		setAttr("msg", "修改成功");
		render("../msg.jsp");
	}

	public void modBeiyun() {
		UploadFile uFile = getFile("statusPic");
		String id = getPara("id");
		int day = getParaToInt("day");
		Record rd = Db.findFirst("select * from beiyunCareRemind where day=?",
				day);
		if (rd != null) {
			String idt = rd.get("id") + "";
			if (!id.equals(idt)) {// 当前的id不等于当前周数的id 说明已经有此周
				setAttr("msg", "此天已经添加");
				render("../msg.jsp");
				return;
			}
		}
		String statusPic;
		Record huaiyunRemind = new RecordBean();
		if (uFile != null) {
			statusPic = S.oid();
			huaiyunRemind.set("statusPic", statusPic);
			File file = new File("F:/yunyu/" + statusPic + ".png");
			uFile.getFile().renameTo(file);
		}

		String talk = getPara("talk");
		huaiyunRemind.set("id", id);
		huaiyunRemind.set("day", day);
		huaiyunRemind.set("talk", talk);
		Db.update("beiyunCareRemind", huaiyunRemind);
		setAttr("msg", "修改成功");
		render("../msg.jsp");
	}

	public void deleteBeiyunCareRemindById() {
		String id = getPara("id");
		Db.deleteById("beiyunCareRemind", id);
		renderText("删除成功");
	}

	public void deleteHuaiyunCareRemindById() {
		String id = getPara("id");
		Db.deleteById("huaiyunCareRemind", id);
		renderText("删除成功");
	}

	public void getHomeMenuById() {
		String id = getPara("id");
		Record record = Db.findById("homemenu_content", id);
		renderJson(record);
	}

	public void getWeeks() {
		M m = null;
		List<M> weekList = new ArrayList<M>();
		for (int i = 0; i < 51; i++) {
			m = new M();
			m.put("name", "第" + i + "周");
			m.put("value", i);
			weekList.add(m);
		}
		renderJson(weekList);
	}

	public void getDays() {
		M m = null;
		List<M> weekList = new ArrayList<M>();
		for (int i = 1; i < 51; i++) {
			m = new M();
			m.put("name", "第" + i + "天");
			m.put("value", i);
			weekList.add(m);
		}
		renderJson(weekList);
	}
}
