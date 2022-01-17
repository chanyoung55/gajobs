package com.pj.gajobs.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.pj.gajobs.model.AppointFile;
import com.pj.gajobs.model.Branch;
import com.pj.gajobs.model.Member;
import com.pj.gajobs.model.Role;
import com.pj.gajobs.model.Team;
import com.pj.gajobs.service.MemberService;
import com.pj.gajobs.service.PageBean;

@Controller
public class MemberController {
	@Autowired
	private MemberService ms;
	
	// 암호화
	@Autowired
	private BCryptPasswordEncoder bpPass;
	
	// 초기 세팅 페이지
	@RequestMapping("notiles/setting")
	public String setting(Model model) {
		String id = "admin01";
		String setPass = "1234";
		
		String dbPass = bpPass.encode(setPass);
		Member member = new Member();
		member.setM_id(id);
		member.setM_password(dbPass);
		int result = ms.setUp(member);
		
		model.addAttribute("result",result);
		return "notiles/setting";
	}
	
//	sideNav 페이지 세션 유지용 메서드
	public void sideNav(HttpSession session, Model model) {
		String m_id = session.getAttribute("id").toString();
		Member member = ms.select(m_id);
		model.addAttribute("sideNav",member);
	}
	
	@RequestMapping("/notiles/loginForm")
	public String loginForm() {
		return "notiles/loginForm";
	}
	
	@RequestMapping("/notiles/login")
	public String login(String m_id, String m_password, HttpSession session , Model model) {
		int result = 0;
		Member member = ms.select(m_id);
		
		if(member != null) {
			if(bpPass.matches(m_password, member.getM_password())){
				result = 1;
				session.setAttribute("id", m_id);
			} else {
				result = -1;
			}
		} else {
			result = -2;
		}

		model.addAttribute("result", result);
		return "notiles/login";
	}
	
	@RequestMapping("/member/userUpdateForm")
	public String userUpdateForm(HttpSession session, Model model) {
		sideNav(session, model);
		
		return "member/userUpdateForm";
	}
	
	@RequestMapping("member/userUpdate")
	public String userUpdate(Member member, Model model) {
		System.out.println(member);
		if(member.getM_password() !="") {
			System.out.println("1");
			String password = bpPass.encode(member.getM_password());
			member.setM_password(password);
		}
		
		System.out.println(member);
		int result = ms.updateUser(member);
		
		model.addAttribute("result", result);
		return "member/userUpdate";
	}
	
	@RequestMapping("/member/memberMain")
	public String memberMain() {
		return "redirect:/member/memberMain/pageNum/1";
	}
	
