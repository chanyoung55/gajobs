package com.pj.gajobs.dao;

import java.util.List;

import com.pj.gajobs.model.Company;
import com.pj.gajobs.model.Email;
import com.pj.gajobs.model.Help;
import com.pj.gajobs.model.HelpFile;

public interface HelpDao {

	int getMaxNum();

	int sendHelp(Help help);

	void sendFile(HelpFile hf);

	List<Help> readHelp(Help help);

	int getTotal(Help help);

	Help readHelpByNum(int h_num);

	List<HelpFile> fileListByNum(int h_num);

	int read(int h_num);

	int notRead(int h_num);

	HelpFile selectfileByseq(int hf_seq);

	int fileCountByNum(int h_num);

	int deleteFileByNum(int h_num);

	int deleteHelpNum(int h_num);

	int getEmailMaxNum();
	
	int insertEmail(Email email);

	List<Email> emailList(Email email);

	int getEmailTotal(Email email);

	Email selectEmailByNum(int em_num);

	List<Company> comList(Company company);

	int getComTotal(Company company);

	Company selectComBySeq(int cp_seq);

	int updateCom(Company company);

	int deleteCom(int cp_seq);

	int activeCom(int cp_seq);

	int emailDelete(int em_num);

}
