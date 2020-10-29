package com.kangnam.healthproject;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kangnam.healthprojectDAO.WorkoutDAO;
import com.kangnam.healthprojectVO.WorkoutVO;

@Controller
public class WorkoutController {
	@Autowired
	WorkoutDAO workoutdao;

	@RequestMapping(value = "/workout", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView getWorkout() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/workout");
		return mv;
	}
	
	@RequestMapping(value ="/workout/city", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public ArrayList<String> getTown(String cityname) {
//		System.out.println("Hello here's ParkController getTown()");
		ArrayList<String> list; 
		
		list = workoutdao.searchTown(cityname);
//		System.out.println(list.get(0));
		
		return list;
	}
	
	@RequestMapping(value ="/workout/workoutinfo", method = RequestMethod.POST)
	@ResponseBody
	public ArrayList<WorkoutVO> getWorkoutInfo(String townname) {
//		System.out.println("Hello here's ParkController getToiletInfo()");
//		System.out.printf("town:%s\n",townname);
		
		ArrayList<WorkoutVO> list; 
		
		list = workoutdao.searchDetails(townname);
//		System.out.println(list.get(0));
		
//		for(ToiletVO toilet: list) {
//			System.out.println(toilet.getPt_name());
//		}
		return list;
	}
}
