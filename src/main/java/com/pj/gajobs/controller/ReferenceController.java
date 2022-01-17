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
import com.pj.gajobs.model.Reference;
import com.pj.gajobs.model.ReferenceFile;
import com.pj.gajobs.model.ReferenceKind;
import com.pj.gajobs.model.Role;
import com.pj.gajobs.service.MemberService;
import com.pj.gajobs.service.PageBean;
import com.pj.gajobs.service.ReferenceSevice;

@Controller
public class ReferenceController {
	
	@Autowired
	private ReferenceSevice rs;
	@Autowired
	private MemberService ms;
	
//	sideNav 페이지 세션 유지용 메서드
	public void sideNav(HttpSession session, Model model) {
		String m_id = session.getAttribute("id").toString();
		Member member = ms.select(m_id);
		model.addAttribute("sideNav",member);
	}
	
	@RequestMapping("reference/referenceMain")
	public String referenceMain() {
		return "redirect:/reference/referenceMain/pageNum/1";
	}
	
	@RequestMapping("reference/referenceMain/pageNum/{pageNum}")
	public String referenceMain(@PathVariable String pageNum, Reference reference, HttpSession session, Model model) {
		sideNav(session, model);
		
		if(pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int rowPerPage = 5;
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage -1;
		
		reference.setStartRow(startRow);
		reference.setEndRow(endRow);
		
		List<Reference> list = rs.referenceList(reference);
		int total = rs.getTotal(reference);
		int num = startRow;
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		List<ReferenceKind> kindslist = rs.kindList();
		String[] titles = {"작성자","제목","내용","전체"};
		
		List<ReferenceFile> filesList = rs.fileList();
		
		model.addAttribute("kindslist", kindslist);
		model.addAttribute("filesList", filesList);
		model.addAttribute("titles",titles);
		model.addAttribute("list",list);
		model.addAttribute("pb",pb);
		model.addAttribute("num",num);
		
		return "reference/referenceMain";
	}
	@RequestMapping("reference/referenceWriteForm")
		public String referenceWriteForm() {
			return "redirect:/reference/referenceWriteForm/pageNum/1";
		}
	
	@RequestMapping("reference/referenceWriteForm/pageNum/{pageNum}")
	public String referenceWriteForm(@PathVariable String pageNum,HttpSession session, Model model) {
		sideNav(session, model);
		List<ReferenceKind> kindList = rs.kindList();
		model.addAttribute("kindList",kindList);
		return "reference/referenceWriteForm"; 
	}
	
	@RequestMapping("reference/referenceWrite/pageNum/{pageNum}")
	@ResponseBody
	public String referenceWrite(@PathVariable String pageNum, MultipartHttpServletRequest mhr, HttpSession session) throws IOException {
		
		/* 글 내용 저장 */
		Reference reference = new Reference();
		int num = rs.getMaxNum();
		
		String rf_writer = mhr.getParameter("rf_writer");
		String m_id = mhr.getParameter("m_id");
		String rf_title = mhr.getParameter("rf_title");
		String rf_content = mhr.getParameter("rf_content");
		int rfk_seq = Integer.parseInt(mhr.getParameter("rfk_seq")); 
		int rf_num = num+1;
		
		reference.setRf_num(rf_num);
		reference.setRf_writer(rf_writer);
		reference.setM_id(m_id);
		reference.setRf_title(rf_title);
		reference.setRf_content(rf_content);
		reference.setRfk_seq(rfk_seq);
		int insertResult = rs.insert(reference);
		
		/* 글 내용 저장이 성공할시 파일 업로드 */
		if(insertResult > 0) {
			String real = session.getServletContext().getRealPath("/resources/upload/reference");
			List<MultipartFile> filelist = mhr.getFiles("files");
			List<ReferenceFile> list = new ArrayList<ReferenceFile>();
			
			for(MultipartFile mf : filelist) {
				ReferenceFile referenceFile = new ReferenceFile();
				String rff_origin = mf.getOriginalFilename();
				int lastIndex = rff_origin.lastIndexOf(".");
				String rff_name = rff_origin.substring(0,lastIndex);
				String rff_type = rff_origin.substring(lastIndex+1);
				String rff_url = real;
				FileOutputStream fos = new FileOutputStream(new File(real+"/"+rff_origin));
				fos.write(mf.getBytes());
				fos.close();
				int rff_size = (int)mf.getSize();
				referenceFile.setRf_num(rf_num);
				referenceFile.setRff_origin(rff_origin);
				referenceFile.setRff_type(rff_type);
				referenceFile.setRff_size(rff_size);
				referenceFile.setRff_name(rff_name);
				referenceFile.setRff_url(rff_url);
				list.add(referenceFile);
			}
			rs.insertFile(list);
		}
		return "reference/referenceWrite";
	}
	
	@RequestMapping("reference/referenceFileDownload/rff_seq/{rff_seq}")
	@ResponseBody
	public String referenceFileDownload(@PathVariable int rff_seq,HttpServletResponse response,HttpServletRequest request) {
		ReferenceFile referenceFile = rs.selectFilebyseq(rff_seq);
		String rff_origin = referenceFile.getRff_origin();
		String path = referenceFile.getRff_url()+"/"+rff_origin;
		File downFile = new File(path);
		
		if(downFile.exists() && downFile.isFile()) {
			try {
				long fileSize = downFile.length();
				response.setContentType("application/x-msdownload");
				response.setContentLength((int)fileSize);
				
				String strClient = request.getHeader("user-agent");
				
				if(strClient.indexOf("MSIE 5.5")!=-1) {
					response.setHeader("Content-Disposition", "filename="+rff_origin+";");
					
				}else {
					rff_origin = URLEncoder.encode(rff_origin,"UTF-8").replaceAll("\\+","%20");
					response.setHeader("Content-Disposition", "attachment; filename=" + rff_origin + ";");
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
		return "reference/referenceFileDownload";
	}
	@RequestMapping("reference/referenceRead/pageNum/{pageNum}/rf_num/{rf_num}")
	public String referenceRead(@PathVariable String pageNum,@PathVariable int rf_num,HttpSession session,Model model) {
		sideNav(session, model);
		Reference reference = rs.select(rf_num);
		List<ReferenceFile> referenceFiles = rs.selectFilebyNum(rf_num);
		List<Role> roleList = ms.roleList();
		
		model.addAttribute("roleList",roleList);
		model.addAttribute("referenceFiles", referenceFiles);
		model.addAttribute("reference",reference);
		return "reference/referenceRead";
	}
	
	@RequestMapping("reference/referenceDelete/pageNum/{pageNum}/rf_num/{rf_num}")
	public String referenceDelete(@PathVariable String pageNum,@PathVariable int rf_num,Model model) {
		int result = 0;
		int fileDel = 0;
		int isFile = rs.fileByNumCount(rf_num);
		
		if(isFile > 0) {
			fileDel = rs.fileDelByNum(rf_num);
			result = rs.referenceDel(rf_num);
		} else {
			result = rs.referenceDel(rf_num);
		}
		
		if(fileDel == 0) {
			System.out.println("File Null");
		} else if(fileDel > 0) {
			System.out.println("Deleted "+fileDel+" files");
		} else {
			System.out.println("ERROR");
		}
		
		model.addAttribute("result",result);
		return "reference/referenceDelete";
	}
	
	@RequestMapping("reference/referenceUpdateForm/pageNum/{pageNum}/rf_num/{rf_num}")
	public String referenceUpdateForm(@PathVariable String pageNum, @PathVariable int rf_num, HttpSession session, Model model) {
		sideNav(session, model);
		List<ReferenceKind> kindList = rs.kindList();
		Reference reference = rs.select(rf_num);
		List<ReferenceFile> referenceFiles = rs.selectFilebyNum(rf_num);
		List<Role> roleList = ms.roleList();
		
		model.addAttribute("roleList",roleList);
		model.addAttribute("referenceFiles", referenceFiles);
		model.addAttribute("reference",reference);
		model.addAttribute("kindList",kindList);
		return "reference/referenceUpdateForm";
	}
	@RequestMapping("refernece/deleteFile")
	@ResponseBody
	public String deleteFile(int rff_seq) {
		rs.deleteBySeq(rff_seq);
		return "reference/deleteFile";
	}
	
	@RequestMapping("reference/referenceUpdate/pageNum/{pageNum}/rf_num/{rf_num}")
	@ResponseBody
	public String referenceUpdate(@PathVariable String pageNum, @PathVariable int rf_num,MultipartHttpServletRequest mhr, HttpSession session) throws IOException {
		Reference reference = new Reference();
		
		String rf_title = mhr.getParameter("rf_title");
		String rf_content = mhr.getParameter("rf_content");
		int rfk_seq = Integer.parseInt(mhr.getParameter("rfk_seq"));
		
		reference.setRfk_seq(rfk_seq);
		reference.setRf_num(rf_num);
		reference.setRf_title(rf_title);
		reference.setRf_content(rf_content);
		
		int updateResult = rs.update(reference);
		
		if(updateResult > 0) {
			String real = session.getServletContext().getRealPath("/resources/upload/reference");
			List<MultipartFile> filelist = mhr.getFiles("files");
			List<ReferenceFile> list = new ArrayList<ReferenceFile>();
			
			for(MultipartFile mf : filelist) {
				ReferenceFile referenceFile = new ReferenceFile();
				String rff_origin = mf.getOriginalFilename();
				int lastIndex = rff_origin.lastIndexOf(".");
				String rff_name = rff_origin.substring(0,lastIndex);
				String rff_type = rff_origin.substring(lastIndex+1);
				String rff_url = real;
				FileOutputStream fos = new FileOutputStream(new File(real+"/"+rff_origin));
				fos.write(mf.getBytes());
				fos.close();
				int rff_size = (int)mf.getSize();
				referenceFile.setRf_num(rf_num);
				referenceFile.setRff_origin(rff_origin);
				referenceFile.setRff_type(rff_type);
				referenceFile.setRff_size(rff_size);
				referenceFile.setRff_name(rff_name);
				referenceFile.setRff_url(rff_url);
				list.add(referenceFile);
			}
			rs.insertFile(list);
		}
		return "reference/referenceUpdate";
	}
}
