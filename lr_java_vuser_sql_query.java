import java.sql.*;
import lrapi.lr;

public class Actions{
  public int init() throws Throwable{
    return 0;
  }
  
  public int action() throws Throwable{
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://address:port/database", "username", "password");
    if(!conn.isClosed()){
      System.out.println("Successfully connected to database!");
    }
    Statement statement = conn.createStatement();
    
    lr.start_transaction("query");
    String sql_command = "SELECT * FROM column WHERE QUERYTIME='<querytime>'";
    ResultSet res = statement.executeQuery(sql_command);
    while(res.next()){
      System.out.println(res.getString("QUERYTIME")+"\t"+res.getString("QUERYNO"));
    }
    conn.close();
    lr.end_transaction("query", lr.AUTO);
    return 0;
  }
  
  public int end() throws Throwable{
    return 0;
  }
}
