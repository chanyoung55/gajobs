/*-- 문의게시판 글 테이블  --*/
create table Help(
	h_num number(10) not null primary key,
	h_title	varchar2(200) not null,
	h_email varchar2(100) not null,
	h_content varchar2(1024) not null,
	h_date date not null,
	m_id varchar2(20) not null,
	h_writer varchar2(20) not null,
	h_read char(1) default 'n' not null,
	constraint h_m_id foreign key(m_id) references member(m_id)
);

/*-- 문의게시판 파일 테이블  --*/
create table HelpFile(
	hf_seq number(4) not null primary key,
	hf_name	varchar2(200) not null,
	hf_origin varchar2(200) not null,
	hf_size	number(10) not null,
	hf_type	varchar2(10) not null,
	hf_date	date not null,
	hf_url varchar2(200) not null,
	h_num number(4) not null,
	constraint hf_h_num foreign key(h_num) references help(h_num)
);

/*-- 문의게시판 파일 시퀀스  --*/
create sequence helpfile_seq;

/*-- 이메일 테이블  --*/
create table Email(
	em_num number(4) not null primary key,
	em_title varchar2(500) not null,
	em_content varchar2(1024) not null,
	em_recipient varchar2(100) not null,
	em_smail varchar2(200) not null,
	em_rmail varchar2(200) not null,
	em_date date not null,
	m_id varchar2(20) not null,
	em_del char(1) default 'n' not null,
	constraint em_m_id foreign key(m_id) references member(m_id)
);