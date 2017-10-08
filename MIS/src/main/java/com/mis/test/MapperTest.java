package com.mis.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.mis.bean.Department;
import com.mis.bean.Member;
import com.mis.dao.DepartmentMapper;
import com.mis.dao.MemberMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
public class MapperTest {

	@Autowired
	DepartmentMapper departmentMapper;

	@Autowired
	MemberMapper memberMapper;

	@Autowired
	SqlSession sqlSession;

	@Test
	public void testCRUD() {
		System.out.println(departmentMapper);

		departmentMapper.insertSelective(new Department(null, "开发部"));
		departmentMapper.insertSelective(new Department(null, "测试部"));

		memberMapper.insertSelective(new Member(null, "Jerry", "M", "Jerry@atguigu.com", 1));

		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		for (int i = 0; i < 5; i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5) + i;
			mapper.insertSelective(new Member(null, uid, "M", uid + "@atguigu.com", 1));
		}
		System.out.println("批量完成");

	}
}
