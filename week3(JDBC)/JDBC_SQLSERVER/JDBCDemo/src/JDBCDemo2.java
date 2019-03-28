import java.sql.*;

// In this demo, we show how to what?
public class JDBCDemo2 {

	public static void main(String[] args) {

		// Initialize the connection
		Connection conn = null;
		try {
			
			String dbURL = "jdbc:sqlserver://localhost;" + 
						"instanceName=SQLEXPRESS;databaseName=university;" + 
						"user=sa;password=csis3300";
			
			// Establish the connection
			conn = DriverManager.getConnection(dbURL);
			if(conn != null) {
				
				// create a prepared statement object 
//				PreparedStatement prepStmt = null;
//				// create a SQL query teplate
//				String selectSQL = "select ID, name from instructor where dept_name = ?";
//				
//				prepStmt = conn.prepareStatement(selectSQL);
//				prepStmt.setString(1, "Biology");
//				
//				ResultSet rs;
//				// let's try a simple SQL query
//				rs = prepStmt.executeQuery();
//				while(rs.next()) {
//					
//					// Retrieve the information by using column index
//					// column number start from 1, not ZERO!!!
//					System.out.println(rs.getString(1) + " " + rs.getString(2));
//				}
//				
				//another example of prepared statement with multiple parameter
				PreparedStatement prepStmt2 = null;
				String insertSQL = "insert into instructor values(?,?,?,?)";
				prepStmt2 = conn.prepareStatement(insertSQL);
				prepStmt2.setString(1, "88888");
				prepStmt2.setString(2, "Perry");
				prepStmt2.setString(3, "Finance");
				prepStmt2.setDouble(4, 125000);
				prepStmt2.executeUpdate();
				//since we just update and not return anything, get an error but still works
				
			} // handle any errors that may happen
		} catch(SQLException ex) {
			ex.printStackTrace();
		} finally {
			// close the connection
			try {
				if(conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch(SQLException ex) {
				ex.printStackTrace();
			}
		}
	}
}
