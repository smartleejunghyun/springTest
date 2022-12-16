package kr.smhrd.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.smhrd.entity.Board;
import kr.smhrd.entity.Criteria;
import kr.smhrd.entity.Member;
import kr.smhrd.entity.PageMaker;
import kr.smhrd.service.BoardService;
import kr.smhrd.service.MemberService;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Autowired
	BoardService boardService;

	@Autowired
	MemberService memberService;

	@RequestMapping("/list")
	public String list(Criteria cri, Model model) { // page가 1페이지인지 2페인지 3페인지
		// 게시판 전체 리스트 가져오기

		List<Board> list = boardService.getList(cri);
		model.addAttribute("list", list);

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);

		pageMaker.setTotalCount(boardService.countBoard(cri));

		// View에게 게시판 리스트 전달
		model.addAttribute("pageMaker", pageMaker); // 객체 바인딩(중요)
		return "board/list";
	}
	
	
	
	

	@GetMapping("/register")
	public String retgister(Model model) {

		return "board/register";
	}

	@PostMapping("/register")
	public String register(Board vo) {
		boardService.register(vo);

		return "redirect:/board/list";
	}

	@GetMapping("/get")
	public String get(@RequestParam("idx") int idx, @ModelAttribute("cri") Criteria cri, Model model) {

		System.out.print(idx);
		Board vo = boardService.get(idx);
		
		model.addAttribute("vo", vo);


		return "board/get";
	}
	

	@GetMapping("/remove")
	public String remove(int idx, Criteria cri, RedirectAttributes rttr) {
		boolean result = boardService.remove(idx);
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("pagePerNum", cri.getPerPageNum());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		rttr.addFlashAttribute("result", result);
		return "redirect:/board/list";
	}

	@GetMapping("/modify")
	public String modify(int idx, @ModelAttribute("cri") Criteria cri, Model model) {
		Board vo = boardService.get(idx);
		model.addAttribute("vo", vo);
		return "board/modify";
	}

	@PostMapping("/modify")
	public String modify(Board vo, Criteria cri, RedirectAttributes rttr) {
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		boardService.modify(vo);
		return "redirect:/board/list";
	}

	@PostMapping("/login")
	public String login(Member vo, HttpSession session) {

		Member mvo = memberService.login(vo);
		if (mvo != null) {
			session.setAttribute("mvo", mvo);
		}

		return "redirect:/board/list";
	}

	@PostMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();

		return "redirect:/board/list";
	}

	@GetMapping("/reply")
	public String reply(int idx, @ModelAttribute("cri")Criteria cri, Model model) {
		Board vo = boardService.get(idx);
		
		model.addAttribute("vo", vo);
		
		return "board/reply";
	}

	@PostMapping("/reply")
	public String reply(Board vo, Criteria cri, RedirectAttributes rttr) {
		boardService.reply(vo);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		
		return "redirect:/board/list";
	}

}
