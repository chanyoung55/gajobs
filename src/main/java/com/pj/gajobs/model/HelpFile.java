package com.pj.gajobs.model;

import java.sql.Date;

import lombok.Data;

@Data
public class HelpFile {
	private int hf_seq;
	private String hf_name;
	private String hf_origin;
	private int hf_size;
	private String hf_type;
	private Date hf_date;
	private String hf_url;
	private int h_num;
}
