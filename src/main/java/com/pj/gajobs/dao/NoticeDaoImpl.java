package com.pj.gajobs.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pj.gajobs.model.Notice;
import com.pj.gajobs.model.NoticeFile;
import com.pj.gajobs.model.NoticeRe;

@Repository
public class NoticeDaoImpl implements NoticeDao {
	
	@Autowired
	private SqlSessionTemplate sst;

	public List<Notice> noticeList(Notice notice) {
		return sst.selectList("noticens.noticeList",notice);
	}

	public int getTotal(Notice notice) {
		return sst.selectOne("noticens.getTotal",notice);
	}

	public int getNaxNum() {
		return sst.selectOne("noticens.getMaxNum");
	}

	public int insert(Notice notice) {
		return sst.insert("noticens.insert",notice);
	}

	public void insertFile(NoticeFile noticefile) {
		sst.insert("noticens.insertFile",noticefile);
		
	}

	public Notice select(int n_num) {
		return sst.selectOne("noticens.select",n_num);
	}

	public List<NoticeFile> selectFile(int n_num) {
		return sst.selectList("noticens.selectFile",n_num);
	}

	public NoticeFile selectFilebyseq(int nf_seq) {
		return sst.selectOne("noticens.selectFilebyseq",nf_seq);
	}

	public void updateCount(int n_num) {
		sst.update("noticens.updateCount",n_num);
		
	}
	
	public int deleteFile(int n_num) {
		return sst.delete("noticens.deleteFile",n_num);
	}
	
	public int delete(int n_num) {
		return sst.delete("noticens.delete", n_num);
	}

	public int countByNum(int n_num) {
		return sst.selectOne("noticens.countByNum",n_num);
	}

	public void deleteBySeq(int nf_seq) {
		sst.delete("noticens.deleteBySeq",nf_seq);
	}

	public int update(Notice notice) {
		return sst.update("noticens.update",notice);
	}

	public void insertRe(NoticeRe noticeRe) {
		sst.insert("noticens.insertRe",noticeRe);
	}

	public List<NoticeRe> selectRe(int n_num) {
		return sst.selectList("noticens.selectRe",n_num);
	}

	public void deleteRe(int nr_seq) {
		sst.delete("noticens.deleteRe",nr_seq);
	}

	public int reCountByNum(int n_num) {
		return sst.selectOne("noticens.reCountByNum",n_num);
	}

	public int reDeleteByNum(int n_num) {
		return sst.delete("noticens.reDeleteByNum",n_num);
	}

	public int noticeCount(Notice notice) {
		return sst.selectOne("noticens.noticeCount",notice);
	}

	public List<Notice> noticeListByDate(Notice notice) {
		return sst.selectList("noticens.noticeListByDate",notice);
	}

}
