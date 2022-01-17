package com.pj.gajobs.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pj.gajobs.model.Company;
import com.pj.gajobs.model.Consumer;
import com.pj.gajobs.model.ConsumerCon;
import com.pj.gajobs.model.ConsumerFile;

@Repository
public class ConsumerDaoImpl implements ConsumerDao {
	@Autowired
	private SqlSessionTemplate sst;

	public List<Consumer> consumerList(Consumer consumer) {
		return sst.selectList("consumerns.consumerList", consumer);
	}

	public int getTotal(Consumer consumer) {
		return sst.selectOne("consumerns.getTotal",consumer);
	}

	public int getMaxNum() {
		return sst.selectOne("consumerns.getMaxNum");
	}

	public int insertConsumer(Consumer consumer) {
		return sst.insert("consumerns.insertConsumer",consumer);
	}

	public int insertFile(ConsumerFile consumerFile) {
		return sst.insert("consumerns.insertFile",consumerFile);
	}

	public Consumer selectConsumer(int c_num) {
		return sst.selectOne("consumerns.selectConsumer",c_num);
	}

	public int fileCount(int c_num) {
		return sst.selectOne("consumerns.fileCount",c_num);
	}

	public List<ConsumerCon> conList(ConsumerCon consumerCon) {
		return sst.selectList("consumerns.conList",consumerCon);
	}

	public int getTotalCon(ConsumerCon consumerCon) {
		return sst.selectOne("consumerns.getTotalCon",consumerCon);
	}

	public List<Company> comList() {
		return sst.selectList("consumerns.comList");
	}

	public void insertContract(ConsumerCon consumerCon) {
		 sst.insert("consumerns.insertContract",consumerCon);
	}

	public int contractDel(int cc_seq) {
		return sst.delete("consumerns.contractDel",cc_seq);
	}

	public int selectContract(int cc_seq) {
		return sst.selectOne("consumerns.selectContract",cc_seq);
	}

	public ConsumerCon selectContractAll(int cc_seq) {
		return sst.selectOne("consumerns.selectContractAll",cc_seq);
	}

	public int updateContract(ConsumerCon consumerCon) {
		return sst.update("consumerns.updateContract",consumerCon);
	}

	public int contractCountByNum(int c_num) {
		return sst.selectOne("consumerns.contractCountByNum",c_num);
	}

	public int contractDelByNum(int c_num) {
		return sst.delete("consumerns.contractDelByNum",c_num);
	}

	public int consumerDelete(int c_num) {
		return sst.delete("consumerns.consumerDelete",c_num);
	}

	public int fileCountByNum(int c_num) {
		return sst.selectOne("consumerns.fileCountByNum",c_num);
	}

	public int filedelete(int c_num) {
		return sst.delete("consumerns.filedelete",c_num);
	}

	public List<ConsumerFile> fileSelectByNum(int c_num) {
		return sst.selectList("consumerns.fileSelectByNum",c_num);
	}

	public ConsumerFile selectFileByseq(int cf_seq) {
		return sst.selectOne("consumerns.selectFileByseq",cf_seq);
	}

	public void deleteFilebySeq(int cf_seq) {
		sst.delete("consumerns.deleteFilebySeq",cf_seq);
	}

	public int updateConsumer(Consumer consumer) {
		return sst.update("consumerns.updateConsumer",consumer);
	}

	public int conCount(Consumer consumer) {
		return sst.selectOne("consumerns.conCount",consumer);
	}

	public List<Consumer> consumerListByDate(Consumer consumer) {
		return sst.selectList("consumerns.consumerListByDate",consumer);
	}
}
