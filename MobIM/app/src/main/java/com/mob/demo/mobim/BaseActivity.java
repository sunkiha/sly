package com.mob.demo.mobim;

import android.Manifest;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.support.annotation.LayoutRes;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.ActivityCompat;
import android.support.v4.app.FragmentActivity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.widget.Toast;

import java.util.ArrayList;

public class BaseActivity extends FragmentActivity {

	protected void onCreate(@Nullable Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		if (Build.VERSION.SDK_INT >= 21) {//状态栏全透明
			Window window = getWindow();
			window.clearFlags(0x04000000                                  // LayoutParams.FLAG_TRANSLUCENT_STATUS
					| 0x08000000);                                        // LayoutParams.FLAG_TRANSLUCENT_NAVIGATION
			window.getDecorView().setSystemUiVisibility(0x00000400        // View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
					| 0x00000200                                          // View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
					| 0x00000100);                                        // View.SYSTEM_UI_FLAG_LAYOUT_STABLE
			window.addFlags(0x80000000);                                  // LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS
		}
	}

	public void setContentView(@LayoutRes int layoutResID) {
		View view = LayoutInflater.from(this).inflate(layoutResID, null);
		setContentView(view);
	}

	public void setContentView(View view) {
		super.setContentView(view);
		view.setFitsSystemWindows(true);
	}

	/* 检查使用权限 */
	protected void checkPermissions() {
		//检查权限（NEED_PERMISSION）是否被授权 PackageManager.PERMISSION_GRANTED表示同意授权
		if (ActivityCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE)
				!= PackageManager.PERMISSION_GRANTED) {
			//用户已经拒绝过一次，再次弹出权限申请对话框需要给用户一个解释
			if (ActivityCompat.shouldShowRequestPermissionRationale(this, Manifest.permission
					.WRITE_EXTERNAL_STORAGE)) {
				Toast.makeText(this, "请开通相关权限，否则无法正常使用本应用！", Toast.LENGTH_SHORT).show();
			}
			//申请权限
			ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE}, 1);

		} else {
			Toast.makeText(this, "授权成功！", Toast.LENGTH_SHORT).show();

		}
		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
			try {
				PackageManager pm = getPackageManager();
				PackageInfo pi = pm.getPackageInfo(getPackageName(), PackageManager.GET_PERMISSIONS);
				ArrayList<String> list = new ArrayList<String>();
				for (String p : pi.requestedPermissions) {
					if (checkSelfPermission(p) != PackageManager.PERMISSION_GRANTED) {
						list.add(p);
					}
				}
				if (list.size() > 0) {
					String[] permissions = list.toArray(new String[list.size()]);
					if (permissions != null) {
						requestPermissions(permissions, 1);
					}
				}
			} catch (Throwable t) {
				t.printStackTrace();
			}
		}
	}

	@Override
	public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
		super.onRequestPermissionsResult(requestCode, permissions, grantResults);
		try {
			if (permissions != null && permissions.length > 0) {
				StringBuilder sb = null;
				String permission;
				for (int i = 0; i < permissions.length; i++) {
					if (grantResults[i] == PackageManager.PERMISSION_GRANTED) {
						continue;
					}
					if (sb == null) {
						sb = new StringBuilder();
					}
					permission = permissions[i];
				}
				if (sb != null) {
					//toast 提示用户已经禁用了必要的权限，然后去权限中心打开即可
					Toast.makeText(getApplication(), R.string.toast_permission_deny, Toast.LENGTH_SHORT).show();
				}
			}
		} catch (Throwable t) {
			t.printStackTrace();
		}
	}
}
