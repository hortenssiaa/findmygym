package com.kangnam.healthprojectDAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.springframework.stereotype.Component;

import com.kangnam.healthprojectVO.MountVO;

@Component("mountdao")
public class MountDAO {

	public ArrayList<String> searchTown(String city) {
		ArrayList<String> list = new ArrayList<String>(); 
		
		try {
			String sql = "select distinct mt_town from mount " +
						"where mt_city like '%' || ? || '%' " + 
						"order by mt_town ";
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			
			PreparedStatement pt = con.prepareStatement(sql);
			
			pt.setString(1, city);
			
			ResultSet rs = pt.executeQuery();
			
			while(rs.next()) {
				String towns = rs.getString("mt_town");
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

	public ArrayList<MountVO> searchDetails(String town) {
		ArrayList<MountVO> list = new ArrayList<MountVO>(); 
		
		try {
			String sql = "select mt_name, mt_addr, mt_tel, "
					+ "mt_lat, mt_lng, mt_park, mt_baby, mt_pet "
					+ "from mount where mt_town = ? ";
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			
			PreparedStatement pt = con.prepareStatement(sql);
			
			pt.setString(1, town);
			
			ResultSet rs = pt.executeQuery();
			
			while(rs.next()) {
				MountVO vo = new MountVO();
				vo.setMt_name(rs.getString("mt_name"));
				vo.setMt_addr(rs.getString("mt_addr"));
				vo.setMt_tel(rs.getString("mt_tel"));
				vo.setMt_lat(rs.getString("mt_lat"));
				vo.setMt_lng(rs.getString("mt_lng"));
				vo.setMt_park(rs.getString("mt_park"));
				vo.setMt_baby(rs.getString("mt_baby"));
				vo.setMt_pet(rs.getString("mt_pet"));
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
