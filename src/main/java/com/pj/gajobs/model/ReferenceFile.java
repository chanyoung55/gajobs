package com.pj.gajobs.model;

import java.sql.Date;

import lombok.Data;

@Data
public class ReferenceFile {
	private int rff_seq;
	private String rff_name;
	private String rff_origin;
	private int rff_size;
	private String rff_type;
	private Date rff_date;
	private String rff_url;
	private int rf_num;
}
