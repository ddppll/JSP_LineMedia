package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conn.SecurityUtil;

public class MemLoginOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.loginCheck(mid);
		
		if(vo != null) { // 아이디 검색 성공, 비번 맞는지 체크
			
			SecurityUtil security = new SecurityUtil();
			pwd = security.encryptSHA256(pwd);
			
			HttpSession session = request.getSession();
			if(pwd.equals(vo.getPwd())) {	// 비밀번호 인증 ok
				session.setAttribute("sMid", mid);
				session.setAttribute("sNickName", vo.getNickName());
				session.setAttribute("sLevel", vo.getLevel());
				
				// 최종 접속일 알아오기
				session.setAttribute("sLastDate", vo.getLastDate().substring(0, vo.getLastDate().lastIndexOf(".")));
				
				//dao.setLastDateUpdate(mid);	//신규 로그인시 수정항목 처리(포인트, 방문수 등)
				dao.setLastDateUpdate(mid);
		
				// 아이디에 대한 정보를 쿠키로 저장 유무 처리?
				String idCheck = request.getParameter("demo-human")==null ? "" : request.getParameter("demo-human");
				if(idCheck.equals("on")) {  // idCheck가 체크되어 있다면, cMid쿠키명으로 쿠키 저장한다.
					Cookie cookie = new Cookie("cMid", mid);
					cookie.setMaxAge(60*60*24*3);	// 쿠키의 만료시간을 3일로 정했다.(단위 '초')
					response.addCookie(cookie);
				}
				else {  // idCheck가 체크 해제되어 있다면, 저장된 cMid 쿠키명을 삭제처리
					Cookie[] cookies = request.getCookies();  // 기존에 저장되어 있는 현재 사이트의 쿠키를 불러와서 배열로 저장한다.
					for(int i=0; i<cookies.length; i++) {
						if(cookies[i].getName().equals("cMid")) {
							cookies[i].setMaxAge(0);	// 저장된 cMid 쿠키를 삭제한다.
							response.addCookie(cookies[i]);
							break;
						}
					}
				}
				
				request.setAttribute("msg", "memberLoginOk");
				request.setAttribute("url", request.getContextPath()+"/");
				request.setAttribute("val", vo.getNickName());
			}
			else {	//아이디는 맞지만 비밀번호 틀림
				request.setAttribute("msg", "memberLoginPwdNo");
				request.setAttribute("url", request.getContextPath()+"/memLogin.mem");
			}
			
		}
		else {	// 아이디 틀림
			request.setAttribute("msg", "memberLoginNo");
			request.setAttribute("url", request.getContextPath()+"/memLogin.mem");
		}
	}

}