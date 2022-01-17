package com.pj.gajobs.model;

import java.sql.Date;
import lombok.Data;

@Data
public class AppointFile {
	private int af_seq;
	private String m_id;
	private String af_name;
	private String af_origin;
	private int af_size;
	private String af_type;
	private Date af_date;
	private String af_url;
}
