package kr.smhrd.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.smhrd.domain.SampleDTO;
import kr.smhrd.domain.SampleDTOList;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/sample/*")
@Log4j
public class SampleController {

	@RequestMapping("")
	public void basic() {
		
		log.info("basic...........");
	}
	
	@GetMapping("/basicOnlyGet")
	public void basicGet2() {
		log.info("basic get only get....................");
	}
	
	@GetMapping("/ex01")
	public String ex01(SampleDTO dto) {
		log.info("" + dto);
		System.out.println(dto.getName() + dto.getAge());
		
		return "ex01";
	}
	
	@GetMapping("/ex02")
	public String ex02(@RequestParam("name") String name, @RequestParam("age") int age) {
		
		System.out.println(name);
		System.out.println(age);
		
		return "ex02";
	}
	
	@GetMapping("/ex02Bean")
	public String ex02Bean(SampleDTOList list) {
		System.out.println(list.getList());
		return "ex02Bean";
	}
	
}
