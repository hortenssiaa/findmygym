package com.kangnam.healthproject;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	public ModelAndView getBoardList() {
		ModelAndView mv = new ModelAndView();
		ArrayList<BoardVO> boardlist = boarddao.getBoardDetail();
		
		if(boardlist != null) {
			mv.addObject("boardlist", boardlist);
			mv.setViewName("board/boardlist");
		} else {
			System.out.println("(BoardController) boardlist is null!!");
			mv.setViewName("redirect:/boardlist");
		}
		return mv;
	}
	
	@RequestMapping(value = "/likesprocess", method= RequestMethod.POST)
	@ResponseBody
	public BoardVO getMemberInfo // for home.jsp ajax
	(HttpSession session , 
	@RequestParam(value = "likes", required=true) String likes, 
	@RequestParam(value = "seq", required=true) String seq)
	{
		BoardVO vo = null;
		System.out.printf("(/likesprocess) likes:%s, seq:%s\n",likes,seq);
		
		if(likes.equals("1") || likes.equals("0")) {
			vo = boarddao.getLikes(likes, Integer.parseInt(seq));
			System.out.println("/likesprocess getLikes done\n");
		} 
		
		vo.getLikes();
		vo.getSeq();
		
		if(vo == null) {
			System.out.println("(/likesprocess) : vo is null!!");
		}
		
		return vo;
	}
}
