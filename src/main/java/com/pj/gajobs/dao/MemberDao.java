package com.pj.gajobs.dao;

import java.util.List;

import com.pj.gajobs.model.AppointFile;
import com.pj.gajobs.model.Branch;
import com.pj.gajobs.model.Member;
import com.pj.gajobs.model.Role;
import com.pj.gajobs.model.Team;

public interface MemberDao {
	
	int setUp(Member member);
	
	Member select(String m_id);
	
	int updateUser(Member member);

	List<Member> memberList(Member member);

	int getTotal(Member member);

	List<Member> mgrlist();

	List<Branch> branchList();

	List<Role> roleList();

	List<Team> teamList(int b_seq);

	List<Member> mgrSearch(Member member);

	int insert(Member member);

	int insertFile(AppointFile appointFile);

	List<Branch> branchJoinList(Branch branch);

	int getBranchTotal(Branch branch);

	List<AppointFile> fileList(String m_id);

	int fileCount(String m_id);

	AppointFile selectFileByseq(int af_seq);

	int delete(String m_id);

	int deleteFile(String m_id);

	Branch branchSelectName(String b_name);

	int insertBranch(Branch branch);

	void deleteBySeq(int af_seq);

	void reSetPass(Member reSetMember);

	int updateWithPass(Member member);

	int update(Member member);

	Branch branchSelectSeq(int b_seq);

	int mCountByBranch(int b_seq);

	int tCountByBranch(int b_seq);

	int branchUpdate(Branch branch);

	int teamDelbyBranch(int b_seq);

	int branchDel(int b_seq);

	int leaveCount(int b_seq);

	Team teamChk(Team team);

	int insertTeam(Team team);

	List<Member> memberListByTseq(Member member);

	int getTotalByTseq(Member member);

	Team teamSelectByseq(int t_seq);

	int mCountByTeam(int t_seq);

	int leaveCountByTseq(int t_seq);

	int deleteTeam(int t_seq);

	int updateTeam(Team team);

	int reEntred(String m_id);

	List<Member> bondMemberList(Member member);

	List<Member> selectByBond(String m_id);


}
