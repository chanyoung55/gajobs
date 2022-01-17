package com.pj.gajobs.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pj.gajobs.model.Bond;
import com.pj.gajobs.model.BondFile;

@Repository
public class BondDaoImpl implements BondDao {
	@Autowired
	SqlSessionTemplate sst;

	public List<Bond> bondList(Bond bond) {
		return sst.selectList("bondns.bondList",bond);
	}

	public int getTotal(Bond bond) {
		return sst.selectOne("bondns.getTotal",bond);
	}

	public int getMaxNumByBond() {
		return sst.selectOne("bondns.getMaxNumByBond");
	}

	public int insertBond(Bond bond) {
		return sst.insert("bondns.insertBond",bond);
	}

	public int insertBondFile(BondFile bondFile) {
		return sst.insert("bondns.insertBondFile",bondFile);
	}

	public Bond selectBond(int bo_num) {
		return sst.selectOne("bondns.selectBond",bo_num);
	}

	public BondFile fileSelectByNum(int bo_num) {
		return sst.selectOne("bondns.fileSelectByNum",bo_num);
	}

	public int deleteBondFile(int bo_num) {
		return sst.delete("bondns.deleteBondFile",bo_num);
	}

	public int deleteBond(int bo_num) {
		return sst.delete("bondns.deleteBond",bo_num);
	}

	public int fileCount(int bo_num) {
		return sst.selectOne("bondns.fileCount",bo_num);
	}

	public BondFile selectFileByseq(int bof_seq) {
		return sst.selectOne("bondns.selectFileByseq",bof_seq);
	}

	public int updateBond(Bond bond) {
		return sst.update("bondns.updateBond",bond);
	}

	public int updateBondFile(BondFile bondFile) {
		return sst.update("bondns.updateBondFile",bondFile);
	}

}
