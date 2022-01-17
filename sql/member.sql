/*-- 권한  --*/
create table role (
	r_code varchar2(5) not null primary key, 
	r_name varchar2(200) not null
);

/*-- 권한 데이터 --*/
insert into role values('a1','FC');
insert into role values('a2','지점총무');
insert into role values('a3','지점장');
insert into role values('a4','지사장');
insert into role values('b1','업무1');
insert into role values('b2','업무2');
insert into role values('b3','업무3');
insert into role values('b4','업무4');
insert into role values('c1','대표');
insert into role values('c2','관리자');

/*-- 지점명  --*/
create table branch (
	b_seq number(4) not null primary key,
	b_name varchar2(20) not null,
	b_date date not null
);

/*-- 지점 시퀀스  --*/
create sequence branch_seq;

/*-- test 지점명 --*/
insert into branch values(branch_seq.nextVal, '관리지점',sysdate);

/*-- 팀명 --*/
create table team (
	t_seq number(4) not null primary key,
	t_name varchar2(20) not null,
	t_date date not null,
	b_seq number(4) not null,
	constraint t_b_seq foreign key(b_seq) references branch(b_seq)
);

/*-- 팀 시퀀스  --*/
create sequence team_seq;

/*-- test 팀명 --*/
insert into team values(team_seq.nextval, '관리팀',sysdate, 1);

/*-- 회원정보 --*/
create table member(
	m_id varchar2(20) not null primary key,
	m_password varchar2(1024) not null,
	m_name varchar2(20) not null,
	m_ssnum varchar2(20) not null,
	m_email varchar2(100) not null,
	m_tel varchar2(20) not null,
	m_hiredate Date not null,
	m_addr varchar2(200) not null,
	m_postcode varchar2(50) not null,
	m_detailaddr varchar2(200) not null,
	m_extraaddr varchar2(200),
	m_del char(1) default 'n' not null,
	m_deldate date,
	m_mgr varchar2(20),
	b_seq number(4) not null,
	r_code varchar2(5) not null,
	t_seq number(4) not null,
	constraint m_b_seq foreign key(b_seq) references branch(b_seq),
	constraint m_r_code foreign key(r_code) references role(r_code),
	constraint m_t_seq foreign key(t_seq) references team(t_seq)
);
drop table member;

/*-- 관리자 ID --*/
insert into member values('admin01','1234','홍길동','910126-1234567','test@gmail.com','010-1234-1234',sysdate,'서울시','123-1','강남','1','n','','','1','c2','1');

/*-- 위촉계약서 --*/
create table appointfile (
	af_seq number(4) not null primary key,
	m_id varchar2(20) not null,
	af_name varchar2(200) not null,
	af_origin varchar2(200) not null,
	af_size number(10) not null,
	af_type varchar2(10) not null,
	af_date date not null,
	af_url varchar2(200) not null,
	constraint af_m_id foreign key(m_id) references member(m_id)
);

/*-- 위촉 계약서 시퀀스  --*/
create sequence appointfile_seq;


	
	
	
	
	
