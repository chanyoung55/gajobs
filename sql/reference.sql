/*-- 서식종류 테이블  --*/
create table ReferenceKind (
	rfk_seq number(4) not null primary key,
	rfk_name varchar2(20) not null
);

/*-- 서식종류 시퀀스  --*/
create sequence referencekind_seq;

/*-- 서식종류 Data  --*/
insert into referencekind values(referencekind_seq.nextVal,'인사');
insert into referencekind values(referencekind_seq.nextVal,'회계');
insert into referencekind values(referencekind_seq.nextVal,'영업');
insert into referencekind values(referencekind_seq.nextVal,'교육');
insert into referencekind values(referencekind_seq.nextVal,'마케팅');
insert into referencekind values(referencekind_seq.nextVal,'기타');

/*-- 서식글 테이블  --*/
create table Reference (
	rf_num number(4) not null primary key,
	rf_writer varchar2(20) not null,
	rf_date	date not null,
	rf_content varchar2(1024) not null,
	rf_count number(10) not null,
	rf_title varchar2(200) not null,
	rfk_seq	number(4) not null,
	m_id varchar2(20) not null,
	constraint rf_m_id foreign key(m_id) references member(m_id),
	constraint rf_rfk_seq foreign key(rfk_seq) references referenceKind(rfk_seq)
);

/*-- 서식파일 테이블  --*/
create table ReferenceFile(
	rff_seq number(4) not null primary key,
	rff_name varchar2(200) not null,
	rff_origin varchar2(200) not null,
	rff_size number(10) not null,
	rff_type varchar2(10) not null,
	rff_date date not null,
	rff_url	varchar2(200) not null,
	rf_num number(4) not null,
	constraint rff_rf_num foreign key(rf_num) references reference(rf_num)
);

/*-- 서식파일 시퀀스  --*/
create sequence referencefile_seq;