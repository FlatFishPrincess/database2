import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Demo2 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Connection conn = null;
		try {
			String dbUrl = "jdbc:sqlserver://localhost;"
						+ "instanceName=SQLEXPRESS;databaseName=university;"
						+ "user=sa;password=csis3300";
			conn = DriverManager.getConnection(dbUrl);
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select * from instructor");
			while(rs.next()) {
				System.out.println(rs.getString(1) + " " + rs.getString(2));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(conn != null && !conn.isClosed()) {
					conn.close();
				}
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
