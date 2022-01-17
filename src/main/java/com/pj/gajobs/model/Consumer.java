package com.pj.gajobs.model;

import java.sql.Date;
import lombok.Data;

@Data
public class Consumer {
	private int c_num;
	private String c_name;
	private String c_relation;
	private String c_ssnum;
	private String c_agree;
	private String c_family;
	private String c_tel;
	private String c_postcode;
	private String c_addr;
	private String c_detailaddr;
	private String c_extraaddr;
	private String c_history;
	private String c_smemo;
	private String c_lmemo;
	private String m_id;
	private Date c_date;
	private String c_sex;
	// 페이징
	private int startRow;
	private int endRow;
	// 검색용
	private String search;
	private String keyword;
	//main용
	private String startDate;
	private String endDate;
}
