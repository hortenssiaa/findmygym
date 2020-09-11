package com.kangnam.healthproject;

import java.io.File;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
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

import com.kangnam.healthprojectDAO.MemberDAO;
import com.kangnam.healthprojectVO.MemberVO;

@Controller
public class MemberController {
	@Autowired // 자동 setter 호출
	MemberDAO dao;

	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String signupForm() {
		return "signup";
	}

	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String insertProcess(@ModelAttribute("vo") MemberVO vo) throws Exception {
		MultipartFile multipartfile = vo.getFile();
		System.out.println("file name : " + multipartfile);

		if (multipartfile != null) {
			String photo_name = multipartfile.getOriginalFilename();
			String photo_savepath_local = "/Users/Sohnhakyung/Desktop/fileupload/";
			String photo_savepath_server = "/fileupload/";
			String photopath_local = photo_savepath_local + photo_name;
			String photopath_server = photo_savepath_server + photo_name;

			File file = new File(photopath_local);
			multipartfile.transferTo(file);
			
			String result = dao.insertMember(vo, photopath_server);
			System.out.println(result);
			System.out.println(photo_name);
			return "memberlist"; 
		} else {
			System.out.println("multipartfile is null!!");
			return "redirect:/signup"; 
		}
		
	}
	
	@RequestMapping(value = "/signin", method = RequestMethod.GET)
	public String signinForm(HttpSession session) {
		System.out.println("signinForm() 호출됨");
		
		if(session.getAttribute("loginCheck") != null) {
			System.out.print("(/signin) session status :");
			System.out.println(session.getAttribute("loginid"));
			return "included_memberinfo";
//			return "home";
			
		} else 
			return "signin";
	}
	
	@RequestMapping(value = "/signin", method = RequestMethod.POST)
	public ModelAndView signinprocess 
	(HttpSession session ,
	 @RequestParam(value = "id", required=true) String id, 
	 @RequestParam(value = "password", required=true) String password
	)
	{
		// signin <form> 에서 넘어온 name="id"의 값을 요청 
		//String session_id = request.getParameter("id");
		//@RequestParam(value = "id", required=true) String id

		// id 저장하기 위한 session 생성 
		//HttpSession session = request.getSession();
		
		// name="id"로 받아온 값을 "loginid"라는 이름에 session 설정 
		//session.setAttribute("loginid", session_id);
		
		ModelAndView mv = new ModelAndView();
		
		if(session.getAttribute("loginCheck") != null) {
			System.out.print("(/signin) session status :");
			System.out.println(session.getAttribute("loginid"));
			mv.setViewName("included_memberinfo");
//			mv.setViewName("home");
			
		} else {
			session.setAttribute("loginid", id);
			session.setAttribute("loginCheck", true);
			System.out.print("(/memberinfo) session connected, session:");
			System.out.println(session.getAttribute("loginid"));
		
			boolean flag = dao.checkidpassword(id, password);		
			if(flag) {
				String filepath = dao.getFilePath(id);
				System.out.printf("Controller filepath : %s\n", filepath);
		
				mv.addObject("id", id);
				mv.addObject("password", password);
				mv.addObject("filepath", filepath);
				mv.setViewName("signinresult");
			} else {
				mv.setViewName("redirect:/signin");
			}
		}
		return mv;
	} 
	
	@RequestMapping(value = "/memberinfo", method= RequestMethod.POST)
	@ResponseBody
	public MemberVO getMemberInfo // for home.jsp ajax
	(HttpSession session , 
//	 @RequestParam(value = "id", required=false) String id, 
//	 @RequestParam(value = "password", required=false) String password)
	@RequestParam(value = "id", required=true) String id, 
	@RequestParam(value = "password", required=true) String password)
	{
		MemberVO vo = null;
		System.out.printf("(/memberinfo) id:%s, password:%s\n",id,password);
		
		if(session.getAttribute("loginCheck") != null) {
//		if(id.equals((String)session.getAttribute("loginid"))) {
			System.out.println("member info 실행됐음!!!!!!");
			System.out.print("(/memberinfo) session status :");
			System.out.println(session.getAttribute("loginid"));

			vo = dao.getMemberinfo((String) session.getAttribute("loginid"));
		} else {
			boolean flag = dao.checkidpassword(id, password);
			if(flag) {
				System.out.println("(/memberinfo) Controller getMemberInfo 진행중");
			
				session.setAttribute("loginid", id);
				session.setAttribute("loginCheck", true);
				System.out.print("(/memberinfo) session connected, session:");
				System.out.println(session.getAttribute("loginid"));

				vo = dao.getMemberinfo(id);
			}
		}
		vo.getName();
		vo.getId();
		vo.getFilepath();
		
		if(vo == null)
			System.out.println("vo is null!!");
		
		return vo;
	}
	
	@RequestMapping("/signout")
	public String logout(HttpSession session) {
		if(session.getAttribute("loginCheck") != null) {
			System.out.print(session.getAttribute("loginid"));
			System.out.println(": session invalidated!");
			session.invalidate();
		} else
			System.out.println("session 등록 안돼있음");
		return "redirect:/";
	}

//	@RequestMapping(value = "/memberinfo")
//	public MemberVO getMemberInfo() {
//		MemberVO vo = new MemberVO();
//		
//
//		return vo;
//	}
}
