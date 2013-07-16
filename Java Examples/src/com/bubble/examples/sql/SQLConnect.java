import java.sql.*;

public class SQLConnect 
{
        public static void main(String[] args) 
        {
                DB db = new DB();
                Connection conn=db.dbConnect(
                  "jdbc:mysql://localhost:3306/test", "root", "");
        }

}

class DB
{
        public DB() {}

        public Connection dbConnect(String db_connect_string,
          String db_userid, String db_password)
        {
                try
                {
                        Class.forName("com.mysql.jdbc.Driver").newInstance();
                        Connection conn = DriverManager.getConnection(
                          db_connect_string, db_userid, db_password);
      
                        System.out.println("connected");
                        return conn;
                        
                }
                catch (Exception e)
                {
                        e.printStackTrace();
                        return null;
                }
        }
};

