package com.pj.gajobs.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pj.gajobs.model.Consumer;
import com.pj.gajobs.model.Education;
import com.pj.gajobs.model.Member;
import com.pj.gajobs.model.Notice;
import com.pj.gajobs.model.Reference;
import com.pj.gajobs.service.ConsumerService;
import com.pj.gajobs.service.EducationService;
import com.pj.gajobs.service.MemberService;
import com.pj.gajobs.service.NoticeService;
import com.pj.gajobs.service.ReferenceSevice;

@Controller
public class MainController {
	
	@Autowired
	private MemberService ms;
	@Autowired
	private NoticeService ns;
	@Autowired
	private EducationService es;
	@Autowired
	private ReferenceSevice rs;
	@Autowired
	private ConsumerService cs;
	
	@RequestMapping("main/home")
	public String home(HttpSession session,Model model) {
		String m_id = session.getAttribute("id").toString();
		Member member = ms.select(m_id);
		
		Calendar week = Calendar.getInstance();
		week.add(Calendar.DATE, -7);
		Calendar date = Calendar.getInstance();
		date.add(Calendar.DATE, +1);
		SimpleDateFormat datefomat = new SimpleDateFormat("yyyy-MM-dd");
		String today = datefomat.format(date.getTime());
		String beforeWeek = datefomat.format(week.getTime());
		
		Notice notice = new Notice();
		Education education = new Education();
		Reference reference = new Reference();
		Consumer consumer = new Consumer();
		
		notice.setStartDate(beforeWeek);
		notice.setEndDate(today);
		education.setStartDate(beforeWeek);
		education.setEndDate(today);
		reference.setStartDate(beforeWeek);
		reference.setEndDate(today);
		consumer.setStartDate(beforeWeek);
		consumer.setEndDate(today);
		
		int noticeCount = ns.noticeCount(notice);
		List<Notice> noticeList = ns.noticeListByDate(notice);
		int educationCount = es.eduCount(education);
		List<Education> eduList = es.eduListByDate(education);
		int referenceCount = rs.refCount(reference);
		List<Reference> refList = rs.referenceListByDate(reference);
		int consumerCount = cs.conCount(consumer);
		List<Consumer> conList = cs.consumerListByDate(consumer);
		
		model.addAttribute("conList",conList);
		model.addAttribute("refList",refList);
		model.addAttribute("eduList",eduList);
		model.addAttribute("noticeList",noticeList);
		model.addAttribute("countNotice",noticeCount);
		model.addAttribute("countEdu",educationCount);
		model.addAttribute("countReference",referenceCount);
		model.addAttribute("countConsumer",consumerCount);
		model.addAttribute("sideNav",member);
		return "main/home";
	}
	
	@RequestMapping("notiles/logout") 
		public String logout(HttpSession session) {
			session.invalidate();
			return "notiles/logout";
		}
}
