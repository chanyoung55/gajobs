package com.pj.gajobs.model;

import java.sql.Date;
import lombok.Data;

@Data
public class ConsumerFile {
	private int cf_seq;
	private String cf_name;
	private String cf_origin;
	private int cf_size;
	private String cf_type;
	private Date cf_date;
	private String cf_url;
	private int c_num;
}
