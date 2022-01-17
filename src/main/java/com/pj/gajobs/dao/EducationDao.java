package com.pj.gajobs.dao;

import java.util.List;

import com.pj.gajobs.model.Education;
import com.pj.gajobs.model.EducationFile;
import com.pj.gajobs.model.EducationRe;

public interface EducationDao {

	List<Education> eduList(Education education);

	int getTotal(Education education);

	int insert(Education education);

	int getMaxNum();

	void insertFile(EducationFile educationFile);

	void updateCount(int e_num);

	Education select(int e_num);

	List<EducationFile> selectFile(int e_num);

	List<EducationRe> selectRe(int e_num);

	EducationFile selectFilebyseq(int ef_seq);

	int countByNum(int e_num);

	int reCountByNum(int e_num);

	int deleteFile(int e_num);

	int reDeleteByNum(int e_num);

	int delete(int e_num);

	void deleteBySeq(int ef_seq);

	void insertRe(EducationRe educationRe);

	void deleteRe(int er_seq);

	int update(Education education);

	int eduCount(Education education);

	List<Education> eduListByDate(Education education);

}
