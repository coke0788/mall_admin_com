package gdu.mall.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {

	//db 연결 메소드
		public static Connection getConnection() throws Exception{
			Class.forName("org.mariadb.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/mall","root","java1004");
			return conn;
		}
}
