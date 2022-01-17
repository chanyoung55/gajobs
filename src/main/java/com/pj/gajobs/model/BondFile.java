package com.pj.gajobs.model;

import java.sql.Date;

import lombok.Data;

@Data
public class BondFile {
	private int bof_seq;
	private String bof_name;
	private String bof_origin;
	private int bof_size;
	private String bof_type;
	private Date bof_date;
	private String bof_url;
	private int bo_num;
}
