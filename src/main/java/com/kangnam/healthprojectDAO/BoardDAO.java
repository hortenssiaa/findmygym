package com.kangnam.healthprojectDAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.kangnam.healthprojectVO.BoardVO;

@Component("boarddao")
public class BoardDAO {
	@Autowired
	HttpSession session;
	
	public String insertBoard(BoardVO vo, String photopath_server) {
		String result="";
		System.out.println("BoardDAO insertBoard() started!!!");
		try {
			String sql = "insert into hboard (SEQ, LOCATION, LIKES, "
						+ "TIME, HITS, CAPTION, FILEPATH, ID) "
						+ "values((select nvl(max(seq),0)+1 from hboard), ?, 0, "
						+ "sysdate, 0, ?, ?, ? ) ";

			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			PreparedStatement pt = con.prepareStatement(sql);
			System.out.printf("( Board insertBoard() ) loginid :%s\n",(String)session.getAttribute("loginid"));

			pt.setString(1, vo.getLocation());
			pt.setString(2, vo.getCaption());
			pt.setString(3, photopath_server);
			pt.setString(4, (String)session.getAttribute("loginid"));

			int insertRow = pt.executeUpdate();

			if (insertRow == 1) {
				result = "insertBoard has been succeeded.";
			} else {
				result = "insertBoard failed.";
			}
			pt.close();
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	} // insertBoard end 

	
	public ArrayList<BoardVO> getBoardDetail() {
		ArrayList<BoardVO> boardlist = new ArrayList<BoardVO>();
		
		System.out.println("\nBoardDAO getBoardDetail() started!!!");
		try {
			String sql = "select id, location, filepath, likes, caption from hboard ";

			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			PreparedStatement pt = con.prepareStatement(sql);
			ResultSet rs = pt.executeQuery();

			while(rs.next()) {
				BoardVO vo = new BoardVO();
				vo.setId(rs.getString("id"));
				vo.setLocation(rs.getString("location"));
				vo.setFilepath(rs.getString("filepath"));
				vo.setLikes(rs.getInt("likes"));
				vo.setCaption(rs.getString("caption"));
				boardlist.add(vo);
			}

			rs.close();
			pt.close();
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return boardlist;
	} // getBoardDetail end 
	
}
