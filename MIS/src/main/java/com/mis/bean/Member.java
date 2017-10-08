package com.mis.bean;

import javax.validation.constraints.Pattern;

public class Member {
	private Integer mId;

	@Pattern(regexp = "^[\u2E80-\u9FFF]{2,5}", message = "姓名只可为中文")
	private String mName;

	@Pattern(regexp = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$", message = "邮箱格式不正确")
	private String email;

	private String gender;

	private Integer deptId;

	private Department department;

	public Member() {
		super();
	}

	public Member(Integer mId, String mName, String email, String gender, Integer deptId) {
		super();
		this.mId = mId;
		this.mName = mName;
		this.email = email;
		this.gender = gender;
		this.deptId = deptId;
	}

	public Integer getmId() {
		return mId;
	}

	public void setmId(Integer mId) {
		this.mId = mId;
	}

	public String getmName() {
		return mName;
	}

	public void setmName(String mName) {
		this.mName = mName == null ? null : mName.trim();
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email == null ? null : email.trim();
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender == null ? null : gender.trim();
	}

	public Integer getDeptId() {
		return deptId;
	}

	public void setDeptId(Integer deptId) {
		this.deptId = deptId;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	@Override
	public String toString() {
		return "Member [mId=" + mId + ", mName=" + mName + ", email=" + email + ", gender=" + gender + ", deptId="
				+ deptId + "]";
	}

}