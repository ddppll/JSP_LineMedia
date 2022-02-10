package board_pds;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class ApplyFreeInputCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/data/pds");
		int maxSize = 1024 * 1024 * 200;
		String encoding = "UTF-8";
		
		// 파일 업로드 처리
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		
		//업로드된 파일의 정보를 DB에 처리하기 위한 작업
		Enumeration fileNames = multipartRequest.getFileNames();
		
		String originalFileName = "";
		String filesystemName = "";
		while(fileNames.hasMoreElements()) {
			String file = (String)fileNames.nextElement();
			
			if(multipartRequest.getOriginalFileName(file) != null) {
				originalFileName += multipartRequest.getOriginalFileName(file) + "/";
				filesystemName += multipartRequest.getFilesystemName(file) + "/";
			}
		}
		
		int fileSize = multipartRequest.getParameter("fileSize") == null? 0 : Integer.parseInt(multipartRequest.getParameter("fileSize"));
		String mid = multipartRequest.getParameter("mid");
		String email = multipartRequest.getParameter("email") == null? "" : multipartRequest.getParameter("email");
		String company = multipartRequest.getParameter("company") == null? "" : multipartRequest.getParameter("company");
		String cellphone = multipartRequest.getParameter("cellphone")==null ? "": multipartRequest.getParameter("cellphone").trim();
		String cellphone2 = multipartRequest.getParameter("cellphone2")==null ? "": multipartRequest.getParameter("cellphone2").trim();
		String cellphone3 = multipartRequest.getParameter("cellphone3")==null ? "": multipartRequest.getParameter("cellphone3").trim();
		String cellNumber = cellphone + "/" + cellphone2 + "/" + cellphone3;
		
		PdsVO vo = new PdsVO();
		vo.setMid(mid);
		vo.setEmail(email);
		vo.setCompany(company);
		vo.setTel(cellNumber);
		vo.setfName(originalFileName);
		vo.setfSName(filesystemName);
		vo.setfSize(fileSize);
		
		PdsDAO dao = new PdsDAO();
		int res = dao.pdsInput(vo);
		
		if(res == 1) {
			request.setAttribute("msg", "pdsInputOk");
			request.setAttribute("url", request.getContextPath()+"/applyFree.ap");
		}
		else {
			request.setAttribute("msg", "pdsInputNo");
			request.setAttribute("url", request.getContextPath()+"/applyFree.ap");
		}

	}

}
