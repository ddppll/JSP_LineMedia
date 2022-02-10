package admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberDAO;
import member.MemberVO;

public class AdminMemListCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		
		/* 이곳부터 페이징 처리(블록페이지) 변수 지정 시작 */
		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize") == null? 5 : Integer.parseInt(request.getParameter("pageSize"));
		  
		MemberDAO dao = new MemberDAO();
		
		int totRecCnt = dao.totRecCnt(mid);
		
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStrarNo = totRecCnt - startIndexNo;
		int blockSize = 3;		// 한블록의 크기를 3개의 Page로 본다.(사용자가 지정한다.)
		int curBlock = (pag - 1) / blockSize;		// 현재페이지의 블록위치
		int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
		
		ArrayList<MemberVO> vos = dao.getAdminMemList(startIndexNo, pageSize, mid); //전체자료검색
	  	
		request.setAttribute("vos", vos);
		request.setAttribute("pag", pag);
		request.setAttribute("totPage", totPage);
		request.setAttribute("curScrStrarNo", curScrStrarNo);
		request.setAttribute("blockSize", blockSize);
		request.setAttribute("curBlock", curBlock);
		request.setAttribute("lastBlock", lastBlock);
		request.setAttribute("pageSize", pageSize);

	}

}
