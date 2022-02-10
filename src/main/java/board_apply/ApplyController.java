package board_apply;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.MemLoginOkCommand;
import member.MemberInterface;

@WebServlet("*.ap")
public class ApplyController extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ApplyBoardInterface command = null;
		String viewPage="/WEB-INF/board_apply";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"),uri.lastIndexOf("."));
		
		HttpSession session = request.getSession();
		
		int level = session.getAttribute("sLevel")== null ? 99 : (int) session.getAttribute("sLevel");
		if(level == 99) {
			response.setContentType("text/html; charset=UTF-8"); 
			PrintWriter writer = response.getWriter(); 
			writer.println("<script>alert('로그인한 뒤 이용 가능합니다'); location.href='memLogin.mem';</script>"); 
			writer.close();
			
//			RequestDispatcher dispatcher = request.getRequestDispatcher("/");
//			dispatcher.forward(request, response);
			return;
		}
	
		if(com.equals("/apply")) {
			viewPage+="/apply.jsp";
		}
		//견적 신청 등록
		else if(com.equals("/applyInput")) {
			command = new ApplyInputCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/message/message.jsp";
		}
		else if(com.equals("/applyList")) {
			command = new ApplyListCommand();
			command.execute(request, response);
//			viewPage += "/applyList.jsp";
			viewPage+="/applyList.jsp";
		}
		else if(com.equals("/applyList")) {
			command = new ApplyListCommand();
			command.execute(request, response);
			viewPage+="/applyList.jsp";
		}
		else if(com.equals("/applyContent")) {
			command = new ApplyContentCommand();
			command.execute(request, response);
			viewPage+="/applyContent.jsp";
		}
		else if(com.equals("/applySearch")) {
			command = new ApplySearchCommand();
			command.execute(request, response);
			viewPage+="/applySearch.jsp";
		}
		else if(com.equals("/applyFree")) {
			viewPage+="/applyFree.jsp";
		}
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}

}
