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

import com.pj.gajobs.model.Education;
import com.pj.gajobs.model.EducationFile;
import com.pj.gajobs.model.EducationRe;
import com.pj.gajobs.model.Member;
import com.pj.gajobs.service.EducationService;
import com.pj.gajobs.service.MemberService;
import com.pj.gajobs.service.PageBean;

@Controller
public class EducationController {
	@Autowired
	private EducationService es;
	@Autowired
	private MemberService ms;
	
//	sideNav 페이지 세션 유지용 메서드
	public void sideNav(HttpSession session, Model model) {
		String m_id = session.getAttribute("id").toString();
		Member member = ms.select(m_id);
		model.addAttribute("sideNav",member);
	}
	
	@RequestMapping("/education/educationMain")
	public String educationMain() {
		return "redirect:/education/educationMain/pageNum/1";
	}
	
	@RequestMapping("/education/educationMain/pageNum/{pageNum}")
	public String noticeMain(@PathVariable String pageNum, Education education , Model model, HttpSession session) {
		sideNav(session, model);
		
		if(pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int rowPerPage = 5;
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage -1;
		
		
		education.setStartRow(startRow);
		education.setEndRow(endRow);
		
		// 공지사항 글 가져오기
		List<Education> list = es.eduList(education);
		int total = es.getTotal(education);
		int num = startRow;
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		String[] titles = {"작성자","제목","내용","전체"};
		
		model.addAttribute("titles",titles);
		model.addAttribute("list",list);
		model.addAttribute("pb",pb);
		model.addAttribute("num",num);
		return "education/educationMain";
	}
	
	@RequestMapping("/education/educationWriteForm")
	public String educationWriteForm() {
		return "redirect:/education/educationWriteForm/pageNum/1";
	}
	
	@RequestMapping("/education/educationWriteForm/pageNum/{pageNum}")
	public String educationWriteForm(@PathVariable String pageNum, Model model, HttpSession session) {
		sideNav(session, model);
		return "education/educationWriteForm";
	}
	
	@RequestMapping("/education/educationWrite/pageNum/{pageNum}")
	@ResponseBody
	public String noticeWrite(@PathVariable String pageNum, MultipartHttpServletRequest mhr, HttpSession session) throws IOException {
		
		/* 글 내용 저장 */
		Education education = new Education();
		int num = es.getMaxNum();
		
		String e_writer = mhr.getParameter("e_writer");
		String m_id = mhr.getParameter("m_id");
		String e_title = mhr.getParameter("e_title");
		String e_content = mhr.getParameter("e_content");
		int e_num = num+1;
		
		education.setE_num(e_num);
		education.setE_writer(e_writer);
		education.setM_id(m_id);
		education.setE_title(e_title);
		education.setE_content(e_content);
		int insertResult = es.insert(education);
		
		/* 글 내용 저장이 성공할시 파일 업로드 */
		if(insertResult > 0) {
			String real = session.getServletContext().getRealPath("/resources/upload/education");
			List<MultipartFile> filelist = mhr.getFiles("files");
			List<EducationFile> list = new ArrayList<EducationFile>();
			
			for(MultipartFile mf : filelist) {
				EducationFile educationFile = new EducationFile();
				String ef_origin = mf.getOriginalFilename();
				int lastIndex = ef_origin.lastIndexOf(".");
				String ef_name = ef_origin.substring(0,lastIndex);
				String ef_type = ef_origin.substring(lastIndex+1);
				String ef_url = real;
				FileOutputStream fos = new FileOutputStream(new File(real+"/"+ef_origin));
				fos.write(mf.getBytes());
				fos.close();
				int ef_size = (int)mf.getSize();
				educationFile.setE_num(e_num);
				educationFile.setEf_origin(ef_origin);
				educationFile.setEf_type(ef_type);
				educationFile.setEf_size(ef_size);
				educationFile.setEf_name(ef_name);
				educationFile.setEf_url(ef_url);
				list.add(educationFile);
			}
			es.insertFile(list);
		}
		return "education/educationWrite";
	}
	
	@RequestMapping("education/educationRead/pageNum/{pageNum}/e_num/{e_num}")
	public String educationRead(@PathVariable String pageNum, @PathVariable int e_num, HttpSession session , Model model) {
		sideNav(session, model);
		es.updateCount(e_num);
		
		Education education = es.select(e_num);
		List<EducationFile> educationFile = es.selectFile(e_num);
		Member member = ms.select(education.getM_id());
		List<EducationRe> educationRe = es.selectRe(e_num);
		
		model.addAttribute("educationRe",educationRe);
		model.addAttribute("member",member);
		model.addAttribute("education", education);
		model.addAttribute("educationFile", educationFile);
		
		return"education/educationRead";
	}
	
	@RequestMapping("education/educationFileDownload/ef_seq/{ef_seq}")
	@ResponseBody
	public String educationFileDownload(@PathVariable int ef_seq,HttpServletResponse response,HttpServletRequest request) {
		EducationFile educationFile = es.selectFilebyseq(ef_seq);
		String ef_origin = educationFile.getEf_origin();
		String path = educationFile.getEf_url()+"/"+ef_origin;
		File downFile = new File(path);
		
		if(downFile.exists() && downFile.isFile()) {
			try {
				long fileSize = downFile.length();
				response.setContentType("application/x-msdownload");
				response.setContentLength((int)fileSize);
				
				String strClient = request.getHeader("user-agent");
				
				if(strClient.indexOf("MSIE 5.5")!=-1) {
					response.setHeader("Content-Disposition", "filename="+ef_origin+";");
					
				}else {
					ef_origin = URLEncoder.encode(ef_origin,"UTF-8").replaceAll("\\+","%20");
					response.setHeader("Content-Disposition", "attachment; filename=" + ef_origin + ";");
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
		return "education/educationFileDownload";
	}
	
	@RequestMapping("education/educationDelete/pageNum/{pageNum}/e_num/{e_num}")
	public String noticeDelete(@PathVariable String pageNum, @PathVariable int e_num, Model model) {
		
		/*파일 존재 여부 확인*/		
		int fileCount = es.countByNum(e_num);
		
		/*댓글 존재 여부 확인*/
		int ReCount = es.reCountByNum(e_num);
		
		int resultFile = 0;
		int result = 0;
		int resultRe = 0;
		
		if(fileCount > 0 && ReCount >0) {
			
			resultFile = es.deleteFile(e_num);
			resultRe = es.reDeleteByNum(e_num);
			
			if(resultFile > 0 && resultRe > 0) {
				result = es.delete(e_num);
			}
			
		} else if(fileCount > 0 && ReCount == 0) {
			
			resultFile = es.deleteFile(e_num);
			
			if(resultFile > 0) {
				result = es.delete(e_num);
			}
			
		} else if(fileCount == 0 && ReCount > 0) {
			
			resultRe = es.reDeleteByNum(e_num);
			if(resultRe > 0) {
				result = es.delete(e_num);
			}
		} else {
			result = es.delete(e_num);
		}
		
		model.addAttribute("result", result);
		return "education/educationDelete";
	}
	
	@RequestMapping("education/educationRe")
	@ResponseBody
	public String educationRe(EducationRe educationRe) {
		System.out.println(educationRe);
		es.insertRe(educationRe);
		return "education/educationRe";
	}
	@RequestMapping("education/educationReDelete")
	@ResponseBody
	public String educationReDelete(int er_seq) {
		es.deleteRe(er_seq);
		return "education/educationReDelete";
	}
	
	@RequestMapping("education/educationUpdateForm/pageNum/{pageNum}/e_num/{e_num}")
	public String educationUpdateForm(@PathVariable String pageNum, @PathVariable int e_num, HttpSession session, Model model) {
		sideNav(session, model);
		
		Education education = es.select(e_num);
		List<EducationFile> educationFile = es.selectFile(e_num);
		Member member = ms.select(education.getM_id());
		
		model.addAttribute("education",education);
		model.addAttribute("educationFile",educationFile);
		model.addAttribute("member", member);
		return "education/educationUpdateForm";
	}
	
	@RequestMapping("education/deleteFile")
	@ResponseBody
	public String deleteFile(int ef_seq) {
		es.deleteBySeq(ef_seq);
		return "education/deleteFile";
	}
	
	@RequestMapping("education/educationUpdate/pageNum/{pageNum}/e_num/{e_num}")
	@ResponseBody
	public String noticeUpdate(@PathVariable String pageNum, @PathVariable int e_num, MultipartHttpServletRequest mhr, HttpSession session ) throws IOException {
		
		Education education = new Education();
		
		String e_title = mhr.getParameter("e_title");
		String e_content = mhr.getParameter("e_content");
		
		education.setE_num(e_num);
		education.setE_title(e_title);
		education.setE_content(e_content);
		
		int updateResult = es.update(education);
		
		if(updateResult > 0) {
			String real = session.getServletContext().getRealPath("/resources/upload/education");
			List<MultipartFile> filelist = mhr.getFiles("files");
			List<EducationFile> list = new ArrayList<EducationFile>();
			
			for(MultipartFile mf : filelist) {
				EducationFile educationFile = new EducationFile();
				String ef_origin = mf.getOriginalFilename();
				int lastIndex = ef_origin.lastIndexOf(".");
				String ef_name = ef_origin.substring(0,lastIndex);
				String ef_type = ef_origin.substring(lastIndex+1);
				String ef_url = real;
				FileOutputStream fos = new FileOutputStream(new File(real+"/"+ef_origin));
				fos.write(mf.getBytes());
				fos.close();
				int ef_size = (int)mf.getSize();
				educationFile.setE_num(e_num);
				educationFile.setEf_origin(ef_origin);
				educationFile.setEf_type(ef_type);
				educationFile.setEf_size(ef_size);
				educationFile.setEf_name(ef_name);
				educationFile.setEf_url(ef_url);
				list.add(educationFile);
			}
			es.insertFile(list);
		}
		return "education/educationUpdate";
	}
}
