package com.mis.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mis.bean.Member;
import com.mis.bean.MemberExample;
import com.mis.bean.MemberExample.Criteria;
import com.mis.dao.MemberMapper;

@Service
public class MemberService {

	@Autowired
	MemberMapper memberMapper;

	public void deleteMember(Integer id) {
		memberMapper.deleteByPrimaryKey(id);
	}

	public void updateMember(Member member) {
		memberMapper.updateByPrimaryKeySelective(member);
	}

	public Member getMember(Integer id) {
		Member member = memberMapper.selectByPrimaryKey(id);
		return member;
	}

	public List<Member> getAll() {
		return memberMapper.selectByExampleWithDept(null);
	}

	public void saveEmp(Member member) {
		memberMapper.insertSelective(member);
	}

	public boolean checkUser(String memberName) {
		MemberExample example = new MemberExample();
		Criteria createCriteria = example.createCriteria();
		createCriteria.andMNameEqualTo(memberName);
		long count = memberMapper.countByExample(example);
		return count == 0;
	}

	public void deleteBatch(List<Integer> ids) {
		MemberExample example = new MemberExample();
		Criteria criteria = example.createCriteria();
		criteria.andMIdIn(ids);
		memberMapper.deleteByExample(example);
	}

}