	@RequestMapping("/member/memberMain/pageNum/{pageNum}")
	public String memberMain(@PathVariable String pageNum, Member member, HttpSession session, Model model) {
		sideNav(session, model);
		
		if(pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int rowPerPage = 5;
		int startRow = (currentPage - 1)*rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;

		member.setStartRow(startRow);
		member.setEndRow(endRow);
		
		// 회원 정보 가져오기
		List<Member> list = ms.memberList(member);
		int total = ms.getTotal(member);
		int num = startRow;
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		String[] titles = {"사번","이름"};
		List<Member> mgrlist = ms.mgrlist(); 
		
		model.addAttribute("mgrlist",mgrlist);
		model.addAttribute("member",member);
		model.addAttribute("titles", titles);
		model.addAttribute("list",list);
		model.addAttribute("pb",pb);
		model.addAttribute("num",num);
		return "member/memberMain"; 
	}
	
	@RequestMapping("member/memberWriteForm")
	public String memberWriteForm(HttpSession session, Model model) {
		sideNav(session, model);
		
		List<Branch> branchList = ms.branchList();
		List<Role> roleList = ms.roleList();
		String[] titles = {"사번","이름"};
		
		model.addAttribute("titles", titles);
		model.addAttribute("branchList",branchList);
		model.addAttribute("roleList",roleList);
		
		return "member/memberWriteForm";
	}
	
	@RequestMapping("member/memberWrite")
	public String memberWrite(MultipartHttpServletRequest mhr,Member member, HttpSession session, Model model) throws IOException {
		Member member2 = ms.select(member.getM_id());
		
		int member_result = 0;
		int file_result = 0;
		
		if(member2 == null) {
			String password = bpPass.encode(member.getM_password()); //비밀번호 암호화
			member.setM_password(password);
			member_result = ms.insert(member);
			MultipartFile isFile = mhr.getFile("file");

			if(!isFile.isEmpty()) {
				/* 파일 업로드 */
				AppointFile appointFile = new AppointFile();
				String origin = mhr.getFile("file").getOriginalFilename(); // 파일 전체이름
				String real = session.getServletContext().getRealPath("/resources/upload/appoint"); // 파일 경로
				FileOutputStream fos = new FileOutputStream(new File(real+"/"+origin));
				fos.write(mhr.getFile("file").getBytes());
				fos.close();
				
				int lastIndex = origin.lastIndexOf("."); // 파일명과 확장자 분리
				String fileName = origin.substring(0,lastIndex); // 파일명
				String type = origin.substring(lastIndex+1); // 확장자
				int size = (int)mhr.getFile("file").getSize(); // 사이즈
				
				appointFile.setAf_origin(origin);
				appointFile.setAf_name(fileName);
				appointFile.setAf_type(type);
				appointFile.setAf_size(size);
				appointFile.setM_id(member.getM_id());
				appointFile.setAf_url(real);
				file_result = ms.insertFile(appointFile);
			} else {
				file_result = -1;
			}
			
		} else {
			member_result = -1;
		}
		
		if(file_result > 0) {
			System.out.println("File Upload Success!");
		} else if(file_result == 0) {
			System.out.println("File Upload False");
		} else {
			System.out.println("File Null");
		}
		
		model.addAttribute("result",member_result);
		
		return "member/memberWrite";
	}
	
	@RequestMapping("member/teamSelect")
	@ResponseBody
	public List<Team> teamSelect(int b_seq) {
		List<Team> teamlist = ms.teamList(b_seq);
		return teamlist;
	}
	@RequestMapping("member/idChk")
	@ResponseBody
	public int idChk(String m_id) {
		int data = 0;
		Member member = ms.select(m_id);
		if(member == null) {
			data = 1;
		} else {
			data = -1;
		}
		return data;
	}
	@RequestMapping("member/mgrSearch")
	@ResponseBody
	public List<Member> mgrSearch(Member member){
		List<Member> mgrlist = ms.mgrSearch(member);
		return mgrlist;
	}
	
	@RequestMapping("member/memberRead/m_id/{m_id}")
	public String memberRead(@PathVariable String m_id, HttpSession session, Model model) {
		sideNav(session, model);
		Member member = ms.select(m_id);
		List<AppointFile> appointFile = ms.fileList(m_id);
		int fileCount = ms.fileCount(m_id);
		
		if(member.getM_mgr() != null) {
			Member mgrInfo = ms.select(member.getM_mgr());
			model.addAttribute("mgrInfo",mgrInfo);
		}
		
		model.addAttribute("fileCount",fileCount);
		model.addAttribute("fileList",appointFile);
		model.addAttribute("member",member);
		return "member/memberRead";
	}
	
	@RequestMapping("member/FileDownload/af_seq/{af_seq}")
	@ResponseBody
	public String FileDownload(@PathVariable int af_seq,HttpServletResponse response,HttpServletRequest request) {
		AppointFile appointFile = ms.selectFileByseq(af_seq);
		String origin = appointFile.getAf_origin();
		String path = appointFile.getAf_url()+"/"+origin;
		File downFile = new File(path);
		
		if(downFile.exists() && downFile.isFile()) {
			try {
				long fileSize = downFile.length();
				response.setContentType("application/x-msdownload");
				response.setContentLength((int)fileSize);
				
				String strClient = request.getHeader("user-agent");
				
				if(strClient.indexOf("MSIE 5.5")!=-1) {
					response.setHeader("Content-Disposition", "filename="+origin+";");
					
				}else {
					origin = URLEncoder.encode(origin,"UTF-8").replaceAll("\\+","%20");
					response.setHeader("Content-Disposition", "attachment; filename=" + origin + ";");
				}
				response.setHeader("Content-Length", String.valueOf(fileSize));
				response.setHeader("Content-Transfer-Encoding", "binary;");

				response.setHeader("Pragma", "no-cache");

				response.setHeader("Cache-Control", "private");
				
				byte b[] = new byte[1024];

				BufferedInputStream fin = new BufferedInputStream(new FileInputStream(downFile));

				BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());

				int read = 0;

				while((read=fin.read(b)) != -1){
					outs.write(b, 0, read);
				}
				outs.flush();
				outs.close();
				fin.close();
			} catch (Exception e) {
				System.out.println("Download Exception : "+e.getMessage());
			}
		} else {
			System.out.println("Download Error : downFile Error["+downFile+"]");
		}
		
		return "member/FileDownload";
	}
	
