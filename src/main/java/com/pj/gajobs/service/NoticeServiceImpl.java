package com.pj.gajobs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj.gajobs.dao.NoticeDao;
import com.pj.gajobs.model.Notice;
import com.pj.gajobs.model.NoticeFile;
import com.pj.gajobs.model.NoticeRe;

@Service
public class NoticeServiceImpl implements NoticeService{
	
	@Autowired
	private NoticeDao nd;

	public List<Notice> noticeList(Notice notice) {
		return nd.noticeList(notice);
	}

	public int getTotal(Notice notice) {
		return nd.getTotal(notice);
	}

	public int getMaxNum() {
		return nd.getNaxNum();
	}

	public int insert(Notice notice) {
		return nd.insert(notice);
	}

	public void insertFile(List<NoticeFile> list) {
		for(NoticeFile noticefile : list) {
			nd.insertFile(noticefile);
		}
		
	}

	public Notice select(int n_num) {
		return nd.select(n_num);
	}

	public List<NoticeFile> selectFile(int n_num) {
		return nd.selectFile(n_num);
	}

	public NoticeFile selectFilebyseq(int nf_seq) {
		return nd.selectFilebyseq(nf_seq);
	}

	public void updateCount(int n_num) {
		nd.updateCount(n_num);
		
	}

	public int deleteFile(int n_num) {
		return nd.deleteFile(n_num);
	}
	
	public int delete(int n_num) {
		return nd.delete(n_num);
	}

	public int countByNum(int n_num) {
		return nd.countByNum(n_num);
	}

	public void deleteBySeq(int nf_seq) {
		nd.deleteBySeq(nf_seq);
		
	}

	public int update(Notice notice) {
		return nd.update(notice);
	}

	public void insertRe(NoticeRe noticeRe) {
		nd.insertRe(noticeRe);
		
	}

	public List<NoticeRe> selectRe(int n_num) {
		return nd.selectRe(n_num);
	}

	public void deleteRe(int nr_seq) {
		nd.deleteRe(nr_seq);
	}

	public int reCountByNum(int n_num) {
		return nd.reCountByNum(n_num);
	}

	public int reDeleteByNum(int n_num) {
		return nd.reDeleteByNum(n_num);
	}

	public int noticeCount(Notice notice) {
		return nd.noticeCount(notice);
	}

	public List<Notice> noticeListByDate(Notice notice) {
		return nd.noticeListByDate(notice);
	}

}
