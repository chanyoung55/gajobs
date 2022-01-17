package com.pj.gajobs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj.gajobs.dao.MemberDao;
import com.pj.gajobs.model.AppointFile;
import com.pj.gajobs.model.Branch;
import com.pj.gajobs.model.Member;
import com.pj.gajobs.model.Role;
import com.pj.gajobs.model.Team;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDao md;
	
	public int setUp(Member member) {
		return md.setUp(member);
	}

	public Member select(String m_id) {
		return md.select(m_id);
	}

	public int updateUser(Member member) {
		return md.updateUser(member);
	}

	public List<Member> memberList(Member member) {
		return md.memberList(member);
	}

	public int getTotal(Member member) {
		return md.getTotal(member);
	}

	public List<Member> mgrlist() {
		return md.mgrlist();
	}

	public List<Branch> branchList() {
		return md.branchList();
	}

	public List<Role> roleList() {
		return md.roleList();
	}

	public List<Team> teamList(int b_seq) {
		return md.teamList(b_seq);
	}

	public List<Member> mgrSearch(Member member) {
		return md.mgrSearch(member);
	}

	public int insert(Member member) {
		return md.insert(member);
	}

	public int insertFile(AppointFile appointFile) {
		return md.insertFile(appointFile);
	}

	public List<Branch> branchJoinList(Branch branch) {
		return md.branchJoinList(branch);
	}

	public int getBranchTotal(Branch branch) {
		return md.getBranchTotal(branch);
	}

	public List<AppointFile> fileList(String m_id) {
		return md.fileList(m_id);
	}

	public int fileCount(String m_id) {
		return md.fileCount(m_id);
	}

	public AppointFile selectFileByseq(int af_seq) {
		return md.selectFileByseq(af_seq);
	}

	public int delete(String m_id) {
		return md.delete(m_id);
	}

	public int deleteFile(String m_id) {
		return md.deleteFile(m_id);
	}

	public Branch branchSelectName(String b_name) {
		return md.branchSelectName(b_name);
	}

	public int insertBranch(Branch branch) {
		return md.insertBranch(branch);
	}


	public void deleteBySeq(int af_seq) {
		md.deleteBySeq(af_seq);
		
	}

	public void reSetPass(Member reSetMember) {
		md.reSetPass(reSetMember);
		
	}

	public int updateWithPass(Member member) {
		return md.updateWithPass(member);
	}

	public int update(Member member) {
		return md.update(member);
	}

	public Branch branchSelectSeq(int b_seq) {
		return md.branchSelectSeq(b_seq);
	}

	public int mCountByBranch(int b_seq) {
		return md.mCountByBranch(b_seq);
	}

	public int tCountByBranch(int b_seq) {
		return md.tCountByBranch(b_seq);
	}

	public int branchUpdate(Branch branch) {
		return md.branchUpdate(branch);
	}

	public int teamDelbyBranch(int b_seq) {
		return md.teamDelbyBranch(b_seq);
	}

	public int branchDel(int b_seq) {
		return md.branchDel(b_seq);
	}

	public int leaveCount(int b_seq) {
		return md.leaveCount(b_seq);
	}

	public Team teamChk(Team team) {
		return md.teamChk(team);
	}

	public int insertTeam(Team team) {
		return md.insertTeam(team);
	}

	public List<Member> memberListByTseq(Member member) {
		return md.memberListByTseq(member);
	}

	public int getTotalByTseq(Member member) {
		return md.getTotalByTseq(member);
	}

	public Team teamSelectByseq(int t_seq) {
		return md.teamSelectByseq(t_seq);
	}

	public int mCountByTeam(int t_seq) {
		return md.mCountByTeam(t_seq);
	}

	public int leaveCountByTseq(int t_seq) {
		return md.leaveCountByTseq(t_seq);
	}

	public int deleteTeam(int t_seq) {
		return md.deleteTeam(t_seq);
	}

	public int updateTeam(Team team) {
		return md.updateTeam(team);
	}

	public int reEntred(String m_id) {
		return md.reEntred(m_id);
	}

	public List<Member> bondMemberList(Member member) {
		return md.bondMemberList(member);
	}

	public List<Member> selectByBond(String m_id) {
		return md.selectByBond(m_id);
	}
}
