package com.pj.gajobs.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Company {
	private int cp_seq;
	private String cp_name;
	private String cp_kinds;
	private Date cp_setdate;
	private String cp_del;
	
	// paging
	private int startRow;
	private int endRow;
			
	//검색용
	private String search;
	private String keyword;
}
