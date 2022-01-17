package com.pj.gajobs.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pj.gajobs.model.Company;
import com.pj.gajobs.model.Email;
import com.pj.gajobs.model.Help;
import com.pj.gajobs.model.HelpFile;

@Repository
public class HelpDaoImpl implements HelpDao {
	@Autowired
	private SqlSessionTemplate sst;

	public int getMaxNum() {
		return sst.selectOne("helpns.getMaxNum");
	}

	public int sendHelp(Help help) {
		return sst.insert("helpns.sendHelp",help);
	}

	public void sendFile(HelpFile hf) {
		sst.insert("helpns.sendFile",hf);
	}

	public List<Help> readHelp(Help help) {
		return sst.selectList("helpns.readHelp",help);
	}

	public int getTotal(Help help) {
		return sst.selectOne("helpns.getTotal",help);
	}

	public Help readHelpByNum(int h_num) {
		return sst.selectOne("helpns.readHelpByNum",h_num);
	}

	public List<HelpFile> fileListByNum(int h_num) {
		return sst.selectList("helpns.fileListByNum",h_num);
	}

	public int read(int h_num) {
		return sst.update("helpns.read",h_num);
	}

	public int notRead(int h_num) {
		return sst.update("helpns.notRead",h_num);
	}

	public HelpFile selectfileByseq(int hf_seq) {
		return sst.selectOne("helpns.selectfileByseq",hf_seq);
	}

	public int fileCountByNum(int h_num) {
		return sst.selectOne("helpns.fileCountByNum",h_num);
	}

	public int deleteFileByNum(int h_num) {
		return sst.delete("helpns.deleteFileByNum",h_num);
	}

	public int deleteHelpNum(int h_num) {
		return sst.delete("helpns.deleteHelpNum",h_num);
	}

	public int getEmailMaxNum() {
		return sst.selectOne("helpns.getEmailMaxNum");
	}
	
	public int insertEmail(Email email) {
		return sst.insert("helpns.insertEmail",email);
	}

	public List<Email> emailList(Email email) {
		return sst.selectList("helpns.emailList",email);
	}

	public int getEmailTotal(Email email) {
		return sst.selectOne("helpns.getEmailTotal",email);
	}

	public Email selectEmailByNum(int em_num) {
		return sst.selectOne("helpns.selectEmailByNum",em_num);
	}

	public List<Company> comList(Company company) {
		return sst.selectList("helpns.comList",company);
	}

	public int getComTotal(Company company) {
		return sst.selectOne("helpns.getComTotal",company);
	}

	public Company selectComBySeq(int cp_seq) {
		return sst.selectOne("helpns.selectComBySeq",cp_seq);
	}

	public int updateCom(Company company) {
		return sst.update("helpns.updateCom",company);
	}

	public int deleteCom(int cp_seq) {
		return sst.update("helpns.deleteCom",cp_seq);
	}

	public int activeCom(int cp_seq) {
		return sst.update("helpns.activeCom",cp_seq);
	}

	public int emailDelete(int em_num) {
		return sst.update("helpns.emailDelete",em_num);
	}

}
