package com.pj.gajobs.model;

import lombok.Data;

@Data
public class Help {
	private int h_num;
	private String h_title;
	private String h_email;
	private String h_content;
	private String h_date;
	private String m_id;
	private String h_writer;
	private String h_read;
	
	//join용
	private String r_code;
	private int t_seq;
	private int b_seq;
	private String r_name;
	private String t_name;
	private String b_name;
	private String m_tel;
	private String m_email;
	
	// paging
	private int startRow;
	private int endRow;
		
	//검색용
	private String search;
	private String keyword;
}