	@RequestMapping("member/memberDelete/m_id/{m_id}")
	public String memberDelete(@PathVariable String m_id,Model model) {
		int result = ms.delete(m_id);
		int file_result = 0;
		int fileCount = ms.fileCount(m_id);

		if(fileCount > 0) {
			file_result = ms.deleteFile(m_id);
		}
		
		if(file_result > 0) {
			System.out.println(file_result+" files have been deleted");
		} else if(file_result == 0) {
			System.out.println("FILE NULL");
		} else {
			System.out.println("ERROR");
		}
		model.addAttribute("result", result);
		return "member/memberDelete";
	}
	@RequestMapping("member/memberUpdateForm/m_id/{m_id}")
	public String memberUpdateForm(@PathVariable String m_id,HttpSession session,Model model) {
		sideNav(session, model);
		
		Member member = ms.select(m_id);
		List<Branch> branchList = ms.branchList();
		List<Role> roleList = ms.roleList();
		List<AppointFile> fileList = ms.fileList(m_id);
		int fileCount = ms.fileCount(m_id);
		String[] titles = {"사번","이름"};
		
		model.addAttribute("titles", titles);
		model.addAttribute("fileCount",fileCount);
		model.addAttribute("fileList",fileList);
		model.addAttribute("member",member);
		model.addAttribute("branchList", branchList);
		model.addAttribute("roleList", roleList);
		
		return "member/memberUpdateForm";
	}
	@RequestMapping("member/deleteFile")
	@ResponseBody
	public String deleteFile(int af_seq) {
		ms.deleteBySeq(af_seq);
		return "member/deleteFile";
	}
	
	@RequestMapping("member/reSetPass")
	@ResponseBody
	public String reSetPass(String m_id) {
		
		Member member = ms.select(m_id);
		String ssnum = member.getM_ssnum();
		int indexOf = ssnum.indexOf("-");
		String newPass = ssnum.substring(indexOf+1,ssnum.length());
		String password = bpPass.encode(newPass);
		Member resetMember = new Member();
		resetMember.setM_password(password);
		resetMember.setM_id(m_id);
		
		ms.reSetPass(resetMember);
		
		return "member/reSetPass";
	}
	@RequestMapping("member/memberUpdate")
	public String memberUpdate(MultipartHttpServletRequest mhr,Member member, HttpSession session, Model model) throws IOException {
		sideNav(session, model);
		int member_result = 0;
		int file_result = 0;
		
		System.out.println(member);
		System.out.println(member.getM_password().length());
		
		if(member.getM_password().length() < 8) {
			member_result = ms.update(member);
		} else {
			String password = bpPass.encode(member.getM_password()); //비밀번호 암호화
			member.setM_password(password);
			member_result = ms.updateWithPass(member);
		}
		
		MultipartFile isFile = mhr.getFile("file");
		
		if(!isFile.isEmpty()) {
			AppointFile appointFile = new AppointFile();
			String origin = mhr.getFile("file").getOriginalFilename(); // 파일 전체이름
			String real = session.getServletContext().getRealPath("/resources/upload/appoint"); // 파일 경로
			FileOutputStream fos = new FileOutputStream(new File(real+"/"+origin));
			fos.write(mhr.getFile("file").getBytes());
			fos.close();
			
			int lastIndex = origin.lastIndexOf("."); // 파일명과 확장자 분리
			String fileName = origin.substring(0,lastIndex); // 파일명
			String type = origin.substring(lastIndex+1); // 확장자
			int size = (int)mhr.getFile("file").getSize(); // 사이즈
			
			appointFile.setAf_origin(origin);
			appointFile.setAf_name(fileName);
			appointFile.setAf_type(type);
			appointFile.setAf_size(size);
			appointFile.setM_id(member.getM_id());
			appointFile.setAf_url(real);
			file_result = ms.insertFile(appointFile);	
		} else {
			file_result = -1;
		}
		
		if(file_result > 0) {
			System.out.println("File Upload Success!");
		} else if(file_result == 0) {
			System.out.println("File Upload False");
		} else {
			System.out.println("File Null");
		}
		String m_id = member.getM_id();
		
		model.addAttribute("m_id",m_id);
		model.addAttribute("result",member_result);
		
		return "member/memberUpdate";
	}
	
