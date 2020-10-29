package com.kangnam.healthproject;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kangnam.healthprojectDAO.MountDAO;
import com.kangnam.healthprojectVO.MountVO;

@Controller
public class MountController {
	@Autowired
	MountDAO mountdao;
	
	@RequestMapping(value = "/mount", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView getMount() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/mount");
		return mv;
	}
	
	@RequestMapping(value ="/mount/city", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public ArrayList<String> getMount(String cityname) {
		ArrayList<String> list; 
		
		list = mountdao.searchTown(cityname);
		
		return list;
	}
	
	@RequestMapping(value ="/mount/mountinfo", method = RequestMethod.POST)
	@ResponseBody
	public ArrayList<MountVO> getMountInfo(String townname) {
		
		ArrayList<MountVO> list; 
		
		list = mountdao.searchDetails(townname);

		return list;
	}
}
