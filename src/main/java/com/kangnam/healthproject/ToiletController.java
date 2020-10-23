package com.kangnam.healthproject;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kangnam.healthprojectDAO.ToiletDAO;

@Controller
public class ToiletController {
	@Autowired
	ToiletDAO toiletdao;
	
	@RequestMapping(value = "/toilet", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView getToilet() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/toilet");
		return mv;
	}
	
	@RequestMapping(value ="/toilet/city", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public ArrayList<String> getCity(String cityname) {
		ArrayList<String> list; 
		list = toiletdao.searchCity(cityname);
		System.out.println(list.get(0));
		return list;
	}
}
