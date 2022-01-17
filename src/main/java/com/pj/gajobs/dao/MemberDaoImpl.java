package com.pj.gajobs.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pj.gajobs.model.AppointFile;
import com.pj.gajobs.model.Branch;
import com.pj.gajobs.model.Member;
import com.pj.gajobs.model.Role;
import com.pj.gajobs.model.Team;

@Repository
public class MemberDaoImpl implements MemberDao {
	
	@Autowired
	private SqlSessionTemplate sst;
	
	public int setUp(Member member) {
		return sst.update("memberns.setUp",member);
	}

	public Member select(String m_id) {
		return sst.selectOne("memberns.select",m_id);
	}

	public int updateUser(Member member) {
		return sst.update("memberns.updateUser",member);
	}

	public List<Member> memberList(Member member) {
		return sst.selectList("memberns.memberList",member);
	}

	public int getTotal(Member member) {
		return sst.selectOne("memberns.getTotal",member);
	}

	public List<Member> mgrlist() {
		return sst.selectList("memberns.mgrlist");
	}

	public List<Branch> branchList() {
		return sst.selectList("memberns.branchList");
	}

	public List<Role> roleList() {
		return sst.selectList("memberns.roleList");
	}

	public List<Team> teamList(int b_seq) {
		return sst.selectList("memberns.teamList",b_seq);
	}

	public List<Member> mgrSearch(Member member) {
		return sst.selectList("memberns.mgrSearch",member);
	}

	public int insert(Member member) {
		return sst.insert("memberns.insert",member);
	}

	public int insertFile(AppointFile appointFile) {
		return sst.insert("memberns.insertFile",appointFile);
	}

	public List<Branch> branchJoinList(Branch branch) {
		return sst.selectList("memberns.branchJoinList",branch);
	}

	public int getBranchTotal(Branch branch) {
		return sst.selectOne("memberns.getBranchTotal",branch);
	}

	public List<AppointFile> fileList(String m_id) {
		return sst.selectList("memberns.fileList",m_id);
	}

	public int fileCount(String m_id) {
		return sst.selectOne("memberns.fileCount",m_id);
	}

	public AppointFile selectFileByseq(int af_seq) {
		return sst.selectOne("memberns.selectFileByseq",af_seq);
	}

	public int delete(String m_id) {
		return sst.update("memberns.delete",m_id);
	}

	public int deleteFile(String m_id) {
		return sst.delete("memberns.deleteFile",m_id);
	}

	public Branch branchSelectName(String b_name) {
		return sst.selectOne("memberns.branchSelectName",b_name);
	}

	public int insertBranch(Branch branch) {
		return sst.insert("memberns.insertBranch",branch);
	}

	public void deleteBySeq(int af_seq) {
		sst.delete("memberns.deleteBySeq",af_seq);
		
	}

	public void reSetPass(Member reSetMember) {
		sst.update("memberns.reSetPass",reSetMember);
	}

	public int updateWithPass(Member member) {
		return sst.update("memberns.updateWithPass",member);
	}

	public int update(Member member) {
		return sst.update("memberns.update",member);
	}

	public Branch branchSelectSeq(int b_seq) {
		return sst.selectOne("memberns.branchSelectSeq",b_seq);
	}

	public int mCountByBranch(int b_seq) {
		return sst.selectOne("memberns.mCountByBranch", b_seq);
	}

	public int tCountByBranch(int b_seq) {
		return sst.selectOne("memberns.tCountByBranch", b_seq);
	}

	public int branchUpdate(Branch branch) {
		return sst.update("memberns.branchUpdate",branch);
	}

	public int teamDelbyBranch(int b_seq) {
		return sst.delete("memberns.teamDelbyBranch",b_seq);
	}

	public int branchDel(int b_seq) {
		return sst.delete("memberns.branchDel",b_seq);
	}

	public int leaveCount(int b_seq) {
		return sst.selectOne("memberns.leaveCount",b_seq);
	}

	public Team teamChk(Team team) {
		return sst.selectOne("memberns.teamChk", team);
	}

	public int insertTeam(Team team) {
		return sst.insert("memberns.insertTeam",team);
	}

	public List<Member> memberListByTseq(Member member) {
		return sst.selectList("memberns.memberListByTseq",member);
	}

	public int getTotalByTseq(Member member) {
		return sst.selectOne("memberns.getTotalByTseq",member);
	}

	public Team teamSelectByseq(int t_seq) {
		return sst.selectOne("memberns.teamSelectByseq",t_seq);
	}

	public int mCountByTeam(int t_seq) {
		return sst.selectOne("memberns.mCountByTeam",t_seq);
	}

	public int leaveCountByTseq(int t_seq) {
		return sst.selectOne("memberns.leaveCountByTseq",t_seq);
	}

	public int deleteTeam(int t_seq) {
		return sst.delete("memberns.deleteTeam",t_seq);
	}


	public int updateTeam(Team team) {
		return sst.update("memberns.updateTeam",team);
	}

	public int reEntred(String m_id) {
		return sst.update("memberns.reEntred",m_id);
	}

	public List<Member> bondMemberList(Member member) {
		return sst.selectList("memberns.bondMemberList",member);
	}

	public List<Member> selectByBond(String m_id) {
		return sst.selectList("memberns.selectByBond",m_id);
	}

}
