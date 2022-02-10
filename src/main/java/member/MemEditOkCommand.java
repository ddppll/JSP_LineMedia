package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.SecurityUtil;

public class MemEditOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String mid = request.getParameter("mid")==null ? "": request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "": request.getParameter("pwd").trim();
		String nickName = request.getParameter("nickName")==null ? "": request.getParameter("nickName").trim();
		String email = request.getParameter("email")==null ? "": request.getParameter("email").trim();
		String cellphone = request.getParameter("cellphone")==null ? "": request.getParameter("cellphone").trim();
		String cellphone2 = request.getParameter("cellphone2")==null ? "": request.getParameter("cellphone2").trim();
		String cellphone3 = request.getParameter("cellphone3")==null ? "": request.getParameter("cellphone3").trim();
		String cellNumber = cellphone + "/" + cellphone2 + "/" + cellphone3;
		
		//System.out.println("mid : "+mid);
		//System.out.println("nickName : " +nickName);
		
		MemberDAO dao = new MemberDAO();
		
		//비밀번호 암호화
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		MemberVO vo = new MemberVO();
		
		vo.setMid(mid);
		vo.setPwd(pwd);
		vo.setNickName(nickName);
		vo.setEmail(email);
		vo.setTel(cellNumber);
		
		int res = dao.setMemberUpdateOk(vo);
		
		if(res == 1) {  // 정상적으로 정보 수정 완료
			request.setAttribute("msg", "memberEditOk");
		}
		else {
			request.setAttribute("msg", "memberEditNo");
		}
		request.setAttribute("url", request.getContextPath()+"/memEdit.mem");
					
	}

}
