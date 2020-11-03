package com.kangnam.healthprojectDAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.springframework.stereotype.Component;

import com.kangnam.healthprojectVO.ParkVO;

@Component("parkdao")
public class ParkDAO {

	public ArrayList<String> searchTown(String city) {
ArrayList<String> list = new ArrayList<String>(); 
		
		try {
			String sql = "select distinct pk_city from park " +
						"where pk_city like '%' || ? || '%' " + 
						"order by pk_city ";
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			
			PreparedStatement pt = con.prepareStatement(sql);
			
			pt.setString(1, city);
			
			ResultSet rs = pt.executeQuery();
			
			while(rs.next()) {
				String towns = rs.getString("pk_city");
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

	public ArrayList<ParkVO> searchDetails(String town) {
		ArrayList<ParkVO> list = new ArrayList<ParkVO>(); 
		
		try {
			String sql = "select pk_city, pk_name, pk_kind, pk_addr, "
					+ "pk_tel, pk_lat, pk_lng, etc1, etc2, etc3, etc4  "
					+ "from park where pk_city = ? ";
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			
			PreparedStatement pt = con.prepareStatement(sql);
			
			pt.setString(1, town);
			
			ResultSet rs = pt.executeQuery();
			
			while(rs.next()) {
				ParkVO vo = new ParkVO();
				vo.setPk_city(rs.getString("pk_city"));
				vo.setPk_name(rs.getString("pk_name"));
				vo.setPk_kind(rs.getString("pk_kind"));
				vo.setPk_addr(rs.getString("pk_addr"));
				vo.setPk_tel(rs.getString("pk_tel"));
				vo.setPk_lat(rs.getString("pk_lat"));
				vo.setPk_lng(rs.getString("pk_lng"));
				vo.setEtc1(rs.getString("etc1"));
				vo.setEtc2(rs.getString("etc2"));
				vo.setEtc3(rs.getString("etc3"));
				vo.setEtc4(rs.getString("etc4"));
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
