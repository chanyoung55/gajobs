package com.pj.gajobs.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Member {
	private String m_id;
	private String m_password;
	private String m_name;
	private String m_ssnum;
	private String m_email;
	private String m_tel;
	private Date m_hiredate;
	private String m_addr;
	private String m_postcode;
	private String m_detailaddr;
	private String m_extraaddr;
	private String m_del;
	private Date m_deldate;
	private String m_mgr;
	private int b_seq;
	private String r_code;
	private int t_seq;
	// 권한
	private String r_name;
	// 지점
	private String b_name;
	// 팀
	private String t_name;
	// 페이징
	private int startRow;
	private int endRow;
	// 검색용
	private String search;
	private String keyword;
	private String startDate;
	private String endDate;
}
