package com.pj.gajobs.model;

import java.sql.Date;

import lombok.Data;

@Data
public class EducationRe {
	private int er_seq;
	private String er_content;
	private Date er_date;
	private String er_writer;
	private int e_num;
	private String m_id;
}
