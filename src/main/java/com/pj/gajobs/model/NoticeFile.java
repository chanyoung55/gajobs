package com.pj.gajobs.model;

import java.sql.Date;

import lombok.Data;

@Data
public class NoticeFile {
	private int nf_seq;
	private String nf_name;
	private String nf_origin;
	private int nf_size;
	private String nf_type;
	private Date nf_date;
	private String nf_url;
	private int n_num;
}
