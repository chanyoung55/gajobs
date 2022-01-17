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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.pj.gajobs.model.Bond;
import com.pj.gajobs.model.BondFile;
import com.pj.gajobs.model.Member;
import com.pj.gajobs.service.BondService;
import com.pj.gajobs.service.MemberService;
import com.pj.gajobs.service.PageBean;

@Controller
public class BondController {
	@Autowired
	private BondService bs;
	@Autowired
	private MemberService ms;
	
//	sideNav 페이지 세션 유지용 메서드
	public void sideNav(HttpSession session, Model model) {
		String m_id = session.getAttribute("id").toString();
		Member member = ms.select(m_id);
		model.addAttribute("sideNav",member);
	}
	
	@RequestMapping("/bond/bondMain")
	public String bondMain() {
		return "redirect:/bond/bondMain/pageNum/1";
	}
	
	@RequestMapping("bond/bondMain/pageNum/{pageNum}")
	public String bondMain(@PathVariable String pageNum, HttpSession session, Bond bond ,Model model) {
		sideNav(session, model);
		
		if(pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		
		int currentPage = Integer.parseInt(pageNum);
		int rowPerPage = 5;
		int startRow = (currentPage - 1)*rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;

		bond.setStartRow(startRow);
		bond.setEndRow(endRow);
		
		List<Bond> bondList = bs.bondList(bond);
		int total = bs.getTotal(bond);
		int num = startRow;
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		String[] titles = {"사번","이름","채권 종류","지점명","전체"};
		
		
		model.addAttribute("titles",titles);
		model.addAttribute("bondList",bondList);
		model.addAttribute("pb",pb);
		model.addAttribute("num",num);
		return "bond/bondMain";
	}
	
	@RequestMapping("bond/bondWriteForm")
	public String bondWriteForm(HttpSession session, Model model) {
		sideNav(session, model);
		String[] titles = {"전체","사원번호","사원명","지점명","팀명"};
		
		model.addAttribute("titles",titles);
		return "bond/bondWriteForm";
	}
	
	@RequestMapping("bond/memberSrc")
	@ResponseBody
	public List<Member> memberSrc(Member member){
		List<Member> memberList = ms.bondMemberList(member);
		return memberList;
	}
	@RequestMapping("bond/getMember")
	@ResponseBody
	public List<Member> getMember(String m_id){
		List<Member> getmember = ms.selectByBond(m_id);
		return getmember;
	}
	@RequestMapping("bond/bondWrite")
	public String bondWrite(MultipartHttpServletRequest mhr, Bond bond, HttpSession session, Model model) throws IOException {
		sideNav(session, model);
		
		int getMaxNum = bs.getMaxNumByBond();
		int bo_num = getMaxNum + 1;
		bond.setBo_num(bo_num);
		
		int bondResult = 0;
		int fileResult = 0;
		MultipartFile isFile = mhr.getFile("file");
		
		if(isFile.isEmpty()) {
			bondResult = -1;
		} else {
			bondResult = bs.insertBond(bond);
			
			BondFile bondFile = new BondFile();
			String origin = mhr.getFile("file").getOriginalFilename();
			String path = session.getServletContext().getRealPath("/resources/upload/bond");
			FileOutputStream fos = new FileOutputStream(new File(path+"/"+origin));
			fos.write(mhr.getFile("file").getBytes());
			fos.close();
			
			int lastIndex = origin.lastIndexOf("."); // 파일명과 확장자 분리
			String fileName = origin.substring(0,lastIndex); // 파일명
			String type = origin.substring(lastIndex+1); // 확장자
			int size = (int)mhr.getFile("file").getSize(); // 사이즈
			
			bondFile.setBof_origin(origin);
			bondFile.setBof_name(fileName);
			bondFile.setBof_type(type);
			bondFile.setBof_size(size);
			bondFile.setBo_num(bo_num);
			bondFile.setBof_url(path);
			fileResult = bs.insertBondFile(bondFile);
		}
		
		if(fileResult > 0) {
			System.out.println("File Upload Success");
		} else {
			System.out.println("File Error");
		}
		
		model.addAttribute("result",bondResult);
		return "bond/bondWrite";
	}
	
	@RequestMapping("bond/bondRead/pageNum/{pageNum}/bo_num/{bo_num}")
	public String bondRead(@PathVariable String pageNum,@PathVariable int bo_num,HttpSession session, Model model) {
		sideNav(session, model);
		
		Bond bond = bs.selectBond(bo_num);
		String m_id = bond.getM_id();
		Member member = ms.select(m_id);
		BondFile bondFile = bs.fileSelectByNum(bo_num);
		
		model.addAttribute("bondFile",bondFile);
		model.addAttribute("bond",bond);
		model.addAttribute("member",member);
		return "bond/bondRead";
	}
	
	@RequestMapping("/bond/bondDelete/pageNum/{pageNum}/bo_num/{bo_num}")
	public String bondDelete(@PathVariable String pageNum, @PathVariable int bo_num, Model model) {
		int result = 0;
		int resultFile = 0;
		int fileCount = bs.fileCount(bo_num);
		
		if(fileCount > 0) {
			resultFile = bs.deleteBondFile(bo_num);
			if(resultFile > 0) {
				result = bs.deleteBond(bo_num);
			}
		} else {
			result = bs.deleteBond(bo_num);
		}
		
		model.addAttribute("result",result);
		return "bond/bondDelete";
	}
	
	@RequestMapping("bond/FileDownload/bof_seq/{bof_seq}")
	@ResponseBody
	public String FileDownload(@PathVariable int bof_seq,HttpServletResponse response,HttpServletRequest request) {
		BondFile bondFile = bs.selectFileByseq(bof_seq);
		String origin = bondFile.getBof_origin();
		String path = bondFile.getBof_url()+"/"+origin;
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
		
		return "bond/FileDownload";
	}
	
	@RequestMapping("bond/bondUpdateForm/pageNum/{pageNum}/bo_num/{bo_num}")
	public String bondUpdateForm(@PathVariable String pageNum, @PathVariable int bo_num, HttpSession session, Model model) {
		sideNav(session, model);
		Bond bond = bs.selectBond(bo_num);
		BondFile bondFile = bs.fileSelectByNum(bo_num);
		Member member = ms.select(bond.getM_id());
		
		model.addAttribute("bond",bond);
		model.addAttribute("bondFile",bondFile);
		model.addAttribute("member",member);
		return "bond/bondUpdateForm";
	}
	
	@RequestMapping("bond/bondUpdate/pageNum/{pageNum}")
	public String bondUpdate(@PathVariable String pageNum, MultipartHttpServletRequest mhr, int bof_seq, Bond bond,HttpSession session, Model model) throws IOException {
		int updateResult = 0;
		int updateFileResult = 0;
		MultipartFile isFile = mhr.getFile("file");
		
		if(isFile.isEmpty()) {
			updateResult = bs.updateBond(bond);
		} else {
			updateResult = bs.updateBond(bond);
			
			BondFile bondFile = new BondFile();
			String origin = mhr.getFile("file").getOriginalFilename();
			String path = session.getServletContext().getRealPath("/resources/upload/bond");
			FileOutputStream fos = new FileOutputStream(new File(path+"/"+origin));
			fos.write(mhr.getFile("file").getBytes());
			fos.close();
			
			int lastIndex = origin.lastIndexOf("."); // 파일명과 확장자 분리
			String fileName = origin.substring(0,lastIndex); // 파일명
			String type = origin.substring(lastIndex+1); // 확장자
			int size = (int)mhr.getFile("file").getSize(); // 사이즈
			
			bondFile.setBof_seq(bof_seq);
			bondFile.setBof_origin(origin);
			bondFile.setBof_name(fileName);
			bondFile.setBof_type(type);
			bondFile.setBof_size(size);
			bondFile.setBof_url(path);
			updateFileResult = bs.updateBondFile(bondFile);
		}
		
		if(updateFileResult > 0) {
			System.out.println("File Update Success");
		} else if(updateFileResult == 0) {
			System.out.println("File Null");
		}
		
		model.addAttribute("bo_num",bond.getBo_num());
		model.addAttribute("result",updateResult);
		return "bond/bondUpdate";
	}
}
