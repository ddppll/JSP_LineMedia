package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board_apply.ApplyDAO;
import board_qna.QnaDAO;

public class AdminApplyDelCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int pag = request.getParameter("pag") == null ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize") == null ? 5 : Integer.parseInt(request.getParameter("pageSize"));
		
		ApplyDAO dao = new ApplyDAO();
		
		int res = dao.applyDelete(idx);
		
		if (res == 1) {
			request.setAttribute("msg", "applyDeleteOk");
			request.setAttribute("url",request.getContextPath()+"/admin_apply.ad?pag="+pag+"&pageSize="+pageSize);
		}
		else {
			request.setAttribute("msg", "applyDeleteNo");
			request.setAttribute("url",request.getContextPath()+"/admin_applyContent.ad?idx="+idx+"&pag="+pag+"&pageSize="+pageSize);
		}
	}

}
