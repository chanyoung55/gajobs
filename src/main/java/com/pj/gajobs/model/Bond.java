package com.pj.gajobs.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Bond {
	private int bo_num;
	private String bo_kinds;
	private Date bo_startdate;
	private Date bo_enddate;
	private String bo_pay;
	private int bof_seq;
	private String m_id;
	
	//join용
	private String m_name;
	private String m_email;
	private String m_tel;
	private String m_del;
	private Date m_deldate;
	private int b_seq;
	private String r_code;
	private int t_seq;
	//join2
	private String r_name; // 권한
	private String b_name; // 지점
	private String t_name; // 팀
	
	// 페이징
	private int startRow;
	private int endRow;
	
	// 검색용
	private String search;
	private String keyword;
	private String startDate;
	private String endDate;
}
