import java.io.*;
import java.sql.*;
import java.sql.CallableStatement;

public class PublisherIs {

	Connection con;

	public PublisherIs() {

		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		String userid = "c##mmadang";
		String pwd = "madang";

		try { /* 드라이버를 찾는 과정 */
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("드라이버 로드 성공");
		} catch(ClassNotFoundException e) {
			e.printStackTrace();

		}try { /* 데이터베이스를 연결하는 과정 */
			System.out.println("데이터베이스 연결 준비...");
			con=DriverManager.getConnection(url, userid, pwd);
			System.out.println("데이터베이스 연결 성공");
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}

	private void sqlRun() {

		String query="select bookname, price from book where publisher is '이상미디어'"; /* SQL 문*/
		try { /* 데이터베이스에 질의 결과를 가져오는 과정*/
			Statement stmt=con.createStatement();
			ResultSet rs=stmt.executeQuery(query);

			while(rs.next()) {
				System.out.print(" " +rs.getString(1));
				System.out.println(" " +rs.getInt(2));
				//System.out.print("\t\t\t"+rs.getString(3));
				//System.out.println("\t\t"+rs.getInt(4));
			} con.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}

	public static void main(String args[]) {

		PublisherIs pb = new PublisherIs();
		pb.sqlRun();
	}
}