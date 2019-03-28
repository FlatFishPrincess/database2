import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Demo4 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Connection conn = null;
		try {
			
			String dbUrl = "jdbc:sqlserver://localhost;"
						+ "instanceName=SQLEXPRESS;databaseName=university;"
						+ "user=sa;password=csis3300";
			
			conn = DriverManager.getConnection(dbUrl);
			Statement stmt = conn.createStatement();
			String sql = "select * from instructor";
			ResultSet rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				System.out.println(rs.getString(2));
			}
			
			String insertSql = "insert into instructor values(?,?,?,?)";
			PreparedStatement pStmt = conn.prepareStatement(insertSql);
			pStmt.setString(1, "88878");
			pStmt.setString(2, "Perry");
			pStmt.setString(3, "Finance");
			pStmt.setDouble(4, 125000);
			pStmt.executeUpdate();
			
			String whereSql = "select * from instructor where dept_name = ?";
			PreparedStatement pStmt = conn.prepareStatement(whereSql);
			pStmt.setString(1, "Finance");
			
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()) {
				System.out.println(rs.getString(2));
			}
		
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