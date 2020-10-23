package com.kangnam.healthprojectDAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.kangnam.healthprojectVO.ToiletVO;

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
			
			rs.close();
			pt.close();
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	public ArrayList<ToiletVO> searchAddress(String town) {
		ArrayList<ToiletVO> list = new ArrayList<ToiletVO>(); 
		
		try {
			String sql = "select pt_city, pt_kind, pt_name, pt_addr1, pt_addr2, pt_m_handi1, pt_m_handi2, "
					+ "pt_f_handi, pt_tel, pt_time, pt_lat, pt_lng "
					+ "from toilet where pt_city = ? ";
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			
			PreparedStatement pt = con.prepareStatement(sql);
			
			pt.setString(1, town);
			
			ResultSet rs = pt.executeQuery();
			
			while(rs.next()) {
				ToiletVO vo = new ToiletVO();
				vo.setPt_city(rs.getString("pt_city"));
				vo.setPt_kind(rs.getString("pt_kind"));
				vo.setPt_name(rs.getString("pt_name"));
				vo.setPt_addr1(rs.getString("pt_addr1"));
				vo.setPt_addr2(rs.getString("pt_addr2"));
				vo.setPt_m_handi1(rs.getInt("pt_m_handi1"));
				vo.setPt_m_handi2(rs.getInt("pt_m_handi2"));
				vo.setPt_f_handi(rs.getInt("pt_f_handi"));
				vo.setPt_tel(rs.getString("pt_tel"));
				vo.setPt_time(rs.getString("pt_time"));
				vo.setPt_lat(rs.getString("pt_lat"));
				vo.setPt_lng(rs.getString("pt_lng"));
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
