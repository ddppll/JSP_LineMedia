package board_qna;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class QnaDeleteCommand implements QnaBoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int pag = request.getParameter("pag") == null ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize") == null ? 5 : Integer.parseInt(request.getParameter("pageSize"));
		
		QnaDAO dao = new QnaDAO();
		
		int res = dao.qnaDelete(idx);
		
		if (res == 1) {
			request.setAttribute("msg", "qnaDeleteOk");
			request.setAttribute("url",request.getContextPath()+"/qnaList.qa?pag="+pag+"&pageSize="+pageSize);
		}
		else {
			request.setAttribute("msg", "qnaDeleteNo");
			request.setAttribute("url",request.getContextPath()+"/qnaContent.qa?idx="+idx+"&pag="+pag+"&pageSize="+pageSize);
		}

	}

}
