package com.pj.gajobs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj.gajobs.dao.ReferenceDao;
import com.pj.gajobs.model.Reference;
import com.pj.gajobs.model.ReferenceFile;
import com.pj.gajobs.model.ReferenceKind;

@Service
public class ReferenceServiceImpl implements ReferenceSevice {
	@Autowired
	private ReferenceDao rd;

	public List<Reference> referenceList(Reference reference) {
		return rd.referenceList(reference);
	}

	public int getTotal(Reference reference) {
		return rd.getTotal(reference);
	}

	public List<ReferenceFile> fileList() {
		return rd.fileList();
	}

	public List<ReferenceKind> kindList() {
		return rd.kindList();
	}

	public int getMaxNum() {
		return rd.getMaxNum();
	}

	public int insert(Reference reference) {
		return rd.insert(reference);
	}

	public void insertFile(List<ReferenceFile> list) {
		for(ReferenceFile referenceFile : list) {
			rd.insertFile(referenceFile);
		}
		
	}

	public ReferenceFile selectFilebyseq(int rff_seq) {
		return rd.selectFilebyseq(rff_seq);
	}

	public Reference select(int rf_num) {
		return rd.select(rf_num);
	}

	public List<ReferenceFile> selectFilebyNum(int rf_num) {
		return rd.selectFilebyNum(rf_num);
	}

	public int fileByNumCount(int rf_num) {
		return rd.fileByNumCount(rf_num);
	}

	public int fileDelByNum(int rf_num) {
		return rd.fileDelByNum(rf_num);
	}

	public int referenceDel(int rf_num) {
		return rd.referenceDel(rf_num);
	}

	public void deleteBySeq(int rff_seq) {
		rd.deleteBySeq(rff_seq);
	}

	public int update(Reference reference) {
		return rd.update(reference);
	}

	public int refCount(Reference reference) {
		return rd.refCount(reference);
	}

	public List<Reference> referenceListByDate(Reference reference) {
		return rd.referenceListByDate(reference);
	}
}
