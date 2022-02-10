package board_qna;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.MemberDAO;
import member.MemberVO;

public class QnaInputCommand implements QnaBoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String writer = session.getAttribute("sNickName") == null ? "" : (String)session.getAttribute("sNickName");
		String mid = session.getAttribute("sMid") == null ? "" : (String)session.getAttribute("sMid");
		
		MemberDAO dao = new MemberDAO();
		
		MemberVO vo = dao.loginCheck(mid); //아이디 일치하는 자료 가져오기
		
		request.setAttribute("email", vo.getEmail());
		request.setAttribute("tel", vo.getTel());
	}


	

}
