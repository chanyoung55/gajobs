package com.pj.gajobs.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Team {
	private int t_seq;
	private String t_name;
	private Date t_date;
	private int b_seq;
}
