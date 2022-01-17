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

import com.pj.gajobs.model.Member;
import com.pj.gajobs.model.Notice;
import com.pj.gajobs.model.NoticeFile;
import com.pj.gajobs.model.NoticeRe;
import com.pj.gajobs.service.MemberService;
import com.pj.gajobs.service.NoticeService;
import com.pj.gajobs.service.PageBean;

@Controller
public class NoticeController {
	@Autowired
	private NoticeService ns;
	@Autowired
	private MemberService ms;
	
//	sideNav 페이지 세션 유지용 메서드
	public void sideNav(HttpSession session, Model model) {
		String m_id = session.getAttribute("id").toString();
		Member member = ms.select(m_id);
		model.addAttribute("sideNav",member);
	}
	
	@RequestMapping("/notice/noticeMain")
	public String noticeMain() {
		return "redirect:/notice/noticeMain/pageNum/1";
	}
	
	@RequestMapping("/notice/noticeMain/pageNum/{pageNum}")
	public String noticeMain(@PathVariable String pageNum, Notice notice , Model model, HttpSession session) {
		sideNav(session, model);
		
		if(pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int rowPerPage = 5;
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage -1;
		
		
		notice.setStartRow(startRow);
		notice.setEndRow(endRow);
		
		// 공지사항 글 가져오기
		List<Notice> list = ns.noticeList(notice);
		int total = ns.getTotal(notice);
		int num = startRow;
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		String[] titles = {"작성자","제목","내용","전체"};
		
		model.addAttribute("titles",titles);
		model.addAttribute("list",list);
		model.addAttribute("pb",pb);
		model.addAttribute("num",num);
		return "notice/noticeMain";
	}
	@RequestMapping("/notice/noticeWriteForm")
	public String noticeWriteForm() {
		return "redirect:/notice/noticeWriteForm/pageNum/1";
	}
	@RequestMapping("/notice/noticeWriteForm/pageNum/{pageNum}")
	public String noticeWriteForm(@PathVariable String pageNum, Model model, HttpSession session) {
		sideNav(session, model);
		return "notice/noticeWriteForm";
	}
	
	@RequestMapping("/notice/noticeWrite/pageNum/{pageNum}")
	@ResponseBody
	public String noticeWrite(@PathVariable String pageNum,MultipartHttpServletRequest mhr, HttpSession session) throws IOException {
		
		/* 글 내용 저장 */
		Notice notice = new Notice();
		int num = ns.getMaxNum();
		
		String n_writer = mhr.getParameter("n_writer");
		String m_id = mhr.getParameter("m_id");
		String n_title = mhr.getParameter("n_title");
		String n_content = mhr.getParameter("n_content");
		int n_num = num+1;
		
		notice.setN_num(n_num);
		notice.setN_writer(n_writer);
		notice.setM_id(m_id);
		notice.setN_title(n_title);
		notice.setN_content(n_content);
		int insertResult = ns.insert(notice);
		
		/* 글 내용 저장이 성공할시 파일 업로드 */
		if(insertResult > 0) {
			String real = session.getServletContext().getRealPath("/resources/upload/notice");
			List<MultipartFile> filelist = mhr.getFiles("files");
			List<NoticeFile> list = new ArrayList<NoticeFile>();
			
			for(MultipartFile mf : filelist) {
				NoticeFile noticefile = new NoticeFile();
				String nf_origin = mf.getOriginalFilename();
				int lastIndex = nf_origin.lastIndexOf(".");
				String nf_name = nf_origin.substring(0,lastIndex);
				String nf_type = nf_origin.substring(lastIndex+1);
				String nf_url = real;
				FileOutputStream fos = new FileOutputStream(new File(real+"/"+nf_origin));
				fos.write(mf.getBytes());
				fos.close();
				int nf_size = (int)mf.getSize();
				noticefile.setN_num(n_num);
				noticefile.setNf_origin(nf_origin);
				noticefile.setNf_type(nf_type);
				noticefile.setNf_size(nf_size);
				noticefile.setNf_name(nf_name);
				noticefile.setNf_url(nf_url);
				list.add(noticefile);
			}
			ns.insertFile(list);
		}
		return "notice/noticeWrite";
	}
	
	@RequestMapping("notice/noticeRead/pageNum/{pageNum}/n_num/{n_num}")
	public String noticeRead(@PathVariable String pageNum, @PathVariable int n_num, HttpSession session , Model model) {
		sideNav(session, model);
		ns.updateCount(n_num);
		
		Notice notice = ns.select(n_num);
		List<NoticeFile> noticeFile = ns.selectFile(n_num);
		Member member = ms.select(notice.getM_id());
		List<NoticeRe> noticeRe = ns.selectRe(n_num);
		
		model.addAttribute("noticeRe",noticeRe);
		model.addAttribute("member",member);
		model.addAttribute("notice", notice);
		model.addAttribute("noticeFile", noticeFile);
		return"notice/noticeRead";
	}
	@RequestMapping("notice/noticeFileDownload/nf_seq/{nf_seq}")
	@ResponseBody
	public String noticeFileDownload(@PathVariable int nf_seq,HttpServletResponse response,HttpServletRequest request) {
		NoticeFile noticeFile = ns.selectFilebyseq(nf_seq);
		String nf_origin = noticeFile.getNf_origin();
		String path = noticeFile.getNf_url()+"/"+nf_origin;
		File downFile = new File(path);
		
		if(downFile.exists() && downFile.isFile()) {
			try {
				long fileSize = downFile.length();
				response.setContentType("application/x-msdownload");
				response.setContentLength((int)fileSize);
				
				String strClient = request.getHeader("user-agent");
				
				if(strClient.indexOf("MSIE 5.5")!=-1) {
					response.setHeader("Content-Disposition", "filename="+nf_origin+";");
					
				}else {
					nf_origin = URLEncoder.encode(nf_origin,"UTF-8").replaceAll("\\+","%20");
					response.setHeader("Content-Disposition", "attachment; filename=" + nf_origin + ";");
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
		return "notice/noticeFileDownload";
	}
	
	@RequestMapping("notice/noticeDelete/pageNum/{pageNum}/n_num/{n_num}")
	public String noticeDelete(@PathVariable String pageNum, @PathVariable int n_num, Model model) {
		
		/*파일 존재 여부 확인*/		
		int fileCount = ns.countByNum(n_num);
		
		/*댓글 존재 여부 확인*/
		int noticeReCount = ns.reCountByNum(n_num);
		
		int result_noticeFile = 0;
		int result_notice = 0;
		int result_noticeRe = 0;
		
		if(fileCount > 0 && noticeReCount >0) {
			
			result_noticeFile = ns.deleteFile(n_num);
			result_noticeRe = ns.reDeleteByNum(n_num);
			
			if(result_noticeFile > 0 && result_noticeRe > 0) {
				result_notice = ns.delete(n_num);
			}
			
		} else if(fileCount > 0 && noticeReCount == 0) {
			
			result_noticeFile = ns.deleteFile(n_num);
			
			if(result_noticeFile > 0) {
				result_notice = ns.delete(n_num);
			}
			
		} else if(fileCount == 0 && noticeReCount > 0) {
			
			result_noticeRe = ns.reDeleteByNum(n_num);
			if(result_noticeRe > 0) {
				result_notice = ns.delete(n_num);
			}
		} else {
			result_notice = ns.delete(n_num);
		}
		
		model.addAttribute("result", result_notice);
		return "notice/noticeDelete";
	}
	@RequestMapping("notice/noticeUpdateForm/pageNum/{pageNum}/n_num/{n_num}")
	public String noticeUpdateForm(@PathVariable String pageNum, @PathVariable int n_num, HttpSession session, Model model) {
		sideNav(session, model);
		
		Notice notice = ns.select(n_num);
		List<NoticeFile> noticeFile = ns.selectFile(n_num);
		Member member = ms.select(notice.getM_id());
		
		model.addAttribute("notice",notice);
		model.addAttribute("noticeFile",noticeFile);
		model.addAttribute("member", member);
		return "notice/noticeUpdateForm"; 
	}
	
	@RequestMapping("notice/deleteFile")
	@ResponseBody
	public String deleteFile(int nf_seq) {
		ns.deleteBySeq(nf_seq);
		
		return "notice/deleteFile";
	}
	@RequestMapping("notice/noticeUpdate/pageNum/{pageNum}/n_num/{n_num}")
	@ResponseBody
	public String noticeUpdate(@PathVariable String pageNum, @PathVariable int n_num, MultipartHttpServletRequest mhr, HttpSession session ) throws IOException {
		
		Notice notice = new Notice();
		
		String n_title = mhr.getParameter("n_title");
		String n_content = mhr.getParameter("n_content");
		
		notice.setN_num(n_num);
		notice.setN_title(n_title);
		notice.setN_content(n_content);
		
		int updateResult = ns.update(notice);
		
		if(updateResult > 0) {
			String real = session.getServletContext().getRealPath("/resources/upload/notice");
			List<MultipartFile> filelist = mhr.getFiles("files");
			List<NoticeFile> list = new ArrayList<NoticeFile>();
			
			for(MultipartFile mf : filelist) {
				NoticeFile noticefile = new NoticeFile();
				String nf_origin = mf.getOriginalFilename();
				int lastIndex = nf_origin.lastIndexOf(".");
				String nf_name = nf_origin.substring(0,lastIndex);
				String nf_type = nf_origin.substring(lastIndex+1);
				String nf_url = real;
				FileOutputStream fos = new FileOutputStream(new File(real+"/"+nf_origin));
				fos.write(mf.getBytes());
				fos.close();
				int nf_size = (int)mf.getSize();
				noticefile.setN_num(n_num);
				noticefile.setNf_origin(nf_origin);
				noticefile.setNf_type(nf_type);
				noticefile.setNf_size(nf_size);
				noticefile.setNf_name(nf_name);
				noticefile.setNf_url(nf_url);
				list.add(noticefile);
			}
			ns.insertFile(list);
		}
		return "notice/noticeUpdate";
	}
	@RequestMapping("notice/noticeRe")
	@ResponseBody
	public String noticeRe(NoticeRe noticeRe) {
		ns.insertRe(noticeRe);
		return "notice/noticeRe";
	}
	@RequestMapping("notice/noticeReDelete")
	@ResponseBody
	public String noticeReDelete(int nr_seq) {
		ns.deleteRe(nr_seq);
		return "notice/noticeReDelete";
	}
	
}
