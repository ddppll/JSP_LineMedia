package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board_apply.ApplyDAO;
import board_apply.ApplyVO;

public class AdminApplyContentCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String mid = (String)session.getAttribute("sMid");
		String writer = (String)session.getAttribute("sNickName");
		
		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int pag = request.getParameter("pag") == null ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize") == null ? 5 : Integer.parseInt(request.getParameter("pageSize"));
		int lately = request.getParameter("lately") == null ? 0 : Integer.parseInt(request.getParameter("lately"));
		
		// 검색폼에서 값이 넘어올 경우 - 이거 결국 안썼음
		String sw = request.getParameter("sw")==null ? "" : request.getParameter("sw");
		request.setAttribute("sw", sw);
		
		ApplyDAO dao = new ApplyDAO();
		
		ApplyVO vo = dao.getApplyContent(idx);	// vo : 현재 글을 저장하고 있는 vo
		
		request.setAttribute("vo", vo);
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("lately", lately);
		
		// '이전글(preVO)'/'다음글(nextVO)'처리하기 - sql문만 바뀌면 되고 처리는 같으니 하나의 메소드에서 처리한다
		ApplyVO preVO = dao.preNextSearch("pre", idx);		//이전글 처리
		ApplyVO nextVO = dao.preNextSearch("next", idx);	//다음글 처리
		request.setAttribute("preVO", preVO);
		request.setAttribute("nextVO", nextVO);

	}

}
