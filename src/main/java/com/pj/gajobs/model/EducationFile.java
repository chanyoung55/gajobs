package com.pj.gajobs.model;

import java.sql.Date;

import lombok.Data;

@Data
public class EducationFile {
	private int ef_seq;
	private String ef_name;
	private String ef_origin;
	private int ef_size;
	private String ef_type;
	private Date ef_date;
	private String ef_url;
	private int e_num;
}
