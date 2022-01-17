package com.pj.gajobs.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.pj.gajobs.model.Company;
import com.pj.gajobs.model.Email;
import com.pj.gajobs.model.Help;
import com.pj.gajobs.model.HelpFile;
import com.pj.gajobs.model.Member;
import com.pj.gajobs.model.Role;
import com.pj.gajobs.service.HelpService;
import com.pj.gajobs.service.MemberService;
import com.pj.gajobs.service.PageBean;

@Controller
public class HelpController {
	@Autowired
	private MemberService ms;
	@Autowired
	private HelpService hs;
	@Autowired
	private JavaMailSender mailSender;
	
//	sideNav 페이지 세션 유지용 메서드
	public void sideNav(HttpSession session, Model model) {
		String m_id = session.getAttribute("id").toString();
		Member member = ms.select(m_id);
		model.addAttribute("sideNav",member);
	}
	
	@RequestMapping("help/helpSend")
	public String helpSend(HttpSession session, Model model) {
		sideNav(session, model);
		return "help/helpSend";
	}
	
	@RequestMapping("help/helpWrite")
	@ResponseBody
	public int helpWrite(Help help, HttpSession session, MultipartHttpServletRequest mhr, Model model) throws IOException {
		
		int getMaxNum = hs.getMaxNum();
		int h_num = getMaxNum + 1;
		help.setH_num(h_num);
		
		int result = hs.sendHelp(help);
		
		MultipartFile isFile = mhr.getFile("files");
		
		if(!isFile.isEmpty()) {
			String path = session.getServletContext().getRealPath("/resources/upload/help");
			List<MultipartFile> fileList = mhr.getFiles("files");
			List<HelpFile> helpFileList = new ArrayList<HelpFile>();
			
			for(MultipartFile mf : fileList) {
				HelpFile hf = new HelpFile();
				String origin = mf.getOriginalFilename();
				int lastIndex = origin.lastIndexOf(".");
				String fileName = origin.substring(0,lastIndex);
				String fileType = origin.substring(lastIndex+1);
				FileOutputStream fos =  new FileOutputStream(new File(path+"/"+origin));
				fos.write(mf.getBytes());
				fos.close();
				System.out.println(origin);
				int size = (int)mf.getSize();
				hf.setH_num(h_num);
				hf.setHf_name(fileName);
				hf.setHf_type(fileType);
				hf.setHf_origin(origin);
				hf.setHf_size(size);
				hf.setHf_url(path);
				helpFileList.add(hf);
			}
			hs.sendFile(helpFileList);
		}
		
		return result;
	}
	@RequestMapping("admin/adminMain")
	public String adminMain() {
		return "redirect:/admin/adminMain/pageNum/1";
	}
	@RequestMapping("admin/adminMain/pageNum/{pageNum}")
	public String adminMain(@PathVariable String pageNum,Help help,HttpSession session, Model model) {
		sideNav(session, model);
		
		if(pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int rowPerPage = 5;
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage -1;
		int num = startRow;
		
		help.setStartRow(startRow);
		help.setEndRow(endRow);
		
		List<Help> helpList = hs.readHelp(help);
		List<Role> roleList = ms.roleList();
		
		int total = hs.getTotal(help);
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		String[] titles = {"전체","제목","내용","발신인"};
		
		model.addAttribute("roleList",roleList);
		model.addAttribute("titles",titles);
		model.addAttribute("pb",pb);
		model.addAttribute("helpList",helpList);
		model.addAttribute("num",num);
		return "admin/adminMain";
	}
	
	@RequestMapping("admin/helpRead/pageNum/{pageNum}/h_num/{h_num}")
	public String helpRead(@PathVariable String pageNum, @PathVariable int h_num, HttpSession session, Model model) {
		sideNav(session, model);
		Help help = hs.readHelpByNum(h_num);
		List<HelpFile> fileList = hs.fileListByNum(h_num);
		
		model.addAttribute("help",help);
		model.addAttribute("fileList",fileList);
		return "admin/helpRead";
	}
	@RequestMapping("admin/fileDwonload/hf_seq/{hf_seq}")
	@ResponseBody
	public String fileDwonload(@PathVariable int hf_seq,HttpServletResponse response,HttpServletRequest request) {
		HelpFile helpFile = hs.selectfileByseq(hf_seq);
		String origin = helpFile.getHf_origin();
		String path = helpFile.getHf_url()+"/"+origin;
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
		return "admin/fileDwonload";
	}
	@RequestMapping("admin/helpDelete/pageNum/{pageNum}/h_num/{h_num}")
	public String helpDelete(@PathVariable String pageNum, @PathVariable int h_num, Model model) {
		
		int fileResult = 0;
		int result = 0;
		int fileCount = hs.fileCountByNum(h_num);
		
		if(fileCount > 0) {
			fileResult = hs.deleteFileByNum(h_num);
			result = hs.deleteHelpByNum(h_num);
		} else {
			result = hs.deleteHelpByNum(h_num);
		}
		
		if(fileResult > 0) {
			System.out.println("File Delete Success");
		} else if(fileResult == 0) {
			System.out.println("File Null");
		} else {
			System.out.println("File Delete Error");
		}
		
		model.addAttribute("result", result);
		return "admin/helpDelete";
	}
	@RequestMapping("admin/readChk")
	@ResponseBody
	public int readChk(int h_num, String readchk) {
		int data = 0;
		if(readchk.equals("y")) {
			data = hs.read(h_num);
		} else if(readchk.equals("n")){
			data = hs.notRead(h_num);
		}
		return data;
	}
	@RequestMapping("admin/emailSendForm/pageNum/{pageNum}/h_num/{h_num}")
	public String emailSend(@PathVariable String pageNum, @PathVariable int h_num, HttpSession session, Model model) {
		sideNav(session, model);
		Help help = hs.readHelpByNum(h_num);
		
		model.addAttribute("help", help);
		return "admin/emailSendForm";
	}
	
	@RequestMapping("admin/emailSend/pageNum/{pageNum}")
	public String email(@PathVariable String pageNum,HttpServletRequest request, Email email,Model model) {
		
		int getMaxNum = hs.getEmailMaxNum();
		int em_num = getMaxNum+1;
		email.setEm_num(em_num);
		
		int emailResult = hs.insertEmail(email);
		int result = 0;
		
		if(emailResult > 0) {
			try {
				MimeMessage mimeMessage = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage,true,"UTF-8");
				messageHelper.setFrom(email.getEm_smail());
				messageHelper.setTo(email.getEm_rmail());
				messageHelper.setSubject(email.getEm_title());
				messageHelper.setText(email.getEm_content(),true);
				mailSender.send(mimeMessage);
				result = 1;
			}catch (Exception e) {
				e.printStackTrace();
			}	
		}
		
		model.addAttribute("result", result);
		return "admin/emailSend";
	}
	
