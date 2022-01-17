package com.pj.gajobs.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Education {
	private int e_num;
	private String e_title;
	private String e_content;
	private Date e_date;
	private int e_count;
	private String e_writer;
	private String m_id;
	
	// paging
	private int startRow;
	private int endRow;
	
	//검색용
	private String search;
	private String keyword;
	
	//main용
	private String startDate;
	private String endDate;
}
