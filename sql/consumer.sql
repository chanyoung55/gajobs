/*-- 고객 관리 테이블 --*/
create table Consumer (
	c_num number(4) not null primary key,
	c_name varchar2(20) not null,
	c_relation varchar2(100),
	c_ssnum varchar2(20),
	c_agree char(1) default 'n' not null,
	c_family varchar2(100),
	c_tel varchar2(50) not null,
	c_postcode varchar2(50),
	c_addr varchar2(300),
	c_detailaddr varchar2(300),
	c_extraaddr varchar2(300),
	c_history varchar2(600),
	c_smemo	varchar2(600) not null,
	c_lmemo	varchar2(1024),
	m_id varchar2(20) not null,
	c_date date not null,
	c_sex char(1) default '1' not null,
	constraint c_m_id foreign key(m_id) references member(m_id)
);

/*-- 고객 동의서 파일 테이블 --*/
create table ConsumerFile (
	cf_seq number(4) not null primary key,
	cf_name varchar2(200) not null,
	cf_origin varchar2(200) not null,
	cf_size number(10) not null,
	cf_type	varchar2(10) not null,
	cf_date	date not null,
	cf_url varchar2(200) not null,
	c_num number(4) not null,
	constraint cf_c_num foreign key(c_num) references consumer(c_num)
);
/*-- 고객 동의서 파일 테이블 시퀀스 --*/
create sequence ConsumerFile_seq;

/*-- 회사 테이블 --*/
create table Company (
	cp_seq number(4) not null primary key,
	cp_name varchar2(100) not null,
	cp_kinds varchar2(50) not null,
	cp_setdate date not null,
	cp_del char(1) default 'n' not null
);
/*-- 회사 테이블 시퀀스 --*/
create sequence company_seq;

/*-------------- 회사 정보 삽입 --------------*/
		/*-- 손해보험 --*/
insert into company values(company_seq.nextVal,'메리츠화재','손보',sysdate,'n');
insert into company values(company_seq.nextVal,'삼성화재','손보',sysdate,'n');
insert into company values(company_seq.nextVal,'DB손보','손보',sysdate,'n');
insert into company values(company_seq.nextVal,'한화손보','손보',sysdate,'n');
insert into company values(company_seq.nextVal,'현대해상','손보',sysdate,'n');
insert into company values(company_seq.nextVal,'KB손보','손보',sysdate,'n');
insert into company values(company_seq.nextVal,'AIG손보','손보',sysdate,'n');
insert into company values(company_seq.nextVal,'MG손보','손보',sysdate,'n');
insert into company values(company_seq.nextVal,'흥국화재','손보',sysdate,'n');
insert into company values(company_seq.nextVal,'롯데손보','손보',sysdate,'n');
insert into company values(company_seq.nextVal,'농협손보','손보',sysdate,'n');
insert into company values(company_seq.nextVal,'처브손보','손보',sysdate,'n');
insert into company values(company_seq.nextVal,'하나손보','손보',sysdate,'n');
		/*-- 생명보험 --*/
insert into company values(company_seq.nextVal,'삼성생명','생보',sysdate,'n');
insert into company values(company_seq.nextVal,'한화생명','생보',sysdate,'n');
insert into company values(company_seq.nextVal,'교보생명','생보',sysdate,'n');
insert into company values(company_seq.nextVal,'동양생명','생보',sysdate,'n');
insert into company values(company_seq.nextVal,'DB생명','생보',sysdate,'n');
insert into company values(company_seq.nextVal,'미래에셋','생보',sysdate,'n');
insert into company values(company_seq.nextVal,'흥국생명','생보',sysdate,'n');
insert into company values(company_seq.nextVal,'신한생명','생보',sysdate,'n');
insert into company values(company_seq.nextVal,'KDB생명','생보',sysdate,'n');
insert into company values(company_seq.nextVal,'AIA생명','생보',sysdate,'n');
insert into company values(company_seq.nextVal,'ABL생명','생보',sysdate,'n');
insert into company values(company_seq.nextVal,'DGB생명','생보',sysdate,'n');
insert into company values(company_seq.nextVal,'농협생명','생보',sysdate,'n');
insert into company values(company_seq.nextVal,'메트라이프','생보',sysdate,'n');
insert into company values(company_seq.nextVal,'라이나생명','생보',sysdate,'n');
insert into company values(company_seq.nextVal,'KB생명','생보',sysdate,'n');
insert into company values(company_seq.nextVal,'IBK연금보험','생보',sysdate,'n');
insert into company values(company_seq.nextVal,'오렌지라이프','생보',sysdate,'n');
insert into company values(company_seq.nextVal,'처브생명','생보',sysdate,'n');
insert into company values(company_seq.nextVal,'카디프생명','생보',sysdate,'n');
insert into company values(company_seq.nextVal,'삼성생명','생보',sysdate,'n');
insert into company values(company_seq.nextVal,'푸르덴셜','생보',sysdate,'n');

/*-- 고객계약 테이블 --*/
create table ConsumerCon(
	cc_seq number(4) not null primary key,
	cp_seq number(4) not null,
	cc_kinds varchar2(50) not null,
	cc_condate date not null,
	cc_startdate date not null,
	cc_enddate date not null,
	cc_pay varchar2(1024) not null,
	cc_insurance varchar2(20) not null,
	cc_subinsurance	varchar2(20) not null,
	cc_state varchar2(10) not null,
	c_num number(4) not null,
	cc_connum varhcar2(1024),
	constraint cc_c_num foreign key(c_num) references consumer(c_num),
	constraint cc_cp_seq foreign key(cp_seq) references company(cp_seq)
);

/*-- 고객계약 테이블 시퀀스--*/
create sequence consumercon_seq;