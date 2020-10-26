package com.kangnam.healthproject;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kangnam.healthprojectDAO.ParkDAO;
import com.kangnam.healthprojectVO.ParkVO;

@Controller
public class ParkController {
	@Autowired
	ParkDAO parkdao;
	
	@RequestMapping(value = "/park", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView getPark() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/park");
		return mv;
	}
	
	@RequestMapping(value ="/park/city", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public ArrayList<String> getTown(String cityname) {
		System.out.println("Hello here's ParkController getTown()");
		ArrayList<String> list; 
		
		list = parkdao.searchTown(cityname);
		System.out.println(list.get(0));
		
		return list;
	}
	
	@RequestMapping(value ="/park/parkinfo", method = RequestMethod.POST)
	@ResponseBody
	public ArrayList<ParkVO> getToiletInfo(String townname) {
		System.out.println("Hello here's ParkController getToiletInfo()");
//		System.out.printf("town:%s\n",townname);
		
		ArrayList<ParkVO> list; 
		
		list = parkdao.searchDetails(townname);
		System.out.println(list.get(0));
		
//		for(ToiletVO toilet: list) {
//			System.out.println(toilet.getPt_name());
//		}
		return list;
	}
}
