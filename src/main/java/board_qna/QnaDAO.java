package board_qna;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import board_apply.ApplyVO;
import conn.GetConn;
import conn.TimeDiff;

public class QnaDAO {
	GetConn getConn = GetConn.getInstance();
	
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	QnaVO vo = null;
	QnaReplyVO qnaReplyVO = null;

	//문의 등록
	public int qnaInput(QnaVO vo) {
		int res = 0;
		try {
			sql="insert into board_qna values(default, ?, ?, ?, ?, default, default,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getNickName());
			pstmt.setString(2, vo.getTitle());
			pstmt.setString(3, vo.getEmail());
			pstmt.setString(4, vo.getContent());
			pstmt.setString(5, vo.getMid());
			pstmt.setString(6, vo.getSecret());
			pstmt.executeUpdate();
			res=1;
			
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	//게시글 총 건수
	public int totRecCnt() {
		int totRecCnt = 0;
		try {
			sql = "select count(*) from board_qna";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt(1);
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return totRecCnt;
	}

	//최근글 개수 가져오기
	public int totRecCntLately(int lately) {
		int totRecCnt = 0;
		try {
			sql = "select count(*) from board_qna where date_sub(now(), interval ? day) < wDate";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, lately);
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt(1);
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return totRecCnt;
	}

	//문의 목록 보기
	public List<QnaVO> getQnaList(int startIndexNo, int pageSize, int lately) {
		List<QnaVO> vos = new ArrayList<QnaVO>();
		try {
			if(lately == 0) {//자료검색
				sql = "select *, (select count(*) from qnaReply where qnaIdx = board_qna.idx) as replyCount from board_qna order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
				rs = pstmt.executeQuery();
			}
			else { //최근 게시글 보기
				sql="select * from board_qna where date_sub(now(), interval ? day) < wDate order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, lately);
				pstmt.setInt(2, startIndexNo);
				pstmt.setInt(3, pageSize);
				rs = pstmt.executeQuery();
			}
			while(rs.next()) {
				vo = new QnaVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setEmail(rs.getString("email"));
				vo.setContent(rs.getString("content"));
				
				// 날짜를 24시간제로 체크하기 위해 사용자정의메소드로 만든 timeDiff()를 사용한다
				vo.setwDate(rs.getString("wDate")); // 만약 wDate가 날짜타입일 경우
				vo.setwCdate(rs.getString("wDate"));// 날짜타입 wDate를 문자타입 wCdate로 저장 후 
				TimeDiff timeDiff = new TimeDiff(); 
				int res = timeDiff.timeDiff(vo.getwCdate()); 	// 문자타입 wCdate를 timeDiff()메소드 인자값으로 보내서 오늘시간과 계산해서 시간차 리턴받기
				vo.setwNdate(res); 	//시간차를 숫자형식변수에 저장
				
				vo.setReadNum(rs.getInt("readNum"));
				vo.setMid(rs.getString("mid"));
				vo.setSecret(rs.getString("secret"));
				
				vo.setReplyCount(rs.getInt("replyCount"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	// 검색창에 입력된 내용을 포함한 레코드 수 구하기
		public int totRecCnt(String search, String searchString) {
			int totRecCnt = 0;
			try {
				sql = "select count(*) from board_qna where "+search+" like ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%"+searchString+"%");
				rs = pstmt.executeQuery();
				rs.next();
				totRecCnt = rs.getInt(1);
			} catch (SQLException e) {
				System.out.println("SQL 에러 : " + e.getMessage());
			} finally {
				getConn.rsClose();
			}
			return totRecCnt;
		}

		// 검색 처리 부분
		public List<QnaVO> getBoardSearch(String search, String searchString, int startIndexNo, int pageSize) {
			List<QnaVO> vos = new ArrayList<QnaVO>();
			try {
				sql = "select * from board_qna where "+search+" like ? order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%"+searchString+"%");
				pstmt.setInt(2, startIndexNo);
				pstmt.setInt(3, pageSize);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					vo = new QnaVO();
					vo.setIdx(rs.getInt("idx"));
					vo.setNickName(rs.getString("nickName"));
					vo.setTitle(rs.getString("title"));
					vo.setEmail(rs.getString("email"));
					vo.setContent(rs.getString("content"));
					
					// 날짜를 24시간제로 체크하기 위해 사용자정의메소드로 만든 timeDiff()를 사용한다
					vo.setwDate(rs.getString("wDate")); // 만약 wDate가 날짜타입일 경우
					vo.setwCdate(rs.getString("wDate"));// 날짜타입 wDate를 문자타입 wCdate로 저장 후 
					TimeDiff timeDiff = new TimeDiff(); 
					int res = timeDiff.timeDiff(vo.getwCdate()); 	// 문자타입 wCdate를 timeDiff()메소드 인자값으로 보내서 오늘시간과 계산해서 시간차 리턴받기
					vo.setwNdate(res); 	//시간차를 숫자형식변수에 저장
					
					vo.setReadNum(rs.getInt("readNum"));
					vo.setMid(rs.getString("mid"));
					vo.setSecret(rs.getString("secret"));
					
					vos.add(vo);
				}
			} catch (SQLException e) {
				System.out.println("SQL 에러 : " + e.getMessage());
			} finally {
				getConn.rsClose();
			}
			return vos;
		}

		// 문의 글 보기
		public QnaVO getQnaContent(int idx) {
			vo = new QnaVO();
			try {
				sql="select * from board_qna where idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					vo.setIdx(idx);
					vo.setNickName(rs.getString("nickName"));
					vo.setTitle(rs.getString("title"));
					vo.setEmail(rs.getString("email"));
					vo.setContent(rs.getString("content"));
					vo.setwDate(rs.getString("wDate")); 
					vo.setMid(rs.getString("mid"));
					vo.setSecret(rs.getString("secret"));
					vo.setReadNum(rs.getInt("readNum"));
				}
			} catch (SQLException e) {
				System.out.println("SQL 에러 : " + e.getMessage());
			} finally {
				getConn.rsClose();
			}
			return vo;
		}

		// 이전&다음글 
		public QnaVO preNextSearch(String str, int idx) {
			vo = new QnaVO();
			try {
				if(str.equals("pre")) {
					sql="select * from board_qna where idx < ? order by idx desc limit 1";
				}
				else {
					sql="select * from board_qna where idx > ? limit 1";
				}
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				rs = pstmt.executeQuery();
				
				//이전글 있을 때
				if(str.equals("pre") && rs.next()) {
					vo.setPreIdx(rs.getInt("idx"));
					vo.setPreTitle(rs.getString("title"));
				}
				else if(str.equals("next") && rs.next()) {
					vo.setNextIdx(rs.getInt("idx"));
					vo.setNextTitle(rs.getString("title"));
				}
				else {
					vo.setPreIdx(0);
					vo.setNextIdx(0);
				}
				
			} catch (SQLException e) {
				System.out.println("SQL 에러 : " + e.getMessage());
			} finally {
				getConn.rsClose();
			}
			return vo;
		}

		// 조회수 1 증가처리
		public void setReadNum(int idx) {
			try {
				sql="update board_qna set readNum = readNum + 1 where idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("SQL 에러 : " + e.getMessage());
			} finally {
				getConn.pstmtClose();
			}
		}

		//문의 삭제
		public int qnaDelete(int idx) {
			int res = 0;
			try {
				sql="delete from board_qna where idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				pstmt.executeUpdate();
				res = 1;
			} catch (SQLException e) {
				System.out.println("SQL 에러 : " + e.getMessage());
			} finally {
				getConn.pstmtClose();
			}
			return res;
		}

		//댓글 입력처리
		public void QnaReplyInput(QnaReplyVO vo) {
			System.out.println(vo);
			try {
				sql="insert into qnaReply values (default, ?, ?, ?, default, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, vo.getQnaIdx());
				pstmt.setString(2, vo.getMid());
				pstmt.setString(3, vo.getNickName());
				pstmt.setString(4, vo.getContent());
				pstmt.executeUpdate();
			} catch (Exception e) {
				System.out.println("SQL 에러 : " + e.getMessage());
			}
			finally {
				getConn.pstmtClose();
			}
		}

		//댓글 가져오기
		public List<QnaReplyVO> getReplyQna(int idx) {
			List<QnaReplyVO> replyQnaVOS = new ArrayList<QnaReplyVO>();
			try {
				sql="select * from qnaReply where qnaIdx = ? order by idx desc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					qnaReplyVO = new QnaReplyVO();
					
					qnaReplyVO.setIdx(rs.getInt("idx"));
					qnaReplyVO.setQnaIdx(idx);
					qnaReplyVO.setMid(rs.getString("mid"));
					qnaReplyVO.setNickName(rs.getString("nickName"));
					qnaReplyVO.setwDate(rs.getString("wDate"));
					qnaReplyVO.setContent(rs.getString("content"));
					
					replyQnaVOS.add(qnaReplyVO);
				}
			} catch (SQLException e) {
				System.out.println("SQL 에러 : " + e.getMessage());
			} finally {
				getConn.rsClose();
			}
			return replyQnaVOS;
		}

		//문의사항 수정하기
		public int qnaEditOk(QnaVO vo) {
			int res = 0;
			try {
				sql="update board_qna set title=?, content=? where idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, vo.getTitle());
				pstmt.setString(2, vo.getContent());
				pstmt.setInt(3, vo.getIdx());
				pstmt.executeUpdate();
				res=1;
				
			} catch (SQLException e) {
				System.out.println("SQL 에러 : " + e.getMessage());
			} finally {
				getConn.pstmtClose();
			}
			return res;
		}

		//댓글 삭제처리
		public void setReplyDelete(int idx) {
			try {
				sql = "delete from qnaReply where idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("SQL 에러 : " + e.getMessage());
			} finally {
				getConn.pstmtClose();
			}
		}

		// 댓글 수정하기 눌렀을 때 댓글 보여주기
		public String getReply(int idx) {
			String replyContent = "";
			try {
				sql="select content from qnaReply where idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				rs = pstmt.executeQuery();
				
				rs.next();
				replyContent = rs.getString(1);
			} catch (SQLException e) {
				System.out.println("SQL 에러 : " + e.getMessage());
			} finally {
				getConn.rsClose();
			}
			return replyContent;
		}

		//댓글 수정처리
		public void QnaReplyUpdateOk(int idx, String content) {
			try {
				sql = "update qnaReply set content = ?, wDate = now() where idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, content);
				pstmt.setInt(2, idx);
				pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("SQL 에러 : " + e.getMessage());
			} finally {
				getConn.pstmtClose();
			}
		}
		
		
}
