package com.pj.gajobs.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Reference {
	private int rf_num;
	private String rf_writer;
	private Date rf_date;
	private String rf_content;
	private int rf_count;
	private String rf_title;
	private int rfk_seq;
	private String m_id;
	
	//join용
	private String rfk_name;
	private String r_code;
	
	// paging
	private int startRow;
	private int endRow;
	
	//검색용
	private String kinds;
	private String search;
	private String keyword;
	
	//main용
	private String startDate;
	private String endDate;
}
