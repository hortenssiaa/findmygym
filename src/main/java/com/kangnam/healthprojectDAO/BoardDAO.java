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
			String sql = "select seq, id, location, filepath, likes, caption from hboard ";

			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			PreparedStatement pt = con.prepareStatement(sql);
			ResultSet rs = pt.executeQuery();

			while(rs.next()) {
				BoardVO vo = new BoardVO();
				vo.setSeq(rs.getInt("seq"));
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
	
	
	public BoardVO getLikes(String likes, int seq) { // like 클릭시 마다 likes컬럼 1 증가/감소 해야함! -> update문
		BoardVO vo = new BoardVO();
		String sql1="", sql2="";

		try {
			if(likes.equals("1")) { // add likes
				sql1 = "select * from hboard " + "where seq= ? ";
				sql2 = "update hboard set likes = likes+1 where seq= ? ";
				System.out.println("(/getLikes) likes == 1");
			} 
			
			else if(likes.equals("0")) { // subtract likes
				sql1 = "select * from hboard " + "where seq= ? ";
				sql2 = "update hboard set likes = likes-1 where seq= ? ";
				System.out.println("(/getLikes) likes == 0");
			} 
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			PreparedStatement pt1 = con.prepareStatement(sql1);
			PreparedStatement pt2 = con.prepareStatement(sql2);

			pt1.setInt(1, seq);
			pt2.setInt(1, seq);

			// db 전송
			// update 문 먼저 실행 > select
			pt2.executeUpdate();
			ResultSet rs = pt1.executeQuery();

			if (rs.next()) {
				vo.setSeq(rs.getInt("seq"));
				vo.setLikes(rs.getInt("likes"));
			}

			rs.close();
			pt2.close();
			pt1.close();
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return vo;
	}
}
