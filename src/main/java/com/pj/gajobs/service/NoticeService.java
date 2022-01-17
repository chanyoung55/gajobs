package com.pj.gajobs.service;

import java.util.List;

import com.pj.gajobs.model.Notice;
import com.pj.gajobs.model.NoticeFile;
import com.pj.gajobs.model.NoticeRe;

public interface NoticeService {

	List<Notice> noticeList(Notice notice);

	int getTotal(Notice notice);

	int getMaxNum();

	int insert(Notice notice);

	void insertFile(List<NoticeFile> list);

	Notice select(int n_num);

	List<NoticeFile> selectFile(int n_num);

	NoticeFile selectFilebyseq(int nf_seq);

	void updateCount(int n_num);

	int deleteFile(int n_num);
	
	int delete(int n_num);

	int countByNum(int n_num);

	void deleteBySeq(int nf_seq);

	int update(Notice notice);

	void insertRe(NoticeRe noticeRe);

	List<NoticeRe> selectRe(int n_num);

	void deleteRe(int nr_seq);

	int reCountByNum(int n_num);

	int reDeleteByNum(int n_num);

	int noticeCount(Notice notice);

	List<Notice> noticeListByDate(Notice notice);

}
