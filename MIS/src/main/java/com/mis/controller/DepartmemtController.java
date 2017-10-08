package com.mis.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mis.bean.Department;
import com.mis.bean.Msg;
import com.mis.service.DepartmemtService;

@Controller
public class DepartmemtController {

	@Autowired
	DepartmemtService departmemtrService;

	@ResponseBody
	@RequestMapping("/depts")
	public Msg getDepts() {
		List<Department> list = departmemtrService.getDepts();
		return Msg.success().add("depts", list);
	}
}
