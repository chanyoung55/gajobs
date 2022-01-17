package com.pj.gajobs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj.gajobs.dao.BondDao;
import com.pj.gajobs.model.Bond;
import com.pj.gajobs.model.BondFile;

@Service
public class BondServiceImpl implements BondService{
	@Autowired
	private BondDao bd;

	public List<Bond> bondList(Bond bond) {
		return bd.bondList(bond);
	}

	public int getTotal(Bond bond) {
		return bd.getTotal(bond);
	}

	public int getMaxNumByBond() {
		return bd.getMaxNumByBond();
	}

	public int insertBond(Bond bond) {
		return bd.insertBond(bond);
	}

	public int insertBondFile(BondFile bondFile) {
		return bd.insertBondFile(bondFile);
	}

	public Bond selectBond(int bo_num) {
		return bd.selectBond(bo_num);
	}

	public BondFile fileSelectByNum(int bo_num) {
		return bd.fileSelectByNum(bo_num);
	}

	public int deleteBondFile(int bo_num) {
		return bd.deleteBondFile(bo_num);
	}

	public int deleteBond(int bo_num) {
		return bd.deleteBond(bo_num);
	}

	public int fileCount(int bo_num) {
		return bd.fileCount(bo_num);
	}

	public BondFile selectFileByseq(int bof_seq) {
		return bd.selectFileByseq(bof_seq);
	}

	public int updateBond(Bond bond) {
		return bd.updateBond(bond);
	}

	public int updateBondFile(BondFile bondFile) {
		return bd.updateBondFile(bondFile);
	}
}
