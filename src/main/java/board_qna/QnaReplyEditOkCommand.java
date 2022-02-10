package board_qna;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class QnaReplyEditOkCommand implements QnaBoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int replyIdx = request.getParameter("replyIdx") == null ? 0 : Integer.parseInt(request.getParameter("replyIdx"));
		String content = request.getParameter("content") == null ? "" : request.getParameter("content");
		
		QnaDAO dao = new QnaDAO();
		
		dao.QnaReplyUpdateOk(replyIdx, content);

	}

}
