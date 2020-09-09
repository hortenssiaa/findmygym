package com.kangnam.healthprojectDAO;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kangnam.healthprojectVO.MemberVO;


@Component("dao")
public class MemberDAO {
	
	public String insertMember(MemberVO vo, String photopath2) {
		String result = ""; // 성공 유무 리턴 
		try {
			String sql = "insert into member2 values( " 
					+ "?, ?, ?, ?, ?, sysdate) " ;
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			PreparedStatement pt = con.prepareStatement(sql);
			
			pt.setString(1, vo.getName());
			pt.setString(2, vo.getId());
			pt.setString(3, vo.getPassword());
			pt.setString(4, vo.getEmail());
			pt.setString(5, photopath2);
			
			int insertRow = pt.executeUpdate();
			
			if (insertRow == 1) {
				result = "insert 성공했습니다.";
			} else {
				result = "insert 에러";
			}
			pt.close();
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	} // insertMember end

	public boolean checkidpassword(String id, String password) {
		boolean flag = false;
		try {
			String sql = "select id, password from member2 " 
					+ "where id = ? " ;
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			PreparedStatement pt = con.prepareStatement(sql);
			
			pt.setString(1, id);
			
			ResultSet rs = pt.executeQuery();
			
			while(rs.next()) {
				String dbid = rs.getString("id");
				String dbpw = rs.getString("password");
				
//				if(dbid == null) {
//					System.out.printf("dbid: %s -> Non-Exist ID", dbid);
//					return flag;
//				}
				
				if(id.equals(dbid) && password.equals(dbpw)) {
//					System.out.printf("(got) %s:%s , (db) %s:%s\n", id, password, dbid, dbpw);
					flag = true;
				} else { 
					System.out.print("password 불일치 >> ");
					System.out.printf("(got) %s:%s , (db) %s:%s\n", id, password, dbid, dbpw);
					flag = false;
				}
			}
			
			rs.close();
			pt.close();
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return flag;
	} // checkpassword end

	public String getFilePath(String id) {
		String filepath = "";
		
		try {
			String sql = "select filepath from member2 " 
					+ "where id = ? " ;
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			PreparedStatement pt = con.prepareStatement(sql);
			
			pt.setString(1, id);
			
			ResultSet rs = pt.executeQuery();
			
			while(rs.next()) {
				filepath = rs.getString("filepath");
			}
			System.out.printf("DAO filepath : %s\n", filepath);
			
			rs.close();
			pt.close();
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return filepath;
	}
	
	public MemberVO getMemberinfo(String id) {
		MemberVO vo = new MemberVO();
		
		try {
			String sql = "select name, id, filepath from member2 " 
					+ "where id = ? " ;
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			PreparedStatement pt = con.prepareStatement(sql);
			
			pt.setString(1, id);
			
			ResultSet rs = pt.executeQuery();
			
			while(rs.next()) {
				vo.setName(rs.getString("name"));
				vo.setId(rs.getString("id"));
				vo.setFilepath(rs.getString("filepath"));
			}
			System.out.println("DAO getMemberinfo here");
			
			rs.close();
			pt.close();
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return vo;
	}

	

}
