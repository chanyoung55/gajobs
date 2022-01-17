package com.pj.gajobs.dao;

import java.util.List;

import com.pj.gajobs.model.Reference;
import com.pj.gajobs.model.ReferenceFile;
import com.pj.gajobs.model.ReferenceKind;

public interface ReferenceDao {

	List<Reference> referenceList(Reference reference);

	int getTotal(Reference reference);

	List<ReferenceFile> fileList();

	List<ReferenceKind> kindList();

	int getMaxNum();

	int insert(Reference reference);

	void insertFile(ReferenceFile referenceFile);

	ReferenceFile selectFilebyseq(int rff_seq);

	Reference select(int rf_num);

	List<ReferenceFile> selectFilebyNum(int rf_num);

	int fileByNumCount(int rf_num);

	int fileDelByNum(int rf_num);

	int referenceDel(int rf_num);

	void deleteBySeq(int rff_seq);

	int update(Reference reference);

	int refCount(Reference reference);

	List<Reference> referenceListByDate(Reference reference);

}
