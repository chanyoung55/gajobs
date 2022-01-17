package com.pj.gajobs.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Notice {
	private int n_num;
	private String n_title;
	private String n_content;
	private Date n_date;
	private int n_count;
	private String n_writer;
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
