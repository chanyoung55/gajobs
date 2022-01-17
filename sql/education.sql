/*-- 교육게시판 글 테이블  --*/
create table education (
	e_num number(4) not null primary key,
	e_title varchar2(200) not null,
	e_content varchar2(1024) not null,
	e_date date not null,
	e_count	number(10) not null,
	e_writer varchar2(20) not null,
	m_id varchar2(20) not null,
	constraint e_m_id foreign key(m_id) references member(m_id)
);

/*-- 교육게시판 첨부파일 테이블 --*/
create table educationFile (
	ef_seq number(4) not null primary key,
	ef_name varchar2(200) not null,
	ef_origin varchar2(200) not null,
	ef_size number(10) not null,
	ef_type varchar2(10) not null,
	ef_date	date not null,
	ef_url varchar2(200) not null,
	e_num number(4) not null,
	constraint ef_e_num foreign key(e_num) references education(e_num)
);

/*-- 공지사항 파일 시퀀스 --*/
create sequence EducationFile_seq;

/*-- 공지사항 댓글 테이블  --*/
create table educationre (
	er_seq number(4) not null primary key,
	er_content varchar2(1024) not null,
	er_date	date not null,
	er_writer varchar2(20) not null,
	e_num number(4) not null,
	m_id varchar2(20) not null,
	constraint er_e_num foreign key(e_num) references education(e_num),
	constraint er_m_id foreign key(m_id) references member(m_id)
);

/*-- 공지사항 댓글 시퀀스  --*/
create sequence EducationRe_seq;