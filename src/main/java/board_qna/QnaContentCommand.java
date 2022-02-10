package board_qna;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board_apply.ApplyDAO;
import board_apply.ApplyVO;

public class QnaContentCommand implements QnaBoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String mid = (String)session.getAttribute("sMid");
		String writer = (String)session.getAttribute("sNickName");
		
		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int pag = request.getParameter("pag") == null ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize") == null ? 5 : Integer.parseInt(request.getParameter("pageSize"));
		int lately = request.getParameter("lately") == null ? 0 : Integer.parseInt(request.getParameter("lately"));
		
		// 검색폼에서 값이 넘어올 경우 - 이거 결국 안썼음
		String sw = request.getParameter("sw")==null ? "" : request.getParameter("sw");
		request.setAttribute("sw", sw);
		
		QnaDAO dao = new QnaDAO();
		
		// 댓글 수정시 처리하는 부분
		int replyIdx = request.getParameter("replyIdx") == null ? 0 : Integer.parseInt(request.getParameter("replyIdx"));
		if(replyIdx != 0) {
			String replyContent = dao.getReply(replyIdx);
			request.setAttribute("replyIdx", replyIdx);
			request.setAttribute("replyContent", replyContent);
		}
		
		// 조회수 증가처리(조회수 중복방지)
		// 세션배열(객체배열:ArrayList()) : 고유세션아이디 + 'board' + '현재글의 고유번호'
		ArrayList<String> contentIdx = (ArrayList)session.getAttribute("sContentIdx");
		if(contentIdx == null) {
			contentIdx = new ArrayList<String>();
			session.setAttribute("sContentIdx", contentIdx);
			//System.out.println("1.contentIdx : " + contentIdx);
		}
		String imsiContentIdx = session.getId() + "board" + idx;
		if(!contentIdx.contains(imsiContentIdx)) {
			dao.setReadNum(idx);
			contentIdx.add(imsiContentIdx);
			//System.out.println("2.contentIdx : " + contentIdx);
		}
		
		QnaVO vo = dao.getQnaContent(idx);	// vo : 현재 글을 저장하고 있는 vo
		
		request.setAttribute("vo", vo);
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("lately", lately);
		
		// '이전글(preVO)'/'다음글(nextVO)'처리하기 - sql문만 바뀌면 되고 처리는 같으니 하나의 메소드에서 처리한다
		QnaVO preVO = dao.preNextSearch("pre", idx);		//이전글 처리
		QnaVO nextVO = dao.preNextSearch("next", idx);	//다음글 처리
		request.setAttribute("preVO", preVO);
		request.setAttribute("nextVO", nextVO);
		
		// 댓글 읽어오기
		List<QnaReplyVO> replyVOS = dao.getReplyQna(idx);
		request.setAttribute("replyVOS", replyVOS);

	}

}
