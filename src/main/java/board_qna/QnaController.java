package board_qna;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.IdCheckCommand;


@WebServlet("*.qa")
public class QnaController extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		QnaBoardInterface command = null;
		String viewPage="/WEB-INF/board_qna";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"),uri.lastIndexOf("."));
		
		if(com.equals("/qnaList")) {
			command = new QnaListCommand();
			command.execute(request, response);
			viewPage+="/qnaList.jsp";
		}
		else if(com.equals("/qnaInput")) {
			command = new QnaInputCommand();
			command.execute(request, response);
			viewPage+="/qnaInput.jsp";
		}
		else if(com.equals("/qnaInputOk")) {
			command = new QnaInputOkCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/message/message.jsp";
		}
		else if(com.equals("/qnaSearch")) {
			command = new QnaSearchCommand();
			command.execute(request, response);
			viewPage+="/qnaSearch.jsp";
		}
		else if(com.equals("/qnaContent")) {
			command = new QnaContentCommand();
			command.execute(request, response);
			viewPage+="/qnaContent.jsp";
		}
		else if(com.equals("/qnaDelete")) {
			command = new QnaDeleteCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/message/message.jsp";
		}
		else if(com.equals("/qnaReplyInput")) {
			command = new QnaReplyInputCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/message/message.jsp";
		}
		else if(com.equals("/qnaEdit")) {
			command = new QnaEditCommand();
			command.execute(request, response);
			viewPage+="/qnaEdit.jsp";
		}
		else if(com.equals("/qnaEditOk")) {
			command = new QnaEditOkCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/message/message.jsp";
		}
		else if(com.equals("/qnaReplyEditOk")) {
			command = new QnaReplyEditOkCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/qnaReplyDelete")) {
			int replyIdx = request.getParameter("replyIdx") == null ? 0 : Integer.parseInt(request.getParameter("replyIdx"));
			QnaDAO dao = new QnaDAO();
			dao.setReplyDelete(replyIdx);
			return;
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
