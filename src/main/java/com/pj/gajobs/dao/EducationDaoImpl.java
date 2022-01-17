package com.pj.gajobs.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pj.gajobs.model.Education;
import com.pj.gajobs.model.EducationFile;
import com.pj.gajobs.model.EducationRe;

@Repository
public class EducationDaoImpl implements EducationDao {
	@Autowired
	private SqlSessionTemplate sst;

	public List<Education> eduList(Education education) {
		return sst.selectList("educationns.eduList",education);
	}

	public int getTotal(Education education) {
		return sst.selectOne("educationns.getTotal",education);
	}

	public int insert(Education education) {
		return sst.insert("educationns.insert", education);
	}

	public int getMaxNum() {
		return sst.selectOne("educationns.getMaxNum");
	}

	public void insertFile(EducationFile educationFile) {
		sst.insert("educationns.insertFile",educationFile);
	}

	public void updateCount(int e_num) {
		sst.update("educationns.updateCount",e_num);
	}

	public Education select(int e_num) {
		return sst.selectOne("educationns.select", e_num);
	}

	public List<EducationFile> selectFile(int e_num) {
		return sst.selectList("educationns.selectFile",e_num);
	}

	public List<EducationRe> selectRe(int e_num) {
		return sst.selectList("educationns.selectRe",e_num);
	}

	public EducationFile selectFilebyseq(int ef_seq) {
		return sst.selectOne("educationns.selectFilebyseq",ef_seq);
	}

	public int countByNum(int e_num) {
		return sst.selectOne("educationns.countByNum",e_num);
	}

	public int reCountByNum(int e_num) {
		return sst.selectOne("educationns.reCountByNum",e_num);
	}

	public int deleteFile(int e_num) {
		return sst.delete("educationns.deleteFile",e_num);
	}

	public int reDeleteByNum(int e_num) {
		return sst.delete("educationns.reDeleteByNum",e_num);
	}

	public int delete(int e_num) {
		return sst.delete("educationns.delete",e_num);
	}

	public void deleteBySeq(int ef_seq) {
		sst.delete("educationns.deleteBySeq",ef_seq);
	}

	public void insertRe(EducationRe educationRe) {
		sst.insert("educationns.insertRe",educationRe);
	}

	public void deleteRe(int er_seq) {
		sst.delete("educationns.deleteRe",er_seq);
	}

	public int update(Education education) {
		return sst.update("educationns.update",education);
	}

	public int eduCount(Education education) {
		return sst.selectOne("educationns.eduCount",education);
	}

	public List<Education> eduListByDate(Education education) {
		return sst.selectList("educationns.eduListByDate",education);
	}
	
}
