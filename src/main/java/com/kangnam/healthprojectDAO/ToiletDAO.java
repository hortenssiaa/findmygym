package com.kangnam.healthprojectDAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ToiletDAO {

	public ArrayList<String> searchCity(String city) {
		ArrayList<String> list = new ArrayList<String>(); 
		
		try {
			String sql = "select distinct pt_city from toilet " +
						"where pt_city like '%' || ? || '%' " + 
						"order by pt_city ";
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			
			PreparedStatement pt = con.prepareStatement(sql);
			
			pt.setString(1, city);
			
			ResultSet rs = pt.executeQuery();
			
			while(rs.next()) {
				String towns = rs.getString("pt_city");
				list.add(towns);
			}
			
			pt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
