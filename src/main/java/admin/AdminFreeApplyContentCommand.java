package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board_pds.PdsDAO;
import board_pds.PdsVO;

public class AdminFreeApplyContentCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		PdsDAO dao = new PdsDAO();
		PdsVO vo = dao.getPdsContent(idx);
		
		request.setAttribute("vo", vo);
		//System.out.println(vo);
	}

}
