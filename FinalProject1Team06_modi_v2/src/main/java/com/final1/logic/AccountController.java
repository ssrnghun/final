/*====================
   Sample.java
   - 컨트롤러 객체
====================*/

package com.final1.logic;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AccountController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/accountlist.action", method = RequestMethod.GET)
	public String accountList(Model model, String room_num,String day,String page, HttpSession session)
	{
		String result = "";
		
		String id = (String)session.getAttribute("id");
		
		IAccountDAO dao = sqlSession.getMapper(IAccountDAO.class);
		IRoomDAO dao2 = sqlSession.getMapper(IRoomDAO.class);
		
		model.addAttribute("planner", dao.planner(room_num));
		model.addAttribute("page",page);
		model.addAttribute("id_num",dao2.findIdNum(id));
		
		if(day != null)
		{
			model.addAttribute("dayFlag", day);
			model.addAttribute("accountListSel", dao.AccountListSel(room_num, day));
			
			if(!dao.AccountListSel(room_num, day).isEmpty())
			{
				model.addAttribute("cost",dao.dayCost(room_num, day));
			}
			else
				model.addAttribute("cost",0);
		}
		else
		{
			model.addAttribute("dayFlag", "");
			model.addAttribute("accountList", dao.AccountList(room_num));
			model.addAttribute("cost",dao.totalCost(room_num));
		}
		
		result = "AccountBook.jsp";
		
		return result;
	}
	
	@RequestMapping(value = "/accountcal.action", method = RequestMethod.GET)
	public String accountCal(Model model, String room_num, HttpSession session)
	{
		String result = "";
		
		IAccountDAO dao = sqlSession.getMapper(IAccountDAO.class);
		IRoomDAO dao2 = sqlSession.getMapper(IRoomDAO.class);
		model.addAttribute("sumCost", dao.sumCost(room_num));
		model.addAttribute("room_num", room_num);
		
		String id = (String)session.getAttribute("id");
		
		model.addAttribute("nikName", dao.findNikname(dao2.findIdNum(id)));
		ArrayList<AccountDTO> list = new ArrayList<AccountDTO>();
		
		boolean flag = false;
		
		// 해당 방의 PAY NUM
		for(AccountDTO dto : dao.payNum(room_num))
		{
			for(AccountDTO give : dao.giveMem(dto.getPay_num()))
			{
				for(AccountDTO take : dao.takeMem(dto.getPay_num()))
				{
					// 돈받는 사람 인원 수
					int count = dao.takeMemCount(dto.getPay_num());
					int cost = Integer.parseInt(give.getTotal()) / count;
					
					for(AccountDTO total : list)
					{
						
						// 기존 list 에서 사람은 같지만, 뒤바뀌어있으면....
						if(total.getTakemember().equals(give.getNikname()) && total.getGivemember().equals(take.getNikname()))
						{
							flag = true;
							if( total.getCost() - cost <0)
							{
								// 주는 사람 
								total.setGivemember(give.getNikname());
								total.setGivePhoto(give.getPhoto());
								
								// 받는 사람
								total.setTakemember(take.getNikname());
								total.setTakePhoto(take.getPhoto());
								
								// 금액
								total.setCost(cost-total.getCost());
							}
							else if (total.getCost() - cost >=0)
							{
								total.setCost(total.getCost() - cost);
							}
							
						}
						// 기존 list 에 해당 주고 받은 내역이 있으면...
						else if(total.getGivemember().equals(give.getNikname()) && total.getTakemember().equals(take.getNikname()))
						{
							flag = true;
							// 기존 금액에서 더하기
							total.setCost(total.getCost() + cost); 
						}
							
					}
					
					if(!flag)
					{
						// 결제 건마다 주는 사람 받는 사람 받는 dto
						AccountDTO res = new AccountDTO();
						
						// 주는 사람 
						res.setGivemember(give.getNikname());
						res.setGivePhoto(give.getPhoto());
						// 받는 사람
						res.setTakemember(take.getNikname());
						res.setTakePhoto(take.getPhoto());
						// 줄 금액
						res.setCost(Integer.parseInt(give.getTotal()) / count);
						
						list.add(res);
					}
				}
			}
		}
		Collections.sort(list, new NameComparator());
		
		
		for(AccountDTO dto2 : list)
		{
			
			System.out.println(dto2.getGivemember()+"/"+dto2.getTakemember()+"/"+dto2.getCost());
		}
		
		model.addAttribute("list", list);
		
		result = "AccountList.jsp";
		
		return result;
	}
	
	public String jungSan(Model model, String pay_num)
	{
		String result = "";
		
		IAccountDAO dao = sqlSession.getMapper(IAccountDAO.class);
		
		System.out.println("== 가계부 정산 ==");
		
		// 값을 준비 (실제로는 오라클에서 받아오는 부분)
		//--------------------------------------------------------------
		ArrayList<AccountDTO> list = new ArrayList<AccountDTO>();
		
		for(AccountDTO account : dao.payCal(pay_num))
		{
			AccountDTO pay = new AccountDTO();
			
			pay.setPayMember(account.getPayMember());
			pay.setWithMember(account.getWithMember());
			pay.setPayMoney(account.getPayMoney());
			pay.setWithMoney(account.getWithMoney());
			pay.setTotal(account.getTotal());
			
			list.add(pay);
		}
		
		//--------------------------------------------------------------
		
		// 계산과정
		
		// 정산금이 플러스인 것은 돈이 줘야하는 것
		// 정산금이 마이너스인 것은 돈을 받아야 하는 것
		// 정산금이 0이면 안 주고 안 받으니까 제외
		
		int countMinus = 0; // 마이너스인 사람 수
		
		for (int i=0; i<list.size(); i++)
		{
			if (Integer.parseInt(list.get(i).getTotal()) < 0)
			{
				System.out.println("돈 받을 사람 : " + list.get(i).getNikname());
				countMinus++;
			}
		}
		
		System.out.println("받아야하는 사람 수 : " + countMinus);
		
		for (int i=0; i<list.size(); i++)
		{
			if (Integer.parseInt(list.get(i).getTotal()) > 0)
			{
				System.out.println("돈 줄 사람 : " + list.get(i).getWithMember());
				System.out.println("각각에게 줄 돈 : " + Integer.parseInt(list.get(i).getTotal()) / (double)countMinus);
			}
		}
		
		
				
				
		return result; 
	}
	
	
	@RequestMapping(value = "/accountadd.action", method = RequestMethod.GET)
	public String accountAdd(Model model, String room_num, String day, String date)
	{
		String result = "";
		
		IAccountDAO dao = sqlSession.getMapper(IAccountDAO.class);
		model.addAttribute("room_num", room_num);
		model.addAttribute("day", day);
		model.addAttribute("date", date);
		model.addAttribute("member", dao.sumCost(room_num));
		
		result = "AccountAdd.jsp";
		
		return result;
	}
	
	@RequestMapping(value = "/accountinsert.action", method = RequestMethod.GET)
	public String accountInsert(AccountDTO dto, HttpServletRequest request, Model model)
	{
		String result = "";
		
		IAccountDAO dao = sqlSession.getMapper(IAccountDAO.class);
		System.out.println(dto.getPaid_date());
		int res1 = dao.AccountAdd(dto);
		System.out.println(res1);
		
		String[] pay = request.getParameterValues("pay");
		 for (int i = 0; i < pay.length; i++) 
		 {
            dto.setMem_join_num(pay[i]);
            int res2 = dao.memPayAdd(dto);
            System.out.println(res2);
	     }
		 
		String[] doing = request.getParameterValues("do");
		for (int i = 0; i < doing.length; i++) 
		{
            dto.setMem_join_num(doing[i]);
            int res3 = dao.memWithAdd(dto);
            System.out.println(res3);
        }
		
		model.addAttribute("room_num", dto.getRoom_num());
		model.addAttribute("page", "2");
		
		result = "accountlist.action";
		
		return result;
	}
	
	@RequestMapping(value = "/accountdel.action", method = RequestMethod.GET)
	public String accountDel(Model model, String room_num, String pay_num)
	{
		String result = "";
		
		IAccountDAO dao = sqlSession.getMapper(IAccountDAO.class);
		
		dao.accountDel(pay_num);
		
		model.addAttribute("room_num", room_num);
		model.addAttribute("page", "2");
		
		result = "accountlist.action";
		
		return result;
	}
	
}
