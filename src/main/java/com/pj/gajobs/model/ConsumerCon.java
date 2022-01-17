package com.pj.gajobs.model;

import java.sql.Date;

import lombok.Data;

@Data
public class ConsumerCon {
	private int cc_seq;
	private int cp_seq;
	private String cc_kinds;
	private Date cc_condate;
	private Date cc_startdate;
	private Date cc_enddate;
	private String cc_pay;
	private String cc_insurance;
	private String cc_subinsurance;
	private String cc_state;
	private int c_num;
	private String cc_connum;
	
	//paging
	private int startRow;
	private int endRow;
	
	//join용
	private String cp_name;
}
