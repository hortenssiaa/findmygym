package com.kangnam.healthprojectDAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.springframework.stereotype.Component;

import com.kangnam.healthprojectVO.WorkoutVO;

@Component("workoutdao")
public class WorkoutDAO {

	public ArrayList<String> searchTown(String city) {
		ArrayList<String> list = new ArrayList<String>(); 
		
		try {
			String sql = "select distinct wo_town from workout " +
						"where wo_city like '%' || ? || '%' " + 
						"order by wo_town ";
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			
			PreparedStatement pt = con.prepareStatement(sql);
			
			pt.setString(1, city);
			
			ResultSet rs = pt.executeQuery();
			
			while(rs.next()) {
				String towns = rs.getString("wo_town");
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

	public ArrayList<WorkoutVO> searchDetails(String town) {
		ArrayList<WorkoutVO> list = new ArrayList<WorkoutVO>(); 
		
		try {
			String sql = "select wo_name, wo_addr, wo_kind, wo_city, wo_town, "
					+ "wo_lat, wo_lng, wo_admin "
					+ "from workout where wo_town = ? ";
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			
			PreparedStatement pt = con.prepareStatement(sql);
			
			pt.setString(1, town);
			
			ResultSet rs = pt.executeQuery();
			
			while(rs.next()) {
				WorkoutVO vo = new WorkoutVO();
				vo.setWo_name(rs.getString("wo_name"));
				vo.setWo_addr(rs.getString("wo_addr"));
				vo.setWo_kind(rs.getString("wo_kind"));
				vo.setWo_city(rs.getString("wo_city"));
				vo.setWo_town(rs.getString("wo_town"));
				vo.setWo_lat(rs.getString("wo_lat"));
				vo.setWo_lng(rs.getString("wo_lng"));
				vo.setWo_admin(rs.getString("wo_admin"));
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
