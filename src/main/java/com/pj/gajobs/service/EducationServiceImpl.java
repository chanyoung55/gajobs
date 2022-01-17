package com.pj.gajobs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj.gajobs.dao.EducationDao;
import com.pj.gajobs.model.Education;
import com.pj.gajobs.model.EducationFile;
import com.pj.gajobs.model.EducationRe;

@Service
public class EducationServiceImpl implements EducationService {
	@Autowired
	private EducationDao ed;

	public List<Education> eduList(Education education) {
		return ed.eduList(education);
	}

	public int getTotal(Education education) {
		return ed.getTotal(education);
	}


	public int insert(Education education) {
		return ed.insert(education);
	}

	public int getMaxNum() {
		return ed.getMaxNum();
	}

	public void insertFile(List<EducationFile> list) {
		for(EducationFile educationFile : list) {
			ed.insertFile(educationFile);
		}
	}

	public void updateCount(int e_num) {
		ed.updateCount(e_num);
	}

	public Education select(int e_num) {
		return ed.select(e_num);
	}

	public List<EducationFile> selectFile(int e_num) {
		return ed.selectFile(e_num);
	}

	public List<EducationRe> selectRe(int e_num) {
		return ed.selectRe(e_num);
	}

	public EducationFile selectFilebyseq(int ef_seq) {
		return ed.selectFilebyseq(ef_seq);
	}

	public int countByNum(int e_num) {
		return ed.countByNum(e_num);
	}

	public int reCountByNum(int e_num) {
		return ed.reCountByNum(e_num);
	}

	public int deleteFile(int e_num) {
		return ed.deleteFile(e_num);
	}

	public int reDeleteByNum(int e_num) {
		return ed.reDeleteByNum(e_num);
	}

	public int delete(int e_num) {
		return ed.delete(e_num);
	}

	public void deleteBySeq(int ef_seq) {
		ed.deleteBySeq(ef_seq);
	}

	public void insertRe(EducationRe educationRe) {
		ed.insertRe(educationRe);
	}

	public void deleteRe(int er_seq) {
		ed.deleteRe(er_seq);
	}

	public int update(Education education) {
		return ed.update(education);
	}

	public int eduCount(Education education) {
		return ed.eduCount(education);
	}

	public List<Education> eduListByDate(Education education) {
		return ed.eduListByDate(education);
	}
}
