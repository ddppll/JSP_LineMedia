package board_apply;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import board_qna.QnaVO;
import conn.GetConn;
import conn.TimeDiff;
import member.MemberVO;

public class ApplyDAO {
	
	GetConn getConn = GetConn.getInstance();
	
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	ApplyVO vo = null;

	// 견적 의뢰 등록
	public int applyInput(ApplyVO vo) {
		int res = 0;
		try {
			sql = "insert into board_apply values (default,?,?,?,?,?,?,?,?,?,default,default,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getNickName());
			pstmt.setString(2, vo.getCompany());
			pstmt.setString(3, vo.getTitle());
			pstmt.setString(4, vo.getEmail());
			pstmt.setString(5, vo.getTel());
			pstmt.setString(6, vo.getCategory());
			pstmt.setString(7, vo.getSourceLang());
			pstmt.setString(8, vo.getTargetLang());
			pstmt.setString(9, vo.getContent());
			pstmt.setString(10, vo.getMid());
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	//게시글 총 건수
	public int totRecCnt(String mid) {
		int totRecCnt = 0;
		try {
			sql = "select count(*) from board_apply where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
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
	public int totRecCntLately(int lately, String mid) {
		int totRecCnt = 0;
		try {
			sql = "select count(*) from board_apply where date_sub(now(), interval ? day) < wDate and mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, lately);
			pstmt.setString(2, mid);
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

	// 견적 목록 보기
	public List<ApplyVO> getApplyList(int startIndexNo, int pageSize, int lately, String mid) {
		List<ApplyVO> vos = new ArrayList<ApplyVO>();
		try {
			if(lately == 0) {//자료검색
				sql = "select * from board_apply where mid=? order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, mid);
				pstmt.setInt(2, startIndexNo);
				pstmt.setInt(3, pageSize);
				rs = pstmt.executeQuery();
			}
			else { //최근 게시글 보기
				sql="select * from board_apply where date_sub(now(), interval ? day) < wDate and mid=? order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, lately);
				pstmt.setString(2, mid);
				pstmt.setInt(3, startIndexNo);
				pstmt.setInt(4, pageSize);
				rs = pstmt.executeQuery();
			}
			while(rs.next()) {
				vo = new ApplyVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setNickName(rs.getString("nickName"));
				vo.setCompany(rs.getString("company"));
				vo.setTitle(rs.getString("title"));
				vo.setEmail(rs.getString("email"));
				vo.setTel(rs.getString("tel"));
				vo.setCategory(rs.getString("category"));
				vo.setSourceLang(rs.getString("sourceLang"));
				vo.setTargetLang(rs.getString("targetLang"));
				vo.setContent(rs.getString("content"));
				
				// 날짜를 24시간제로 체크하기 위해 사용자정의메소드로 만든 timeDiff()를 사용한다
				vo.setwDate(rs.getString("wDate")); // 만약 wDate가 날짜타입일 경우
				vo.setwCdate(rs.getString("wDate"));// 날짜타입 wDate를 문자타입 wCdate로 저장 후 
				TimeDiff timeDiff = new TimeDiff(); 
				int res = timeDiff.timeDiff(vo.getwCdate()); 	// 문자타입 wCdate를 timeDiff()메소드 인자값으로 보내서 오늘시간과 계산해서 시간차 리턴받기
				vo.setwNdate(res); 	//시간차를 숫자형식변수에 저장
				
				vo.setReadNum(rs.getInt("readNum"));
				vo.setMid(rs.getString("mid"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	// 견적 내용 보기
	public ApplyVO getApplyContent(int idx) {
		vo = new ApplyVO();
		try {
			sql="select * from board_apply where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setIdx(idx);
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setEmail(rs.getString("email"));
				vo.setTel(rs.getString("tel"));
				vo.setCompany(rs.getString("company"));
				vo.setContent(rs.getString("content"));
				vo.setwDate(rs.getString("wDate")); 
				vo.setMid(rs.getString("mid"));
				vo.setSourceLang(rs.getString("sourceLang"));
				vo.setTargetLang(rs.getString("targetLang"));
				vo.setCategory(rs.getString("category"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;

	
	
	}

	//이전&다음글
	public ApplyVO preNextSearch(String str, int idx, String mid) {
		vo = new ApplyVO();
		try {
			if(str.equals("pre")) {
				sql="select * from board_apply where idx < ? and mid=? order by idx desc limit 1";
			}
			else {
				sql="select * from board_apply where idx > ? and mid=? limit 1";
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setString(2, mid);
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

	// 검색창에 입력된 내용을 포함한 레코드 수 구하기
	public int totRecCnt(String search, String searchString, String mid) {
		int totRecCnt = 0;
		try {
			sql = "select count(*) from board_apply where mid=? and "+search+" like ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, "%"+searchString+"%");
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

	//검색 처리
	public List<ApplyVO> getApplySearch(String search, String searchString, int startIndexNo, int pageSize, String mid) {
		List<ApplyVO> vos = new ArrayList<ApplyVO>();
		try {
			sql="select * from board_apply where mid=? and "+search+" like ? order by idx desc limit ?,?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, "%"+searchString+"%");
			pstmt.setInt(3, startIndexNo);
			pstmt.setInt(4, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new ApplyVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setNickName(rs.getString("nickName"));
				vo.setCompany(rs.getString("company"));
				vo.setTitle(rs.getString("title"));
				vo.setEmail(rs.getString("email"));
				vo.setTel(rs.getString("tel"));
				vo.setCategory(rs.getString("category"));
				vo.setSourceLang(rs.getString("sourceLang"));
				vo.setTargetLang(rs.getString("targetLang"));
				vo.setContent(rs.getString("content"));
				
				// 날짜를 24시간제로 체크하기 위해 사용자정의메소드로 만든 timeDiff()를 사용한다
				vo.setwDate(rs.getString("wDate")); // 만약 wDate가 날짜타입일 경우
				vo.setwCdate(rs.getString("wDate"));// 날짜타입 wDate를 문자타입 wCdate로 저장 후 
				TimeDiff timeDiff = new TimeDiff(); 
				int res = timeDiff.timeDiff(vo.getwCdate()); 	// 문자타입 wCdate를 timeDiff()메소드 인자값으로 보내서 오늘시간과 계산해서 시간차 리턴받기
				vo.setwNdate(res); 	//시간차를 숫자형식변수에 저장
				
				vo.setReadNum(rs.getInt("readNum"));
				vo.setMid(rs.getString("mid"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	//관리자페이지 견적 목록 보기
	public List<ApplyVO> getApplyList(int startIndexNo, int pageSize, int lately) {
		List<ApplyVO> vos = new ArrayList<ApplyVO>();
		try {
			if(lately == 0) {//자료검색
				sql = "select * from board_apply order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
				rs = pstmt.executeQuery();
			}
			else { //최근 게시글 보기
				sql="select * from board_apply where date_sub(now(), interval ? day) < wDate order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, lately);
				pstmt.setInt(2, startIndexNo);
				pstmt.setInt(3, pageSize);
				rs = pstmt.executeQuery();
			}
			while(rs.next()) {
				vo = new ApplyVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setNickName(rs.getString("nickName"));
				vo.setCompany(rs.getString("company"));
				vo.setTitle(rs.getString("title"));
				vo.setEmail(rs.getString("email"));
				vo.setTel(rs.getString("tel"));
				vo.setCategory(rs.getString("category"));
				vo.setSourceLang(rs.getString("sourceLang"));
				vo.setTargetLang(rs.getString("targetLang"));
				vo.setContent(rs.getString("content"));
				
				// 날짜를 24시간제로 체크하기 위해 사용자정의메소드로 만든 timeDiff()를 사용한다
				vo.setwDate(rs.getString("wDate")); // 만약 wDate가 날짜타입일 경우
				vo.setwCdate(rs.getString("wDate"));// 날짜타입 wDate를 문자타입 wCdate로 저장 후 
				TimeDiff timeDiff = new TimeDiff(); 
				int res = timeDiff.timeDiff(vo.getwCdate()); 	// 문자타입 wCdate를 timeDiff()메소드 인자값으로 보내서 오늘시간과 계산해서 시간차 리턴받기
				vo.setwNdate(res); 	//시간차를 숫자형식변수에 저장
				
				vo.setReadNum(rs.getInt("readNum"));
				vo.setMid(rs.getString("mid"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	// 관리자페이지- 견적 게시글의 총 건수 구해오기
	public int totRecCnt() {
		int totRecCnt = 0;
		try {
			sql = "select count(*) from board_apply";
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

	//관리자 견적 게시판 - 최근글 개수 가져오기
	public int totRecCntLately(int lately) {
		int totRecCnt = 0;
		try {
			sql = "select count(*) from board_apply where date_sub(now(), interval ? day) < wDate";
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

	//관리자 견적 게시판 - 이전&다음글
	public ApplyVO preNextSearch(String str, int idx) {
		vo = new ApplyVO();
		try {
			if(str.equals("pre")) {
				sql="select * from board_apply where idx < ? order by idx desc limit 1";
			}
			else {
				sql="select * from board_apply where idx > ? limit 1";
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

	//견적 문의 삭제
	public int applyDelete(int idx) {
		int res = 0;
		try {
			sql="delete from board_apply where idx = ?";
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

	
	// 관리자 페이지 - 검색창에 입력된 내용을 포함한 레코드 수 구하기
		public int totRecCnt(String search, String searchString) {
			int totRecCnt = 0;
			try {
				sql = "select count(*) from board_apply where "+search+" like ?";
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

		public List<ApplyVO> getApplySearch(String search, String searchString, int startIndexNo, int pageSize) {
			List<ApplyVO> vos = new ArrayList<ApplyVO>();
			try {
				sql="select * from board_apply where "+search+" like ? order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%"+searchString+"%");
				pstmt.setInt(2, startIndexNo);
				pstmt.setInt(3, pageSize);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					vo = new ApplyVO();
					vo.setIdx(rs.getInt("idx"));
					vo.setNickName(rs.getString("nickName"));
					vo.setCompany(rs.getString("company"));
					vo.setTitle(rs.getString("title"));
					vo.setEmail(rs.getString("email"));
					vo.setTel(rs.getString("tel"));
					vo.setCategory(rs.getString("category"));
					vo.setSourceLang(rs.getString("sourceLang"));
					vo.setTargetLang(rs.getString("targetLang"));
					vo.setContent(rs.getString("content"));
					
					// 날짜를 24시간제로 체크하기 위해 사용자정의메소드로 만든 timeDiff()를 사용한다
					vo.setwDate(rs.getString("wDate")); // 만약 wDate가 날짜타입일 경우
					vo.setwCdate(rs.getString("wDate"));// 날짜타입 wDate를 문자타입 wCdate로 저장 후 
					TimeDiff timeDiff = new TimeDiff(); 
					int res = timeDiff.timeDiff(vo.getwCdate()); 	// 문자타입 wCdate를 timeDiff()메소드 인자값으로 보내서 오늘시간과 계산해서 시간차 리턴받기
					vo.setwNdate(res); 	//시간차를 숫자형식변수에 저장
					
					vo.setReadNum(rs.getInt("readNum"));
					vo.setMid(rs.getString("mid"));
					
					vos.add(vo);
				}
			} catch (SQLException e) {
				System.out.println("SQL 에러 : " + e.getMessage());
			} finally {
				getConn.rsClose();
			}
			return vos;
		}
}
