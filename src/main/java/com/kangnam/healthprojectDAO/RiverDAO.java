package com.kangnam.healthprojectDAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.springframework.stereotype.Component;

import com.kangnam.healthprojectVO.RiverVO;

@Component("riverdao")
public class RiverDAO {
	
	public ArrayList<String> searchTown(String city) {
		ArrayList<String> list = new ArrayList<String>(); 
		
		try {
			String sql = "select distinct r_town from river " +
						"where r_city like '%' || ? || '%' " + 
						"order by r_town ";
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			
			PreparedStatement pt = con.prepareStatement(sql);
			
			pt.setString(1, city);
			
			ResultSet rs = pt.executeQuery();
			
			while(rs.next()) {
				String towns = rs.getString("r_town");
				list.add(towns);
			}
			
			rs.close();
			pt.close();
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	public ArrayList<RiverVO> searchDetails(String town) {
		ArrayList<RiverVO> list = new ArrayList<RiverVO>(); 
		
		try {
			String sql = "select r_name, r_addr, r_tel, "
					+ "r_lat, r_lng, r_park, r_baby, r_pet "
					+ "from river where r_town = ? ";
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			
			PreparedStatement pt = con.prepareStatement(sql);
			
			pt.setString(1, town);
			
			ResultSet rs = pt.executeQuery();
			
			while(rs.next()) {
				RiverVO vo = new RiverVO();
				vo.setR_name(rs.getString("r_name"));
				vo.setR_addr(rs.getString("r_addr"));
				vo.setR_tel(rs.getString("r_tel"));
				vo.setR_lat(rs.getString("r_lat"));
				vo.setR_lng(rs.getString("r_lng"));
				vo.setR_park(rs.getString("r_park"));
				vo.setR_baby(rs.getString("r_baby"));
				vo.setR_pet(rs.getString("r_pet"));
				list.add(vo);
			}
			
			rs.close();
			pt.close();
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
}