	@RequestMapping("admin/mailSendMain")
	public String mailSendMain() {
		return "redirect:/admin/mailSendMain/pageNum/1";
	}
	
	@RequestMapping("admin/mailSendMain/pageNum/{pageNum}")
	public String mailSendMain(@PathVariable String pageNum,Email email, HttpSession session,Model model) {
		sideNav(session, model);
		if(pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		
		int currentPage = Integer.parseInt(pageNum);
		int rowPerPage = 5;
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage -1;
		
		email.setStartRow(startRow);
		email.setEndRow(endRow);
		
		List<Email> emailList = hs.emailList(email);
		int total = hs.getEmailTotal(email);
		int num = startRow;
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		String[] titles = {"전체","제목","내용","이메일","아이디","수신자"};
		
		model.addAttribute("titles",titles);
		model.addAttribute("emailList",emailList);
		model.addAttribute("pb",pb);
		model.addAttribute("num",num);
		
		return "admin/mailSendMain";
	}
	
	@RequestMapping("admin/emailRead/pageNum/{pageNum}/em_num/{em_num}")
	public String emailRead(@PathVariable String pageNum,@PathVariable int em_num,HttpSession session, Model model) {
		sideNav(session, model);
		Email email = hs.selectEmailByNum(em_num);
		
		model.addAttribute("email",email);
		return "admin/emailRead";
	}
	
	@RequestMapping("admin/companyMain")
	public String companyMain() {
		return "redirect:/admin/companyMain/pageNum/1";
	}
	
	@RequestMapping("admin/companyMain/pageNum/{pageNum}")
	public String comapanyMain(@PathVariable String pageNum,Company company,HttpSession session,Model model) {
		if(pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		
		int currentPage = Integer.parseInt(pageNum);
		int rowPerPage = 10;
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage -1;
		
		company.setStartRow(startRow);
		company.setEndRow(endRow);
		
		sideNav(session, model);
		List<Company> comList = hs.comList(company);
		int total = hs.getComTotal(company);
		int num = startRow;
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		String[] titles = {"전체","회사명","종류","활성화여부"};
		
		model.addAttribute("titles",titles);
		model.addAttribute("comList",comList);
		model.addAttribute("pb",pb);
		model.addAttribute("num",num);
		
		return "admin/companyMain";
	}
	
	@RequestMapping("admin/companyRead/pageNum/{pageNum}/cp_seq/{cp_seq}")
	public String companyRead(@PathVariable String pageNum, @PathVariable int cp_seq, HttpSession session, Model model) {
		sideNav(session, model);
		Company company = hs.selectComBySeq(cp_seq);
		model.addAttribute("company",company);
		return "admin/companyRead";
	}
	
	@RequestMapping("admin/companyUpdateForm/pageNum/{pageNum}/cp_seq/{cp_seq}")
	public String companyUpdateForm(@PathVariable String pageNum, @PathVariable int cp_seq, HttpSession session, Model model) {
		sideNav(session, model);
		Company company = hs.selectComBySeq(cp_seq);
		
		model.addAttribute("company",company);
		return "admin/companyUpdateForm";
	}
	
	@RequestMapping("admin/companyUpdate/pageNum/{pageNum}")
	public String companyUpdate(@PathVariable String pageNum,Company company,Model model) {
		int result = hs.updateCom(company);
		int cp_seq = company.getCp_seq();
		model.addAttribute("cp_seq",cp_seq);
		model.addAttribute("result",result);
		return "admin/companyUpdate";
	}
	
	@RequestMapping("admin/companyDelete/pageNum/{pageNum}/cp_seq/{cp_seq}")
	public String companyDelete(@PathVariable String pageNum, @PathVariable int cp_seq, Model model) {
		int result = hs.deleteCom(cp_seq);
		
		model.addAttribute("result",result);
		return "admin/companyDelete";
	}
	
	@RequestMapping("admin/companyActive/pageNum/{pageNum}/cp_seq/{cp_seq}")
	public String companyactive(@PathVariable String pageNum, @PathVariable int cp_seq, Model model) {
		int result = hs.activeCom(cp_seq);
		
		model.addAttribute("result",result);
		return "admin/companyActive";
	}
	
	@RequestMapping("admin/emailDelete/pageNum/{pageNum}/em_num/{em_num}")
	public String emailDelete(@PathVariable String pageNum,@PathVariable int em_num,Model model) {
		int result = hs.emailDelete(em_num);
		
		model.addAttribute("result", result);
		return "admin/emailDelete";
	}
}
