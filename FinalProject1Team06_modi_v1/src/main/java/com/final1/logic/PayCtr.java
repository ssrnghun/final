package com.final1.logic;

import java.util.ArrayList;

public class PayCtr
{
		public static void main(String[] args)
		{
			System.out.println("== 가계부 정산 ==");
			
			// 값을 준비 (실제로는 오라클에서 받아오는 부분)
			//--------------------------------------------------------------
			ArrayList<AccountDTO> list = new ArrayList<AccountDTO>();

			AccountDTO dto1 = new AccountDTO();
			AccountDTO dto2 = new AccountDTO();
			AccountDTO dto3 = new AccountDTO();
			
			
			
			
			dto1.setPayMember("MEM-JOIN-00001");
			dto2.setPayMember("MEM-JOIN-00002");
			dto3.setPayMember(null);
			
			dto1.setWithMember("MEM-JOIN-00001");
			dto2.setWithMember("MEM-JOIN-00002");
			dto3.setWithMember("MEM-JOIN-00004");
			
			dto1.setPayMoney("-60000");
			dto2.setPayMoney("-60000");
			dto3.setPayMoney("0");
			
			dto1.setWithMoney("40000");
			dto2.setWithMoney("40000");
			dto3.setWithMoney("40000");
			
			dto1.setTotal("-20000");
			dto2.setTotal("-20000");
			dto3.setTotal("40000");
			
			list.add(dto1);
			list.add(dto2);
			list.add(dto3);
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
					System.out.println("돈 받을 사람 : " + list.get(i).getPayMember());
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
			// 아래에 실행결과
		}
	}

