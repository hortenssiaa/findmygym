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
				String sql = "select seq, id, location, filepath, likes, caption from hboard order by time asc ";
	
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
				
				// 내용 확인 
//				System.out.printf("(DAO getBoardDetail) boardlist.size :%d\n", boardlist.size());
//				for(int i=0; i<boardlist.size(); i++) {
//					System.out.printf("%d: %s\n\n", i, boardlist.get(i));
//				}
	
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
	
	public void getBookMark(String bm_status, int seq, String id) { 
		
		// bookmark 클릭시 마다 bookmark컬럼 1 증가/감소 해야함! -> update문
		// getBookMark는 getLikes와 다르게, 수 표시 안해도 되기 때문에, VO받아오지않고 void로 return type 정함
		// VO 추가 해야한댜면, getLikes() 코드 참고할 것 
		
		String sql1="", sql2="";
		
		try {
			if(bm_status.equals("1")) { // book mark
				sql1 = "update hboard set BOOKMARK = BOOKMARK+1 where seq= ? ";
				sql2 = "insert into hbookmark values( ?, ? ) ";
				System.out.println("(/getBookMark) bm_status == 1");
			} 
			
			else if(bm_status.equals("0")) { // non book mark
				sql1 = "update hboard set BOOKMARK = BOOKMARK-1 where seq= ? ";
				sql2 = "delete from hbookmark where id= ? and seq= ? ";
				System.out.println("(/getBookMark) bm_status == 0");
			} 
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			PreparedStatement pt1 = con.prepareStatement(sql1);
			PreparedStatement pt2 = con.prepareStatement(sql2);
			
			pt1.setInt(1, seq);
			pt2.setString(1, id);
			pt2.setInt(2, seq);
			
			// db 전송
			// update 문 먼저 실행 > select
			pt1.executeUpdate();
			pt2.executeUpdate();
			
			pt2.close();
			pt1.close();
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	
	public ArrayList<BoardVO> getlikedinfo() { // like 클릭시 마다 likes컬럼 1 증가/감소 해야함! -> update문
		ArrayList<BoardVO> boardlist = new ArrayList<BoardVO>();

		String loginid = (String)session.getAttribute("loginid");
		System.out.printf("(DAO getlikedinfo) session id :%s\n",(String)session.getAttribute("loginid"));
		
		try {
				String sql = "select id, seq from hlikes where id= ? ";
//				String sql = "select hl.id as id, hl.seq as seq, hb.likes as likes, " +
//						"hb.location as location, hb.filepath as filepath, hb.caption as caption " + 
//						"from hboard hb, hlikes hl " + 
//						"where hb.seq = hl.seq " + 
//						"and hl.id = ? ";
		
				Class.forName("oracle.jdbc.driver.OracleDriver");
				Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
				PreparedStatement pt = con.prepareStatement(sql);
				
				pt.setString(1, loginid);
				
				ResultSet rs = pt.executeQuery();
//				System.out.println(rs.next());
		
				while(rs.next()) {
					BoardVO vo = new BoardVO();
					vo.setId(rs.getString("id"));
					vo.setSeq(rs.getInt("seq"));
//					vo.setLikes(rs.getInt("likes"));
//					vo.setLocation(rs.getString("location"));
//					vo.setFilepath(rs.getString("filepath"));
//					vo.setCaption(rs.getString("caption"));
					boardlist.add(vo);
				}
				
				// liked 게시물 정보 표시 
//				System.out.printf("boardlist.size :%d\n", boardlist.size());
//				for(int i=0; i<boardlist.size(); i++) {
//					System.out.printf("%d: %s\n\n", i, boardlist.get(i));
//				}
				
				rs.close();
				pt.close();
				con.close();
	
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return boardlist;
	}

	public ArrayList<BoardVO> getBookmarkInfo() { // like 클릭시 마다 likes컬럼 1 증가/감소 해야함! -> update문
		ArrayList<BoardVO> boardlist = new ArrayList<BoardVO>();
		
		String loginid = (String)session.getAttribute("loginid");
		System.out.printf("(DAO getBookmarkInfo) session id :%s\n",(String)session.getAttribute("loginid"));
		
		try {
			String sql = "select id, seq from hbookmark where id= ? ";
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			PreparedStatement pt = con.prepareStatement(sql);
			
			pt.setString(1, loginid);
			
			ResultSet rs = pt.executeQuery();
			
			while(rs.next()) {
				//System.out.println("(DAO getBookmarkInfo) #3단계");
				BoardVO vo = new BoardVO();
				vo.setId(rs.getString("id"));
				vo.setSeq(rs.getInt("seq"));
//					vo.setLikes(rs.getInt("likes"));
//					vo.setLocation(rs.getString("location"));
//					vo.setFilepath(rs.getString("filepath"));
//					vo.setCaption(rs.getString("caption"));
				boardlist.add(vo);
			}
			
			// Bookmarked 게시물 정보 표시 
//				System.out.printf("boardlist.size :%d\n", boardlist.size());
//				for(int i=0; i<boardlist.size(); i++) {
//					System.out.printf("%d: %s\n\n", i, boardlist.get(i));
//				}
			
			rs.close();
			pt.close();
			con.close();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return boardlist;
	}

	public ArrayList<BoardVO> getMyBookmarkInfo() { // like 클릭시 마다 likes컬럼 1 증가/감소 해야함! -> update문
		ArrayList<BoardVO> boardlist = new ArrayList<BoardVO>();
		
		String loginid = (String)session.getAttribute("loginid");
		System.out.printf("(DAO getMyBookmarkInfo) session id :%s\n",(String)session.getAttribute("loginid"));
		
		try {
			String sql = "select hbm.id id, hbm.seq seq, hb.likes likes, hb.location location, " +
						"hb.filepath filepath, hb.caption caption " + 
						"from hboard hb join hbookmark hbm " + 
						"on hb.seq = hbm.seq " + 
						"and hbm.id = ? ";
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			PreparedStatement pt = con.prepareStatement(sql);
			
			pt.setString(1, loginid);
			
			ResultSet rs = pt.executeQuery();
			
			while(rs.next()) {
//				System.out.println("(DAO getMyBookmarkInfo) #3단계");
				BoardVO vo = new BoardVO();
				vo.setId(rs.getString("id"));
				vo.setSeq(rs.getInt("seq"));
				vo.setLikes(rs.getInt("likes"));
				vo.setLocation(rs.getString("location"));
				vo.setFilepath(rs.getString("filepath"));
				vo.setCaption(rs.getString("caption"));
				boardlist.add(vo);
			}
			
			 // Bookmarked 게시물 정보 표시 
//				System.out.printf("boardlist.size :%d\n", boardlist.size());
//				for(int i=0; i<boardlist.size(); i++) {
//					System.out.printf("%d: %s\n\n", i, boardlist.get(i));
//				}
			
			rs.close();
			pt.close();
			con.close();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return boardlist;
	}

	public ArrayList<BoardVO> getBoardProfile() { // like 클릭시 마다 likes컬럼 1 증가/감소 해야함! -> update문
		ArrayList<BoardVO> boardlist = new ArrayList<BoardVO>();
		
		String loginid = (String)session.getAttribute("loginid");
		System.out.printf("(DAO getMyBookmarkInfo) session id :%s\n",(String)session.getAttribute("loginid"));
		
		try {
			String sql = "select DISTINCT mb.filepath filepath, mb.id id " + 
						"from hboard hb join member2 mb " + 
						"on hb.id = mb.id ";
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			PreparedStatement pt = con.prepareStatement(sql);
			
			ResultSet rs = pt.executeQuery();
			
			while(rs.next()) {
//				System.out.println("(DAO getBoardProfile) rs.next 단계");
				BoardVO vo = new BoardVO();
				vo.setId(rs.getString("id"));
				vo.setFilepath(rs.getString("filepath"));
				boardlist.add(vo);
			}
			
			// Board list Profile picture 게시물 정보 표시 
//			System.out.printf("(DAO getBoardProfile) boardlist.size :%d\n", boardlist.size());
//			for(int i=0; i<boardlist.size(); i++) {
//				System.out.printf("%d: %s\n\n", i, boardlist.get(i));
//			}
			
			rs.close();
			pt.close();
			con.close();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return boardlist;
	}
}

