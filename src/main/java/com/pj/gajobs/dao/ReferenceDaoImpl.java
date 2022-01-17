package com.pj.gajobs.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pj.gajobs.model.Reference;
import com.pj.gajobs.model.ReferenceFile;
import com.pj.gajobs.model.ReferenceKind;

@Repository
public class ReferenceDaoImpl implements ReferenceDao {
	
	@Autowired
	SqlSessionTemplate sst;

	public List<Reference> referenceList(Reference reference) {
		return sst.selectList("referencens.referenceList",reference);
	}

	public int getTotal(Reference reference) {
		return sst.selectOne("referencens.getTotal",reference);
	}

	public List<ReferenceFile> fileList() {
		return sst.selectList("referencens.fileList");
	}

	public List<ReferenceKind> kindList() {
		return sst.selectList("referencens.kindList");
	}

	public int getMaxNum() {
		return sst.selectOne("referencens.getMaxNum");
	}

	public int insert(Reference reference) {
		return sst.insert("referencens.insert",reference);
	}

	public void insertFile(ReferenceFile referenceFile) {
		sst.insert("referencens.insertFile",referenceFile);
		
	}

	public ReferenceFile selectFilebyseq(int rff_seq) {
		return sst.selectOne("referencens.selectFilebyseq",rff_seq);
	}

	public Reference select(int rf_num) {
		return sst.selectOne("referencens.select",rf_num);
	}

	public List<ReferenceFile> selectFilebyNum(int rf_num) {
		return sst.selectList("referencens.selectFilebyNum",rf_num);
	}

	public int fileByNumCount(int rf_num) {
		return sst.selectOne("referencens.fileByNumCount",rf_num);
	}

	public int fileDelByNum(int rf_num) {
		return sst.delete("referencens.fileDelByNum",rf_num);
	}

	public int referenceDel(int rf_num) {
		return sst.delete("referencens.referenceDel",rf_num);
	}

	public void deleteBySeq(int rff_seq) {
		sst.delete("referencens.deleteBySeq", rff_seq);
	}

	public int update(Reference reference) {
		return sst.update("referencens.update",reference);
	}

	public int refCount(Reference reference) {
		return sst.selectOne("referencens.refCount",reference);
	}

	public List<Reference> referenceListByDate(Reference reference) {
		return sst.selectList("referencens.referenceListByDate",reference);
	}
	
}
