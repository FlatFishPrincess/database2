import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Demo3 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Connection conn = null;
		try {
			
			String dbUrl = "jdbc:sqlserver://localhost;"
						+ "instanceName=SQLEXPRESS;databaseName=university;"
						+ "user=sa;password=csis3300";
			conn = DriverManager.getConnection(dbUrl);
			
			String selectQuery = "select * from instructor where dept_name = ?";
			PreparedStatement pStmt = conn.prepareStatement(selectQuery);
			pStmt.setString(1, "Biology");
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()) {
				System.out.println(rs.getString(1) + " " + rs.getString(2));
			}
			
//			String insertQuery = "insert into instructor values(?,?,?,?)";
//			PreparedStatement pStmt = conn.prepareStatement(insertQuery);
//			pStmt.setString(1, "88888");
//			pStmt.setString(2, "2222");
//			pStmt.setString(3, "Finance");
//			pStmt.setDouble(4, 125000);
//			pStmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}

}