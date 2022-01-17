package com.pj.gajobs.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Branch {
	private int b_seq;
	private String b_name;
	private Date b_date;
	/* paging */
	private int startRow;
	private int endRow;
	
	/* join */
	private int personCount;
	private int teamCount;
	
	//검색용
	private String keyword;
}
