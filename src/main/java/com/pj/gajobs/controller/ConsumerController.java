package com.pj.gajobs.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.DecimalFormat;
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

import com.pj.gajobs.model.Company;
import com.pj.gajobs.model.Consumer;
import com.pj.gajobs.model.ConsumerCon;
import com.pj.gajobs.model.ConsumerFile;
import com.pj.gajobs.model.ListConsumerCon;
import com.pj.gajobs.model.Member;
import com.pj.gajobs.service.ConsumerService;
import com.pj.gajobs.service.MemberService;
import com.pj.gajobs.service.PageBean;

@Controller
public class ConsumerController {
	@Autowired
	private MemberService ms;
	@Autowired
	private ConsumerService cs;

//	sideNav 페이지 세션 유지용 메서드
	public void sideNav(HttpSession session, Model model) {
		String m_id = session.getAttribute("id").toString();
		Member member = ms.select(m_id);
		model.addAttribute("sideNav", member);
	}

	@RequestMapping("/consumer/consumerMain")
	public String consumerMain() {
		return "redirect:/consumer/consumerMain/pageNum/1";
	}

	@RequestMapping("consumer/consumerMain/pageNum/{pageNum}")
	public String consumerMain(@PathVariable String pageNum, Consumer consumer, HttpSession session, Model model) {
		sideNav(session, model);
		String m_id = session.getAttribute("id").toString();
		consumer.setM_id(m_id);

		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int rowPerPage = 5;
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;

		consumer.setStartRow(startRow);
		consumer.setEndRow(endRow);

		List<Consumer> list = cs.consumerList(consumer);
		int total = cs.getTotal(consumer);
		int num = startRow;
		PageBean pb = new PageBean(currentPage, rowPerPage, total);

		String[] titles = { "전체", "고객명", "관계", "간단메모" };

		model.addAttribute("consumer", consumer);
		model.addAttribute("titles", titles);
		model.addAttribute("list", list);
		model.addAttribute("pb", pb);
		model.addAttribute("num", num);

		return "consumer/consumerMain";
	}

	@RequestMapping("consumer/consumerWriteForm/pageNum/{pageNum}")
	public String consumerWriteForm(@PathVariable String pageNum, HttpSession session, Model model) {
		sideNav(session, model);

		return "consumer/consumerWriteForm";
	}

	@RequestMapping("consumer/consumerWrite")
	public String consumerWrite(MultipartHttpServletRequest mhr, Consumer consumer, HttpSession session, Model model)
			throws IOException {
		int result = 0;
		int fileResult = 0;
		MultipartFile isFile = mhr.getFile("file");
		int maxNum = cs.getMaxNum();
		int c_num = maxNum + 1;
		consumer.setC_num(c_num);

		if (isFile.isEmpty()) {
			consumer.setC_agree("n");
			System.out.println(consumer);
			result = cs.insertConsumer(consumer);
		} else {
			consumer.setC_agree("y");
			result = cs.insertConsumer(consumer);
			ConsumerFile consumerFile = new ConsumerFile();
			String origin = mhr.getFile("file").getOriginalFilename();
			String path = session.getServletContext().getRealPath("/resources/upload/consumer");
			FileOutputStream fos = new FileOutputStream(new File(path + "/" + origin));
			fos.write(mhr.getFile("file").getBytes());
			fos.close();

			int lastIndex = origin.lastIndexOf(".");
			String fileName = origin.substring(0, lastIndex);
			String type = origin.substring(lastIndex + 1);
			int size = (int) mhr.getFile("file").getSize();

			consumerFile.setC_num(c_num);
			consumerFile.setCf_origin(origin);
			consumerFile.setCf_size(size);
			consumerFile.setCf_name(fileName);
			consumerFile.setCf_url(path);
			consumerFile.setCf_type(type);
			fileResult = cs.insertFile(consumerFile);
		}

		if (fileResult > 0) {
			System.out.println("File Upload Success");
		} else if (fileResult == 0) {
			System.out.println("File Null");
		} else {
			System.out.println("File Upload Error");
		}

		model.addAttribute("result", result);
		return "consumer/consumerWrite";
	}
	
