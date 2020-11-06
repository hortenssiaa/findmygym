package com.kangnam.healthproject;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kangnam.healthprojectDAO.RiverDAO;
import com.kangnam.healthprojectVO.RiverVO;

@Controller
public class RiverController {
	@Autowired
	RiverDAO riverdao;

	@RequestMapping(value = "/river", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView getRiver() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/river");
		return mv;
	}
	
	@RequestMapping(value ="/river/city", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public ArrayList<String> getTown(String cityname) {
		ArrayList<String> list; 
		
		list = riverdao.searchTown(cityname);
		
		return list;
	}
	
	@RequestMapping(value ="/river/riverinfo", method = RequestMethod.POST)
	@ResponseBody
	public ArrayList<RiverVO> getRiverInfo(String townname) {
		System.out.println("riverinfo townname:" + townname);
		ArrayList<RiverVO> list; 
		
		list = riverdao.searchDetails(townname);
		
		return list;
	}

	@RequestMapping(value ="/river/riverinfobc", method = RequestMethod.POST)
	@ResponseBody
	public ArrayList<RiverVO> getRiverInfoByCity(String cityname) {
		System.out.println("riverinfobc townname:" + cityname);
		ArrayList<RiverVO> list; 
		
		list = riverdao.searchDetails_ByCity(cityname);
		
		return list;
	}
}
