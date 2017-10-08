package com.mis.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mis.bean.Department;
import com.mis.dao.DepartmentMapper;

@Service
public class DepartmemtService {

	@Autowired
	private DepartmentMapper departmentMapper;

	public List<Department> getDepts() {
		List<Department> list = departmentMapper.selectByExample(null);
		return list;
	}
}
