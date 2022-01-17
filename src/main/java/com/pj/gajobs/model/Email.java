package com.pj.gajobs.model;

import lombok.Data;

@Data
public class Email {
	private int em_num;
	private String em_title;
	private String em_content;
	private String em_recipient;
	private String em_smail;
	private String em_rmail;
	private String em_date;
	private String m_id;
	
	// paging
	private int startRow;
	private int endRow;
	
	//검색용
	private String search;
	private String keyword;
	
}
