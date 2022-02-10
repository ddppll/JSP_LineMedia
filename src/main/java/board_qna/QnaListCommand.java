package board_qna;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board_apply.ApplyDAO;
import board_apply.ApplyVO;

public class QnaListCommand implements QnaBoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String mid = (String)session.getAttribute("sMid");
		String writer = (String)session.getAttribute("sNickName");
		
		QnaDAO dao = new QnaDAO();
		
		/* 이곳부터 페이징 처리(블록페이지) 변수 지정 시작 */
		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize") == null? 5 : Integer.parseInt(request.getParameter("pageSize"));
		  
		//최근글 수정을 위해서 bolistcommand에서 이 두줄을 수정함
		int lately = request.getParameter("lately") == null? 0 : Integer.parseInt(request.getParameter("lately"));
		System.out.println("lately : " + lately);
		int totRecCnt = 0;
		if(lately == 0) totRecCnt = dao.totRecCnt();
		else totRecCnt = dao.totRecCntLately(lately);
		
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStrarNo = totRecCnt - startIndexNo;
		int blockSize = 3;		// 한블록의 크기를 3개의 Page로 본다.(사용자가 지정한다.)
		int curBlock = (pag - 1) / blockSize;		// 현재페이지의 블록위치
		int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
		
		List<QnaVO> vos = null;
	  	vos = dao.getQnaList(startIndexNo, pageSize,lately); //전체자료검색
	  	//System.out.println(vos);
	  	
		request.setAttribute("vos", vos);
		request.setAttribute("pag", pag);
		request.setAttribute("totPage", totPage);
		request.setAttribute("curScrStrarNo", curScrStrarNo);
		request.setAttribute("blockSize", blockSize);
		request.setAttribute("curBlock", curBlock);
		request.setAttribute("lastBlock", lastBlock);
		request.setAttribute("pageSize", pageSize);
		
		
		//System.out.println("vos : " + vos );
		
		//최근게시글보기(이 서블릿)에서 추가한 부분
		request.setAttribute("lately", lately);
		
		request.setAttribute("writer", writer);

	}

}