	@RequestMapping("/member/branchMain")
	public String branchMain() {
		return "redirect:/member/branchMain/pageNum/1";
	}
	
	@RequestMapping("member/branchMain/pageNum/{pageNum}")
	public String branchMain(@PathVariable String pageNum, Branch branch, HttpSession session, Model model) {
		sideNav(session, model);
		
		if(pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int rowPerPage = 10;
		int startRow = (currentPage - 1)*rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;

		branch.setStartRow(startRow);
		branch.setEndRow(endRow);
		
		List<Branch> list = ms.branchJoinList(branch);
		int total = ms.getBranchTotal(branch);
		int num = startRow;
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		
		model.addAttribute("branch",branch);
		model.addAttribute("list",list);
		model.addAttribute("pb",pb);
		model.addAttribute("num",num);
		
		return"member/branchMain";
	}
	
	@RequestMapping("member/branchWriteForm")
	public String branchWriteForm(HttpSession session, Model model) {
		sideNav(session, model);
		
		return "member/branchWriteForm";
	}

	@RequestMapping("member/branchChk")
	@ResponseBody
	public int branchChk(String b_name) {
		int data = 0;
		Branch branch = ms.branchSelectName(b_name);
		
		if(branch == null) {
			data = 1;
		} else {
			data = -1;
		}
		
		return data;
	}
	
	@RequestMapping("member/branchWrite")
	public String branchWrite(Branch branch,Model model,HttpSession session) {
		int result = 0;
		Branch branch2 = ms.branchSelectName(branch.getB_name());
		
		if(branch2 == null) {
			result = ms.insertBranch(branch);	
		} else {
			result = -1;
		}
		
		model.addAttribute("result",result);
		return "member/branchWrite";
	}
	
	@RequestMapping("member/branchRead/b_seq/{b_seq}")
	public String branchRead(@PathVariable int b_seq, HttpSession session, Model model) {
		sideNav(session, model);
		
		Branch branch = ms.branchSelectSeq(b_seq);
		List<Team> teamList = ms.teamList(b_seq);
		int memberCount = ms.mCountByBranch(b_seq);
		int teamCount = ms.tCountByBranch(b_seq);
		int leaveCount = ms.leaveCount(b_seq);
		
		model.addAttribute("leaveCount",leaveCount);
		model.addAttribute("branch", branch);
		model.addAttribute("teamList", teamList);
		model.addAttribute("memberCount", memberCount);
		model.addAttribute("teamCount", teamCount);
		
		return "member/branchRead";
	}
	
	@RequestMapping("member/branchUpdateForm/b_seq/{b_seq}")
	public String branchUpdateForm(@PathVariable int b_seq, HttpSession session , Model model) {
		sideNav(session, model);
		Branch branch = ms.branchSelectSeq(b_seq);
		
		model.addAttribute("branch",branch);
		return "member/branchUpdateForm";
	}
	
	@RequestMapping("member/branchUpdate")
	public String branchUpdate(Branch branch, Model model) {
		
		int result = ms.branchUpdate(branch);
		int b_seq = branch.getB_seq();
		
		model.addAttribute("b_seq",b_seq);
		model.addAttribute("result",result);
		return "member/branchUpdate";
	}
	
	@RequestMapping("member/branchDelete/b_seq/{b_seq}")
	public String branchDelete(@PathVariable int b_seq, Model model) {
		
		int result = 0;
		int team_result = 0;
		
		int leaveCount = ms.leaveCount(b_seq);
		int memberCount = ms.mCountByBranch(b_seq);
		int teamCount = ms.tCountByBranch(b_seq);
		 
		if(memberCount != 0 || leaveCount != 0) {
			result = -1;
		} else if(teamCount != 0) {
			team_result = ms.teamDelbyBranch(b_seq);
			result = ms.branchDel(b_seq);
		} else {
			result = ms.branchDel(b_seq);
		}
		
		if(team_result > 0) {
			System.out.println(team_result+"team has been removed.");
		} else if(team_result == 0){
			System.out.println("Team Null");
		} else {
			System.out.println("ERROR");
		}
		
		model.addAttribute("result",result);
		return "member/branchDelete";
	}
	@RequestMapping("member/teamWriteForm/b_seq/{b_seq}")
	public String teamWriteForm(@PathVariable int b_seq,HttpSession session,Model model) {
		sideNav(session, model);
		
		return "member/teamWriteForm";
	}
	@RequestMapping("member/teamChk")
	@ResponseBody
	public int teamChk(Team team) {
		int data = 0;
		Team team2 = ms.teamChk(team);
		
		if(team2 == null) {
			data = 1;
		} else {
			data = -1;
		}
	
		return data;
	}
	@RequestMapping("member/teamWrite")
	public String teamWrite(Team team, Model model) {
		int result = 0;
		Team team2 = ms.teamChk(team);
		
		if(team2 == null) {
			result = ms.insertTeam(team);
		} else {
			result = -1;
		}
		
		model.addAttribute("b_seq",team.getB_seq());
		model.addAttribute("result",result);
		return "member/teamWrite";
	}
	
	@RequestMapping("member/teamRead/t_seq/{t_seq}")
	public String teamRead(@PathVariable int t_seq) {
		return "redirect:/member/teamRead/t_seq/"+t_seq+"/pageNum/1";
	}
	
	@RequestMapping("member/teamRead/t_seq/{t_seq}/pageNum/{pageNum}")
	public String teamRead(@PathVariable String pageNum, @PathVariable int t_seq, HttpSession session, Model model) {
		sideNav(session, model);
		
		if(pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		
		Member member = new Member();
		int currentPage = Integer.parseInt(pageNum);
		int rowPerPage = 10;
		int startRow = (currentPage - 1)*rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		
		member.setT_seq(t_seq);
		member.setStartRow(startRow);
		member.setEndRow(endRow);
		
		// 회원 정보 가져오기
		List<Member> list = ms.memberListByTseq(member);
		int total = ms.getTotalByTseq(member);
		int num = startRow;
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		
		// 팀 정보 가져오기
		Team team = ms.teamSelectByseq(t_seq);
		int mCount = ms.mCountByTeam(t_seq);
		int leaveCount = ms.leaveCountByTseq(t_seq);
		
		model.addAttribute("team",team);
		model.addAttribute("mCount",mCount);
		model.addAttribute("leaveCount",leaveCount);
		model.addAttribute("list",list);
		model.addAttribute("pb",pb);
		model.addAttribute("num",num);
		
		return "member/teamRead"; 
	}
	
	@RequestMapping("member/teamDelete/b_seq/{b_seq}/t_seq/{t_seq}")
	public String teamDelete(@PathVariable int t_seq, @PathVariable int b_seq, Model model) {
		
		int result = 0;
		int mCount = ms.mCountByTeam(t_seq);
		int leaveCount = ms.leaveCountByTseq(t_seq);
		
		if(mCount > 0 || leaveCount > 0) {
			result = -1;
		} else {
			result = ms.deleteTeam(t_seq);
		}
		
		model.addAttribute("b_seq",b_seq);
		model.addAttribute("result", result);
		return "member/teamDelete";
	}
	
	@RequestMapping("member/teamUpdateForm/t_seq/{t_seq}")
	public String teamUpdateForm(@PathVariable int t_seq, HttpSession session, Model model) {
		sideNav(session, model);
		
		Team team = ms.teamSelectByseq(t_seq);
		
		model.addAttribute("team",team);
		return "member/teamUpdateForm";
	}
	
	@RequestMapping("member/teamUpdate")
	public String teamUpdate(Team team, Model model) {
		System.out.println(team.getT_seq());
		int result = ms.updateTeam(team);
		
		model.addAttribute("team",team);
		model.addAttribute("result",result);
		return "member/teamUpdate";
	}
	
	@RequestMapping("member/reEntred/m_id/{m_id}")
	public String reEntred(@PathVariable String m_id, Model model) {
		int result = ms.reEntred(m_id);
		
		model.addAttribute("m_id", m_id);
		model.addAttribute("result",result);
		return "member/reEntred";
	}
}
