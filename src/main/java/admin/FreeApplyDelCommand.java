package admin;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import board_pds.PdsDAO;
import board_pds.PdsVO;

public class FreeApplyDelCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int pag = request.getParameter("pag") == null ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize") == null ? 5 : Integer.parseInt(request.getParameter("pageSize"));
		String fSNames[] = request.getParameter("fSName").split("/"); //얘는 객체로 넘어오니까 null값이 null로 넘어옴. null값처리 삼항연산자로 안해도 됨
		
		PdsDAO dao = new PdsDAO();
		
		String realPath = request.getServletContext().getRealPath("/data/pds/"); //절대경로
		for(String fSName : fSNames) {
			new File(realPath+fSName).delete();
		}
		
		int res = dao.pdsDelete(idx);
		
		if(res == 1) {
			response.getWriter().write("applyDeleteOk");
			request.setAttribute("url",request.getContextPath()+"/admin_freeApplyList.ad?pag="+pag+"&pageSize="+pageSize);
		}
		else {
			response.getWriter().write("applyDeleteNo");
		}
	}

}
