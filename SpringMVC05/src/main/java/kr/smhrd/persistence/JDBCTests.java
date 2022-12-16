package kr.smhrd.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import lombok.Setter;

public class JDBCTests {


	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	@Test
	public void testConnection() {
		
		try(Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/com",
				"com", "com01")){
			System.out.println(con);
		}catch (Exception e) {
			fail(e.getMessage());
		};
	}
	

}
