package com.pj.gajobs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj.gajobs.dao.ConsumerDao;
import com.pj.gajobs.model.Company;
import com.pj.gajobs.model.Consumer;
import com.pj.gajobs.model.ConsumerCon;
import com.pj.gajobs.model.ConsumerFile;

@Service
public class ConsumerServiceImpl implements ConsumerService{
	@Autowired
	private ConsumerDao cd;

	public List<Consumer> consumerList(Consumer consumer) {
		return cd.consumerList(consumer);
	}

	public int getTotal(Consumer consumer) {
		return cd.getTotal(consumer);
	}

	public int getMaxNum() {
		return cd.getMaxNum();
	}

	public int insertConsumer(Consumer consumer) {
		return cd.insertConsumer(consumer);
	}

	public int insertFile(ConsumerFile consumerFile) {
		return cd.insertFile(consumerFile);
	}

	public Consumer selectConsumer(int c_num) {
		return cd.selectConsumer(c_num);
	}

	public int fileCount(int c_num) {
		return cd.fileCount(c_num);
	}

	public List<ConsumerCon> conList(ConsumerCon consumerCon) {
		return cd.conList(consumerCon);
	}

	public int getTotalCon(ConsumerCon consumerCon) {
		return cd.getTotalCon(consumerCon);
	}

	public List<Company> comList() {
		return cd.comList();
	}

	public void insertContract(List<ConsumerCon> consumerConlist) {
		for(ConsumerCon consumerCon : consumerConlist) {
			cd.insertContract(consumerCon);
		}
		
	}

	public int contractDel(int cc_seq) {
		return cd.contractDel(cc_seq);
	}

	public int selectContract(int cc_seq) {
		return cd.selectContract(cc_seq);
	}

	public ConsumerCon selectContractAll(int cc_seq) {
		return cd.selectContractAll(cc_seq);
	}

	public int updateContract(ConsumerCon consumerCon) {
		return cd.updateContract(consumerCon);
	}

	public int contractCountByNum(int c_num) {
		return cd.contractCountByNum(c_num);
	}

	public int contractDelByNum(int c_num) {
		return cd.contractDelByNum(c_num);
	}

	public int consumerDelete(int c_num) {
		return cd.consumerDelete(c_num);
	}

	public int fileCountByNum(int c_num) {
		return cd.fileCountByNum(c_num);
	}

	public int filedelete(int c_num) {
		return cd.filedelete(c_num);
	}

	public List<ConsumerFile> fileSelectByNum(int c_num) {
		return cd.fileSelectByNum(c_num);
	}

	public ConsumerFile selectFileByseq(int cf_seq) {
		return cd.selectFileByseq(cf_seq);
	}

	public void deleteFilebySeq(int cf_seq) {
		cd.deleteFilebySeq(cf_seq);
	}

	public int updateConsumer(Consumer consumer) {
		return cd.updateConsumer(consumer);
	}

	public int conCount(Consumer consumer) {
		return cd.conCount(consumer);
	}

	public List<Consumer> consumerListByDate(Consumer consumer) {
		return cd.consumerListByDate(consumer);
	}
	

}
