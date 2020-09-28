package com.kangnam.healthproject;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;
import javax.swing.border.Border;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kangnam.healthprojectDAO.BoardDAO;
import com.kangnam.healthprojectVO.BoardVO;
import com.kangnam.healthprojectVO.MemberVO;

@Controller
public class BoardController {
	@Autowired
	BoardDAO boarddao;

	@RequestMapping(value = "/writeform", method = RequestMethod.GET)
	public String writeform() {
		return "/board/writeform";
	}
	
	@RequestMapping(value = "/writeform", method = RequestMethod.POST)
	public ModelAndView writeprocess(@ModelAttribute("boardvo") BoardVO vo) throws Exception {
		ModelAndView mv = new ModelAndView();
		MultipartFile multipartfile = vo.getFile();
		System.out.println("(Board/writeform) uploading file name : " + multipartfile);

		if (multipartfile != null) {
			String photo_name = multipartfile.getOriginalFilename();
			String photo_savepath_local = "/Users/Sohnhakyung/Desktop/boardfile/";
			String photo_savepath_server = "/boardfile/";
			String photopath_local = photo_savepath_local + photo_name;
			String photopath_server = photo_savepath_server + photo_name;

			File file = new File(photopath_local);
			multipartfile.transferTo(file);
			System.out.println(vo.toString());
			
			String result = boarddao.insertBoard(vo, photopath_server);
			System.out.printf("insertBoard 결과:%s\n",result);
			System.out.printf("photo_name:%s\n", photo_name);
			
//			if(result.indexOf("succeeded") > 0)
//				return "/board/boardlist";
//			else 
//				return "redirect:/writeform";
//			
//		} else {
//			System.out.println("(Board/writeform) multipartfile is null!!");
//			return "redirect:/writeform"; 
//		}
		if(result.indexOf("succeeded") > 0)
			mv.setViewName("board/boardresult");
		else 
			mv.setViewName("redirect:/writeform");
		
		} else {
			System.out.println("(Board/writeform) multipartfile is null!!");
			mv.setViewName("redirect:/writeform");
		}
		
		return mv;
		
	}
	
	@RequestMapping("/boardlist")
	public ModelAndView getBoardList(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		ArrayList<BoardVO> boardlist = boarddao.getBoardDetail();
		
		if(boardlist != null) {
			System.out.println("(BoardController) boardlist is read.");
			mv.addObject("boardlist", boardlist);
			mv.setViewName("board/boardlist");
		} else {
			System.out.println("(BoardController) boardlist is null!!");
			mv.setViewName("redirect:/boardlist");
		}
		return mv;
//		ModelAndView mv = new ModelAndView();
//		ArrayList<BoardVO> boardlist = null;
//		if(session.getAttribute("loginCheck") != null)
//			boardlist = boarddao.getlikedinfo();
//		else
//			boardlist = boarddao.getBoardDetail();
//		
//		if(boardlist != null) {
//			System.out.println("(BoardController) boardlist is read.");
//			mv.addObject("boardlist", boardlist);
//			mv.setViewName("board/boardlist");
//		} else {
//			System.out.println("(BoardController) boardlist is null!!");
//			mv.setViewName("redirect:/boardlist");
//		}
//		return mv;
	}
	
	@RequestMapping(value = "/likesprocess", method= RequestMethod.POST)
	@ResponseBody
	public BoardVO getMemberInfo // for boardlist.jsp ajax
	(HttpSession session , 
	@RequestParam(value = "likes", required=true) String likes, 
	@RequestParam(value = "seq", required=true) String seq,
	@RequestParam(value = "id", required=true) String id
	)
	{
		BoardVO vo = null;
		System.out.printf("(/likesprocess) likes:%s, seq:%s, id:%s\n",likes,seq,id);
		
		if(likes.equals("1") || likes.equals("0")) {
			vo = boarddao.getLikes(likes, Integer.parseInt(seq), id);
			System.out.println("/likesprocess getLikes done\n");
		} 
		
		vo.getLikes();
		vo.getSeq();
		
		if(vo == null) {
			System.out.println("(/likesprocess) : vo is null!!");
		}
		
		return vo;
	}

	@RequestMapping(value = "/getlikeddata", method= RequestMethod.POST)
	@ResponseBody
	public ArrayList<BoardVO> getLikedData // for boardlist.jsp ajax
	(HttpSession session)
	{
		ArrayList<BoardVO> likedlist = null;
		
		likedlist = boarddao.getlikedinfo();
		System.out.println("\n/getlikeddata getLikes done\n");
		System.out.printf("likedlist.size() : %s\n", likedlist.size());
		
		for(int i=0; i<likedlist.size(); i++) {
//			likedlist.get(i);
			likedlist.get(i).getId();
			likedlist.get(i).getSeq();
		}
		
		if(likedlist == null) {
			System.out.println("(/getlikeddata) : likedlist is null!!");
		}
		
		return likedlist;
	}

	@RequestMapping(value = "/getbookmarkdata", method= RequestMethod.POST)
	@ResponseBody
	public ArrayList<BoardVO> getBookmarkData // for boardlist.jsp ajax
	(HttpSession session)
	{
		ArrayList<BoardVO> bookmarklist = null;
		
		bookmarklist = boarddao.getBookmarkInfo();
		System.out.println("\n/getBookmarkData getLikes done\n");
		System.out.printf("bookmarklist.size() : %s\n", bookmarklist.size());
		
		for(int i=0; i<bookmarklist.size(); i++) {
//			likedlist.get(i);
			bookmarklist.get(i).getId();
			bookmarklist.get(i).getSeq();
		}
		
		if(bookmarklist == null) {
			System.out.println("(/getlikeddata) : likedlist is null!!");
		}
		
		return bookmarklist;
	}
	
	@RequestMapping(value = "/bookmarkprocess", method= RequestMethod.POST)
	@ResponseBody
	public void bookmarkProcess // for boardlist.jsp ajax
	(HttpSession session , 
	@RequestParam(value = "bm_status", required=true) String bm_status, 
	@RequestParam(value = "seq", required=true) String seq,
	@RequestParam(value = "id", required=true) String id
	)
	{
		// bookmarkProces는 likes와 다르게, 수 표시 안해도 되기 때문에, VO받아오지않고 void로 return type 정함
		// VO 추가 해야한댜면, /likeprocess인 getMemberInfo() 코드 참고할 것 
		
		System.out.printf("(/bookmarkprocess) bm_status:%s, seq:%s, id:%s\n", bm_status,seq,id);
		
		if(bm_status.equals("1") || bm_status.equals("0")) {
			boarddao.getBookMark(bm_status, Integer.parseInt(seq), id);
			System.out.println("/bookmarkProcess getBookMark done\n");
		} 
		
	}
}
