package com.mis.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mis.bean.Member;
import com.mis.bean.Msg;
import com.mis.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	MemberService memberService;

	@ResponseBody
	@RequestMapping(value = "/member/{ids}", method = RequestMethod.DELETE)
	public Msg deleteMember(@PathVariable("ids") String ids) {
		if (ids.contains("-")) {
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = ids.split("-");
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			memberService.deleteBatch(del_ids);
		} else {
			Integer id = Integer.parseInt(ids);
			memberService.deleteMember(id);
		}
		return Msg.success();
	}

	@RequestMapping(value = "/member/{mId}", method = RequestMethod.PUT)
	@ResponseBody
	public Msg getMember(Member member) {
		memberService.updateMember(member);
		return Msg.success();
	}

	@RequestMapping(value = "/member/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Msg getMember(@PathVariable("id") Integer id) {
		Member member = memberService.getMember(id);
		return Msg.success().add("member", member);
	}

	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkuser(@RequestParam(value = "memberName") String memberName) {
		String regx = "^[\\u2E80-\\u9FFF]{2,5}";
		if (!memberName.matches(regx)) {
			return Msg.fail().add("va_msg", "姓名只可为中文");
		}
		boolean b = memberService.checkUser(memberName);
		if (b) {
			return Msg.success();
		} else {
			return Msg.fail().add("va_msg", "姓名不可用");
		}
	}

	@ResponseBody
	@RequestMapping("/members")
	public Msg getMembersWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		PageHelper.startPage(pn, 5);
		List<Member> members = memberService.getAll();
		PageInfo page = new PageInfo(members, 5);
		return Msg.success().add("pageInfo", page);
	}

	@ResponseBody
	@RequestMapping(value = "/member", method = RequestMethod.POST)
	public Msg saveMember(@Valid Member member, BindingResult result) {
		if (result.hasErrors()) {
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		} else {
			memberService.saveEmp(member);
			return Msg.success();
		}
	}
}
