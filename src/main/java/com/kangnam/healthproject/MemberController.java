package com.kangnam.healthproject;

import java.io.File;

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
	public String signinForm() {
		System.out.println("signinForm() 호출됨");
		return "signin";
	}
	
	@RequestMapping(value = "/signin", method = RequestMethod.POST)
	public ModelAndView signinprocess
	(@RequestParam(value = "id", required=true) String id, 
	 @RequestParam(value = "password", required=true) String password)
	{
		ModelAndView mv = new ModelAndView();
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
		return mv;
	}

	@RequestMapping(value = "/memberinfo", method = RequestMethod.POST)
	@ResponseBody
	public MemberVO getMemberInfo
	(@RequestParam(value = "id", required=true) String id, 
	 @RequestParam(value = "password", required=true) String password)
	{
		MemberVO vo = null;
		boolean flag = dao.checkidpassword(id, password);
		if(flag) {
			System.out.println("Controller getMemberInfo 진행중");
			vo = dao.getMemberinfo(id);
			vo.getName();
			vo.getId();
			vo.getFilepath();
		}
		
		if(vo == null)
			System.out.println("vo is null!!");
		
		return vo;
	}
	
	@RequestMapping("/signout")
	public String logout(HttpSession session) {
		session.invalidate();
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
