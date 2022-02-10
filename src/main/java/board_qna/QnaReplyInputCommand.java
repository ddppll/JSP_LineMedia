package board_qna;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class QnaReplyInputCommand implements QnaBoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int qnaIdx = request.getParameter("qnaIdx") == null? 0 : Integer.parseInt(request.getParameter("qnaIdx"));
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		String nickName = request.getParameter("nickName") == null ? "" : request.getParameter("nickName");
		String content = request.getParameter("content") == null ? "" : request.getParameter("content");
		int pag = request.getParameter("pag") == null? 0 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize") == null? 0 : Integer.parseInt(request.getParameter("pageSize"));
		int lately = request.getParameter("lately")==null? 0 : Integer.parseInt(request.getParameter("lately"));
	
		QnaReplyVO replyVO = new QnaReplyVO();
		replyVO.setQnaIdx(qnaIdx);
		replyVO.setMid(mid);
		replyVO.setNickName(nickName);
		replyVO.setContent(content);
		
		//System.out.println(replyVO);
		
		QnaDAO dao = new QnaDAO();
		dao.QnaReplyInput(replyVO);
		
		request.setAttribute("msg", "qnaReplyInputOk");
		request.setAttribute("url", request.getContextPath()+"/qnaContent.qa?idx="+qnaIdx+"&pag="+pag+"&pageSize="+pageSize+"&lately="+lately);

	}

}
