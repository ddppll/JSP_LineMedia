package board_qna;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class QnaEditOkCommand implements QnaBoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		String mid = session.getAttribute("sMid") == null ? "" : (String) session.getAttribute("sMid");
		String nickName = session.getAttribute("sNickName") == null? "" : (String)session.getAttribute("sNickName");
		String title = request.getParameter("title") == null ? "" : request.getParameter("title");
		String email = request.getParameter("email") == null ? "" : request.getParameter("email");
		String content = request.getParameter("content") == null ? "" : request.getParameter("content");
		String secret = request.getParameter("demo-human") == null ? "" : request.getParameter("demo-human");
		
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize")==null ? 5 : Integer.parseInt(request.getParameter("pageSize"));
		
		// title필드에는 태그 사용 금지(< --->&lt;  , > ---> &gt;)
		title = title.replace("<", "&lt;");
		title = title.replace(">", "&gt;");
		
		QnaVO vo = new QnaVO();
		
		String secretCheck = "1";
		
		if(secret.equals("on")) {
			secretCheck = "0"; //비밀글 체크 함
		}
		
		vo.setIdx(idx);
		vo.setMid(mid);
		vo.setNickName(nickName);
		vo.setTitle(title);
		vo.setEmail(email);
		vo.setContent(content);
		vo.setSecret(secretCheck);
		
		//System.out.println(vo);
		
		QnaDAO dao = new QnaDAO();
		int res = dao.qnaEditOk(vo);
		
		
		if (res == 1) {
			request.setAttribute("msg", "qnaEditOk");
			request.setAttribute("url", request.getContextPath()+"/qnaContent.qa?idx="+idx+"&pag="+pag+"&pageSize="+pageSize);
		}
		else {
			request.setAttribute("msg", "qnaEditNo");
			request.setAttribute("url", request.getContextPath()+"/qnaEdit.qa?idx="+idx+"&pag="+pag+"&pageSize="+pageSize);
		}
	}

}