	@RequestMapping("consumer/consumerRead/pageNum/{pageNum}/c_num/{c_num}")
	public String consumerRead(@PathVariable String pageNum, @PathVariable int c_num, HttpSession session,
			Model model) {
		sideNav(session, model);

		Consumer consumer = cs.selectConsumer(c_num);
		int isFile = cs.fileCount(c_num);
		List<ConsumerFile> consumerFile = cs.fileSelectByNum(c_num);
		
		model.addAttribute("fileList",consumerFile);
		model.addAttribute("isFile", isFile);
		model.addAttribute("consumer", consumer);

		return "consumer/consumerRead";
	}
	
	@RequestMapping("consumer/fileDownload/cf_seq/{cf_seq}")
	@ResponseBody
	public String fileDownload(@PathVariable int cf_seq,HttpServletResponse response,HttpServletRequest request) {
		ConsumerFile consumerFile = cs.selectFileByseq(cf_seq);
		String origin = consumerFile.getCf_origin();
		String path = consumerFile.getCf_url()+"/"+origin;
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
		return "consumer/fileDownload";
	}

	@RequestMapping("consumer/contractRead/c_num/{c_num}")
	public String contractRead(@PathVariable int c_num) {
		return "redirect:/consumer/contractRead/pageNum/1/c_num/" + c_num;
	}

	@RequestMapping("consumer/contractRead/pageNum/{pageNum}/c_num/{c_num}")
	public String contractRead(@PathVariable String pageNum, @PathVariable int c_num, HttpSession session,
			Model model) {
		sideNav(session, model);

		ConsumerCon consumerCon = new ConsumerCon();

		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}

		int currentPage = Integer.parseInt(pageNum);
		int rowPerPage = 10;
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;

		consumerCon.setStartRow(startRow);
		consumerCon.setEndRow(endRow);
		consumerCon.setC_num(c_num);

		List<ConsumerCon> conList = cs.conList(consumerCon);
		int totalpay = 0;
		DecimalFormat dc = new DecimalFormat("###,###,###,###");
		for (int i = 0; i < conList.size(); i++) {

			int pay = Integer.parseInt(conList.get(i).getCc_pay());
			totalpay = totalpay + pay;
			String payfomat = dc.format(pay);
			conList.get(i).setCc_pay(payfomat);
		}
		String totalpayFomat = dc.format(totalpay);
		int total = cs.getTotalCon(consumerCon);
		int num = startRow;
		PageBean pb = new PageBean(currentPage, rowPerPage, total);

