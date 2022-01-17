package com.pj.gajobs.model;

import java.sql.Date;

import lombok.Data;

@Data
public class NoticeRe {
	private int nr_seq;
	private String nr_content;
	private Date nr_date;
	private int n_num;
	private String nr_writer;
	private String m_id;
}
