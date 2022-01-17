package com.pj.gajobs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj.gajobs.dao.HelpDao;
import com.pj.gajobs.model.Company;
import com.pj.gajobs.model.Email;
import com.pj.gajobs.model.Help;
import com.pj.gajobs.model.HelpFile;

@Service
public class HelpServiceImpl implements HelpService{
	@Autowired
	private HelpDao hd;

	public int getMaxNum() {
		return hd.getMaxNum();
	}

	public int sendHelp(Help help) {
		return hd.sendHelp(help);
	}

	public void sendFile(List<HelpFile> helpFileList) {
		for(HelpFile hf : helpFileList) {
			hd.sendFile(hf);
		}
	}

	public List<Help> readHelp(Help help) {
		return hd.readHelp(help);
	}

	public int getTotal(Help help) {
		return hd.getTotal(help);
	}

	public Help readHelpByNum(int h_num) {
		return hd.readHelpByNum(h_num);
	}

	public List<HelpFile> fileListByNum(int h_num) {
		return hd.fileListByNum(h_num);
	}

	public int read(int h_num) {
		return hd.read(h_num);
	}

	public int notRead(int h_num) {
		return hd.notRead(h_num);
	}

	public HelpFile selectfileByseq(int hf_seq) {
		return hd.selectfileByseq(hf_seq);
	}

	public int fileCountByNum(int h_num) {
		return hd.fileCountByNum(h_num);
	}

	public int deleteFileByNum(int h_num) {
		return hd.deleteFileByNum(h_num);
	}

	public int deleteHelpByNum(int h_num) {
		return hd.deleteHelpNum(h_num);
	}

	public int getEmailMaxNum() {
		return hd.getEmailMaxNum();
	}
	
	public int insertEmail(Email email) {
		return hd.insertEmail(email);
	}

	public List<Email> emailList(Email email) {
		return hd.emailList(email);
	}

	public int getEmailTotal(Email email) {
		return hd.getEmailTotal(email);
	}

	public Email selectEmailByNum(int em_num) {
		return hd.selectEmailByNum(em_num);
	}

	public List<Company> comList(Company company) {
		return hd.comList(company);
	}

	public int getComTotal(Company company) {
		return hd.getComTotal(company);
	}

	public Company selectComBySeq(int cp_seq) {
		return hd.selectComBySeq(cp_seq);
	}

	public int updateCom(Company company) {
		return hd.updateCom(company);
	}

	public int deleteCom(int cp_seq) {
		return hd.deleteCom(cp_seq);
	}

	public int activeCom(int cp_seq) {
		return hd.activeCom(cp_seq);
	}

	public int emailDelete(int em_num) {
		return hd.emailDelete(em_num);
	}

}