		model.addAttribute("consumerCon", consumerCon);
		model.addAttribute("pb", pb);
		model.addAttribute("num", num);
		model.addAttribute("totalpay", totalpayFomat);
		model.addAttribute("conList", conList);
		return "consumer/contractRead";
	}

	@RequestMapping("consumer/contractWriteForm/c_num/{c_num}")
	public String contractWriteForm(@PathVariable int c_num, HttpSession session, Model model) {
		sideNav(session, model);
		List<Company> comList = cs.comList();

		model.addAttribute("comList", comList);
		return "consumer/contractWriteForm";
	}

	@RequestMapping("consumer/contractWrite/c_num/{c_num}")
	public String contractWriteForm(@PathVariable int c_num, ListConsumerCon conList, Model model) {

		for (int i = 0; i < conList.getConsumerConlist().size(); i++) {
			String rep = conList.getConsumerConlist().get(i).getCc_pay().replaceAll(",", "");
			conList.getConsumerConlist().get(i).setCc_pay(rep);
		}

		cs.insertContract(conList.getConsumerConlist());

		int result = 1;
		System.out.println(result);
		model.addAttribute("result", result);
		return "consumer/contractWrite";
	}

	@RequestMapping("consumer/contractDelete/pageNum/{pageNum}/cc_seq/{cc_seq}")
	public String contractDelete(@PathVariable String pageNum, @PathVariable int cc_seq, Model model) {

		int c_num = cs.selectContract(cc_seq);
		int result = cs.contractDel(cc_seq);

		model.addAttribute("c_num", c_num);
		model.addAttribute("result", result);
		return "consumer/contractDelete";
	}

	@RequestMapping("consumer/contractUpdateForm/pageNum/{pageNum}/cc_seq/{cc_seq}")
	public String contractUpdateForm(@PathVariable String pageNum, @PathVariable int cc_seq, HttpSession session,
			Model model) {
		sideNav(session, model);
		ConsumerCon consumerCon = cs.selectContractAll(cc_seq);
		List<Company> comList = cs.comList();

		model.addAttribute("contract", consumerCon);
		model.addAttribute("comList", comList);
		return "consumer/contractUpdateForm";
	}

	@RequestMapping("consumer/contractUpdate/pageNum/{pageNum}")
	public String contractUpdate(@PathVariable String pageNum, ConsumerCon consumerCon, Model model) {
		String pay = consumerCon.getCc_pay().replaceAll(",", "");
		consumerCon.setCc_pay(pay);
		System.out.println(consumerCon);
		int result = cs.updateContract(consumerCon);

		int c_num = consumerCon.getC_num();

		model.addAttribute("c_num", c_num);
		model.addAttribute("result", result);
		return "consumer/contractUpdate";
	}

	@RequestMapping("consumer/consumerDelete/pageNum/{pageNum}/c_num/{c_num}")
	public String consumerDelete(@PathVariable String pageNum, @PathVariable int c_num, Model model) {

		int result = 0;
		int isCon = cs.contractCountByNum(c_num);
		int contractDel = 0;
		int isFile = cs.fileCountByNum(c_num);
		int deleteFile = 0;

		if (isFile > 0) {
			deleteFile = cs.filedelete(c_num);
			if (deleteFile > 0) {
				if (isCon > 0) {
					contractDel = cs.contractDelByNum(c_num);
					if (contractDel > 0) {
						result = cs.consumerDelete(c_num);
					} else {
						result = -1;
					}
				} else {
					result = cs.consumerDelete(c_num);
				}
			} else {
				result = -1;
			}
		} else {
			if(isCon > 0) {
				contractDel = cs.contractDelByNum(c_num);
				if(contractDel > 0) {
					result = cs.consumerDelete(c_num);
				} else {
					result = -1;
				}
			} else {
				result = cs.consumerDelete(c_num);
			}
		}

		model.addAttribute("result", result);
		return "consumer/consumerDelete";
	}

	@RequestMapping("consumer/consumerUpdateForm/pageNum/{pageNum}/c_num/{c_num}")
	public String consumerUpdateForm(@PathVariable String pageNum, @PathVariable int c_num, HttpSession session,
			Model model) {
		sideNav(session, model);
		Consumer consumer = cs.selectConsumer(c_num);
		String[] titles = { "남", "여" };
		List<ConsumerFile> consumerFile = cs.fileSelectByNum(c_num);
		
		model.addAttribute("fileList",consumerFile);
		model.addAttribute("titles", titles);
		model.addAttribute("consumer", consumer);
		return "consumer/consumerUpdateForm";
	}
	@RequestMapping("consumer/deleteFile")
	@ResponseBody
	public String deleteFile(int cf_seq) {
		cs.deleteFilebySeq(cf_seq);
		return "consumer/deleteFile";
	}
	
	@RequestMapping("consumer/consumerUpdate/pageNum/{pageNum}")
	public String consumerUpdate(@PathVariable String pageNum,MultipartHttpServletRequest mhr,Consumer consumer,HttpSession session, Model model) throws IOException {
		int updateResult = 0;
		int updateFileResult = 0;
		MultipartFile isFile = mhr.getFile("file");
		
		if(isFile.isEmpty()) {
			updateResult = cs.updateConsumer(consumer);
		} else {
			updateResult = cs.updateConsumer(consumer);
			
			ConsumerFile consumerFile = new ConsumerFile();
			String origin = mhr.getFile("file").getOriginalFilename();
			String path = session.getServletContext().getRealPath("/resources/upload/consumer");
			FileOutputStream fos = new FileOutputStream(new File(path+"/"+origin));
			fos.write(mhr.getFile("file").getBytes());
			fos.close();
			
			int lastIndex = origin.lastIndexOf("."); // 파일명과 확장자 분리
			String fileName = origin.substring(0,lastIndex); // 파일명
			String type = origin.substring(lastIndex+1); // 확장자
			int size = (int)mhr.getFile("file").getSize(); // 사이즈
			
			consumerFile.setCf_origin(origin);
			consumerFile.setCf_name(fileName);
			consumerFile.setCf_type(type);
			consumerFile.setCf_size(size);
			consumerFile.setCf_url(path);
			consumerFile.setC_num(consumer.getC_num());
			updateFileResult = cs.insertFile(consumerFile);
		}
		
		if(updateFileResult > 0) {
			System.out.println("File Update Success");
		} else if(updateFileResult == 0) {
			System.out.println("File Null");
		}
		
		model.addAttribute("c_num",consumer.getC_num());
		model.addAttribute("result",updateResult);
		return "consumer/consumerUpdate";
	}
}
