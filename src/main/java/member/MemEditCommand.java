package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemEditCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String mid = (String)session.getAttribute("sMid");

		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.loginCheck(mid);
		
		request.setAttribute("mid", mid);
		request.setAttribute("nickName", vo.getNickName());
		request.setAttribute("email", vo.getEmail());
		request.setAttribute("tel", vo.getTel());
	}

}
