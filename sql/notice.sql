/*-- 공지사항 글 테이블  --*/
create table notice (
	n_num number(4) not null primary key,
	n_title varchar2(200) not null,
	n_content varchar2(1024) not null,
	n_date date not null,
	n_count number(10) not null,
	n_writer varchar2(20) not null,
	m_id varchar2(20) not null,
	constraint n_m_id foreign key(m_id) references member(m_id)
);

/*-- 공지사항 첨부파일 테이블 --*/
create table noticeFile (
	nf_seq number(4) not null primary key,
	nf_name varchar2(200) not null,
	nf_origin varchar2(200) not null,
	nf_size number(10) not null,
	nf_type varchar2(10) not null,
	nf_date date not null,
	nf_url varchar2(200) not null,
	n_num number(4) not null,
	constraint nf_n_num foreign key(n_num) references notice(n_num)
);

/*-- 공지사항 파일 시퀀스 --*/
create sequence NoticeFile_seq;

/*-- 공지사항 댓글 테이블  --*/
create table noticere (
	nr_seq number(4) not null primary key,
	nr_content varchar2(1024) not null,
	nr_date date not null,
	n_num number(4) not null,
	m_id varchar2(20) not null,
	nr_writer varchar2(20) not null,
	constraint nr_n_num foreign key(n_num) references notice(n_num),
	constraint nr_m_id foreign key(m_id) references member(m_id)
);

/*-- 공지사항 댓글 시퀀스  --*/
create sequence NoticeRe_seq;