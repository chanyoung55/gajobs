/*-- 채권 관리 테이블  --*/
create table Bond (
	bo_num number(4) not null primary key,
	bo_kinds varchar2(20) not null,
	bo_startdate date not null,
	bo_enddate date not null,
	bo_pay varchar2(1024) not null,
	m_id varchar2(20) not null,
	constraint bo_m_id foreign key(m_id) references member(m_id)
);

/*-- 채권관리 첨부파일 테이블 --*/
create table BondFile (
	bof_seq	number(4) not null primary key,
	bof_name varchar2(200) not null,
	bof_origin varchar2(200) not null,
	bof_size number(10) not null,
	bof_type varchar2(10) not null,
	bof_date date not null,
	bof_url varchar2(200) not null,
	bo_num number(4) not null,
	constraint bof_bo_num foreign key(bo_num) references Bond(bo_num)
);

/*-- 채권관리 첨부파일 시퀀스  --*/
create sequence BondFile_seq;