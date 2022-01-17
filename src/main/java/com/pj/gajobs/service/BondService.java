package com.pj.gajobs.service;

import java.util.List;

import com.pj.gajobs.model.Bond;
import com.pj.gajobs.model.BondFile;

public interface BondService {

	List<Bond> bondList(Bond bond);

	int getTotal(Bond bond);

	int getMaxNumByBond();

	int insertBond(Bond bond);

	int insertBondFile(BondFile bondFile);

	Bond selectBond(int bo_num);

	BondFile fileSelectByNum(int bo_num);

	int deleteBondFile(int bo_num);

	int deleteBond(int bo_num);

	int fileCount(int bo_num);

	BondFile selectFileByseq(int bof_seq);

	int updateBond(Bond bond);

	int updateBondFile(BondFile bondFile);

	
}
