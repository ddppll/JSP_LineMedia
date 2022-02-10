package admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("*.ad")
public class AdminController extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminInterface command = null;
		String viewPage="/WEB-INF/admin";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"),uri.lastIndexOf("."));
		
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		int level = session.getAttribute("sLevel")== null ? 99 : (int) session.getAttribute("sLevel");
		
		if(mid == null || level >= 4) {
			viewPage = "/WEB-INF/member/member_login.jsp";
		}
		
		else if(com.equals("/admin_frame")) {
			viewPage+="/admin_frame.jsp";
		}
		else if(com.equals("/admin_left")) {
			viewPage += "/admin_left.jsp";
		}
		else if(com.equals("/admin_content")) {
			viewPage += "/admin_content.jsp";
		}
		else if(com.equals("/admin_apply")) {
			command = new AdminApplyListCommand();
			command.execute(request, response);
			viewPage += "/admin_apply.jsp";
		}
		else if(com.equals("/admin_applyContent")) {
			command = new AdminApplyContentCommand();
			command.execute(request, response);
			viewPage += "/admin_applyContent.jsp";
		}
		else if(com.equals("/admin_applyDel")) {
			command = new AdminApplyDelCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/message/message.jsp";
		}
		else if(com.equals("/admin_applySearch")) {
			command = new AdminApplySearchCommand();
			command.execute(request, response);
			viewPage+="/admin_applySearch.jsp";
		}
		else if(com.equals("/admin_memList")) {
			command = new AdminMemListCommand();
			command.execute(request, response);
			viewPage+="/admin_memList.jsp";
		}
		else if(com.equals("/admin_memDel")) {
			command = new AdminMemDelCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/message/message.jsp";
		}
		else if(com.equals("/admin_freeApplyList")) {
			command = new AdminFreeApplyListCommand();
			command.execute(request, response);
			viewPage+="/admin_freeApplyList.jsp";
		}
		else if(com.equals("/admin_freeApplyContent")) {
			command = new AdminFreeApplyContentCommand();
			command.execute(request, response);
			viewPage+="/admin_freeApplyContent.jsp";
		}
		else if(com.equals("/freeApplyDel")) {
			command = new FreeApplyDelCommand();
			command.execute(request, response);
			return;
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}

