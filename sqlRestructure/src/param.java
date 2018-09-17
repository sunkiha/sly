import java.io.InputStreamReader;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class param {
	public static void main(String[] args) {
		/*
		 * FileReader fr; try { fr = new
		 * FileReader(sqlSuper.class.getClassLoader
		 * ().getResource("/").getPath()); int ch = 0; while((ch =
		 * fr.read())!=-1 ){ System.out.print( (char)ch ); } } catch (Exception
		 * e) { e.printStackTrace(); }
		 */
		try {
			// InputStream is = new FileInputStream("d:a.text");
			InputStreamReader fr = new InputStreamReader(param.class
					.getClassLoader().getResourceAsStream("param.txt"));
			StringBuffer sb = new StringBuffer();
			int ch = 0;
			while ((ch = fr.read()) != -1) {
				sb.append((char) ch);
			}
			String s = sb.toString();
			String[] sz=s.split(",");
			//String[] sz2=sz[0].split(" ");
			//System.out.println(sz2[1]);
			for (int i = 0; i < sz.length; i++) {
				String a=sz[i].split(" ")[1];
				if(i!=sz.length-1)
				 System.out.println("param.put(\""+a+"\","+a+"),");
				else
				 System.out.println("param.put(\""+a+"\","+a+")");
			}
			
			/*String tableName = s.substring(s.indexOf(".") + 1, s.indexOf("("))
					.replace("`", "");
			String elements = s.substring(s.indexOf("(") + 1, s.indexOf(")"))
					.replace("`", "");*/
			//elements = getStringToNormall(elements);
			//String[] es = elements.split(",");
			 //insert(tableName, es);
			//System.out.println();
			//update(tableName, es);
			//System.out.println();
			//select(tableName, es);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// Scanner in = new Scanner(System.in);
		// String input = in.nextLine();
		// System.out.println(input);
		// String
		// element=input.substring(input.indexOf("("),input.indexOf(")")).replace("`",
		// "");
		// System.out.println(element);
	}

	private static void select(String tableName, String[] es) {
		System.out.println("\tselect ");
		for (int i = 0; i < es.length; i++) {
			String d = es[i];
			System.out.println("\t\t" + d);
		}
		System.out.println("\tfrom "+tableName);
		
	}

	private static void update(String tableName, String[] es) {
		System.out.println("\tupdate " + tableName + " set");
		for (int i = 0; i < es.length; i++) {
			String d = es[i];
			if (i < es.length - 1) {
				System.out.println("\t\t" + d + "=#" + d + "#,");
			} else {
				System.out.println("\t\t" + d + "=#" + d + "#");
			}
		}
		System.out.println("\twhere " + es[0] + "=#" + es[0]);

	}

	public static void insert(String tableName, String[] es) {
		System.out.println("\tinsert into " + tableName + "(");
		for (int i = 0; i < es.length; i++) {
			String d = es[i];
			if(i!=es.length-1)
			System.out.println("\t\t" + d+",");
			else
				System.out.println("\t\t" + d);
		}
		System.out.println("\t\t)");
		System.out.println("\t values (");
		for (int i = 0; i < es.length; i++) {
			String d = es[i];
			if(i!=es.length-1)
			System.out.println("\t\t#" + d + "#,");
			else
			 System.out.println("\t\t#" + d + "#");
		}
		System.out.println("\t )");
	}

	public static String getStringToNormall(String str) {
		Pattern p2 = Pattern.compile("\\s*|\t|\r|\n");
		Matcher m = p2.matcher(str);
		return m.replaceAll("");
	}
}
