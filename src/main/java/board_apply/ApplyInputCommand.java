package board_apply;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ApplyInputCommand implements ApplyBoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		String mid = session.getAttribute("sMid") == null ? "" : (String) session.getAttribute("sMid");
		String nickName = session.getAttribute("sNickName") == null? "" : (String)session.getAttribute("sNickName");
		
		String company = request.getParameter("company") == null? "" : request.getParameter("company");
		String cellphone = request.getParameter("cellphone")==null ? "": request.getParameter("cellphone").trim();
		String cellphone2 = request.getParameter("cellphone2")==null ? "": request.getParameter("cellphone2").trim();
		String cellphone3 = request.getParameter("cellphone3")==null ? "": request.getParameter("cellphone3").trim();
		String cellNumber = cellphone + "/" + cellphone2 + "/" + cellphone3;
		String email = request.getParameter("email") == null? "" : request.getParameter("email");
		String title = request.getParameter("title") == null? "" : request.getParameter("title");
		String category = request.getParameter("category") == null? "" : request.getParameter("category");
		String sourceLang = request.getParameter("sourceLang") == null? "" : request.getParameter("sourceLang");
		String targetLang = request.getParameter("targetLang") == null? "" : request.getParameter("targetLang");
		String content = request.getParameter("content") == null? "" : request.getParameter("content");
		
		// title필드에는 태그 사용 금지(< --->&lt;  , > ---> &gt;)
		title = title.replace("<", "&lt;");
		title = title.replace(">", "&gt;");
		
		ApplyVO vo = new ApplyVO();
		vo.setMid(mid);
		vo.setNickName(nickName);
		vo.setCompany(company);
		vo.setTel(cellNumber);
		vo.setEmail(email);
		vo.setTitle(title);
		vo.setCategory(category);
		vo.setSourceLang(sourceLang);
		vo.setTargetLang(targetLang);
		vo.setContent(content);
		
		
		ApplyDAO dao = new ApplyDAO();
		
		int res = dao.applyInput(vo);
		
		if (res == 1) {
			request.setAttribute("msg", "applyInputOk");
			request.setAttribute("url",request.getContextPath()+"/applyList.ap");
		}
		else {
			request.setAttribute("msg", "applyInputNo");
			request.setAttribute("url",request.getContextPath()+"/applyList.ap");
		}

	}

}
