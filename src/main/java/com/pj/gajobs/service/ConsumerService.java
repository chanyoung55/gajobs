package com.pj.gajobs.service;

import java.util.List;

import com.pj.gajobs.model.Company;
import com.pj.gajobs.model.Consumer;
import com.pj.gajobs.model.ConsumerCon;
import com.pj.gajobs.model.ConsumerFile;

public interface ConsumerService {

	List<Consumer> consumerList(Consumer consumer);

	int getTotal(Consumer consumer);

	int getMaxNum();

	int insertConsumer(Consumer consumer);

	int insertFile(ConsumerFile consumerFile);

	Consumer selectConsumer(int c_num);

	int fileCount(int c_num);
	
	List<ConsumerCon> conList(ConsumerCon consumerCon);

	int getTotalCon(ConsumerCon consumerCon);

	List<Company> comList();

	void insertContract(List<ConsumerCon> consumerConlist);

	int contractDel(int cc_seq);

	int selectContract(int cc_seq);

	ConsumerCon selectContractAll(int cc_seq);

	int updateContract(ConsumerCon consumerCon);

	int contractCountByNum(int c_num);

	int contractDelByNum(int c_num);

	int consumerDelete(int c_num);

	int fileCountByNum(int c_num);

	int filedelete(int c_num);

	List<ConsumerFile> fileSelectByNum(int c_num);

	ConsumerFile selectFileByseq(int cf_seq);

	void deleteFilebySeq(int cf_seq);

	int updateConsumer(Consumer consumer);

	int conCount(Consumer consumer);

	List<Consumer> consumerListByDate(Consumer consumer);

}
