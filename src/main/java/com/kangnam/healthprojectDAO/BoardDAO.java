package com.kangnam.healthprojectDAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Map;

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
	
	
	public BoardVO getLikes(String likes, int seq, String id) { // like 클릭시 마다 likes컬럼 1 증가/감소 해야함! -> update문
		BoardVO vo = new BoardVO();
		String sql1="", sql2="", sql3="";

		try {
			if(likes.equals("1")) { // like
				sql1 = "select * from hboard " + "where seq= ? ";
				sql2 = "update hboard set likes = likes+1 where seq= ? ";
				sql3 = "insert into hlikes values( ?, ? ) ";
				System.out.println("(/getLikes) likes == 1");
			} 
			
			else if(likes.equals("0")) { // dislike
				sql1 = "select * from hboard " + "where seq= ? ";
				sql2 = "update hboard set likes = likes-1 where seq= ? ";
				sql3 = "delete from hlikes where id= ? and seq= ? ";
				System.out.println("(/getLikes) likes == 0");
			} 
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			PreparedStatement pt1 = con.prepareStatement(sql1);
			PreparedStatement pt2 = con.prepareStatement(sql2);
			PreparedStatement pt3 = con.prepareStatement(sql3);

			pt1.setInt(1, seq);
			pt2.setInt(1, seq);
			pt3.setString(1, id);
			pt3.setInt(2, seq);

			// db 전송
			// update 문 먼저 실행 > select
			pt2.executeUpdate();
			pt3.executeUpdate();
			
			ResultSet rs = pt1.executeQuery();

			if (rs.next()) {
				vo.setSeq(rs.getInt("seq"));
				vo.setLikes(rs.getInt("likes"));
				vo.setId(rs.getString("id"));
			}

			rs.close();
			pt3.close();
			pt2.close();
			pt1.close();
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return vo;
	}

	
	public ArrayList<BoardVO> getlikedinfo() { // like 클릭시 마다 likes컬럼 1 증가/감소 해야함! -> update문
		ArrayList<BoardVO> boardlist = new ArrayList<BoardVO>();
		
		try {
				String sql = "select id, seq from hlikes where id= 'test8' ";
//				String sql = "select hl.id as id, hl.seq as seq, hb.likes as likes, " +
//						"hb.location as location, hb.filepath as filepath, hb.caption as caption " + 
//						"from hboard hb, hlikes hl " + 
//						"where hb.seq = hl.seq " + 
//						"and hl.id = ? ";
		
				Class.forName("oracle.jdbc.driver.OracleDriver");
				Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
				PreparedStatement pt = con.prepareStatement(sql);
				
//				pt.setString(1, (String)session.getAttribute("loginid"));
				System.out.printf("(DAO getlikedinfo) session id :%s\n",(String)session.getAttribute("loginid"));
				
				ResultSet rs = pt.executeQuery();
//				System.out.println(rs.next());
		
				while(rs.next()) {
					System.out.println("(DAO getBoardDetail) 3");
					BoardVO vo = new BoardVO();
					vo.setId(rs.getString("id"));
					vo.setSeq(rs.getInt("seq"));
//					vo.setLikes(rs.getInt("likes"));
//					vo.setLocation(rs.getString("location"));
//					vo.setFilepath(rs.getString("filepath"));
//					vo.setCaption(rs.getString("caption"));
					boardlist.add(vo);
				}
				
				System.out.printf("boardlist.size :%d\n", boardlist.size());
				for(int i=0; i<boardlist.size(); i++) {
					System.out.printf("%d: %s\n\n", i, boardlist.get(i));
				}
				
				rs.close();
				pt.close();
				con.close();
	
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return boardlist;
	}
}

