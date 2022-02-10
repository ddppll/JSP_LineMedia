package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conn.GetConn;

public class MemberDAO {
	GetConn getConn = GetConn.getInstance();
	
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	MemberVO vo = null;

	//아이디 중복체크
	public String idCheck(String mid) {
		String name = "";
		try {
			sql = "select * from member where mid =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			if(rs.next()) name = rs.getString("nickName");
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return name;
	}

	// 닉네임 중복체크
	public String nickCheck(String nickName) {
		String name = "";
		try {
			sql = "select * from member where nickName =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nickName);
			rs = pstmt.executeQuery();
			if(rs.next()) name = rs.getString("nickName");
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return name;
	}

	// 해시테이블에서 pwdKey에 해당하는 pwdValue을 찾아서 리턴
		public long getHashTableSearch(int pwdKey) {
			long pwdValue = 0;
			try {
				sql = "select*from hashTable where pwdKey = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pwdKey);
				rs = pstmt.executeQuery();
				rs.next();
				pwdValue = rs.getLong("pwdValue");
			} catch (SQLException e) {
				System.out.println("SQL 오류 : " + e.getMessage());
			} finally {
				getConn.rsClose();
			}
			return pwdValue;
		}

		
		//회원가입
		public int setMemberJoinOk(MemberVO vo) {
			int res = 0;
			try {
				sql = "insert into member values(default,?,?,?,?,?,default, default, default, default, default, default)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, vo.getMid());
				pstmt.setString(2, vo.getPwd());
				pstmt.setString(3, vo.getNickName());
				pstmt.setString(4, vo.getTel());
				pstmt.setString(5, vo.getEmail());
				pstmt.executeUpdate();
				res = 1;
			} catch (Exception e) {
				System.out.println("SQL 오류 : " + e.getMessage());
			} finally {
				getConn.pstmtClose();
			}
			return res;
		}

		// 로그인 체크(아이디가 동일한 자료가 있으면 해당 자료를 vo에 담아서 넘긴다)
		public MemberVO loginCheck(String mid) {
			vo = new MemberVO();
			sql = "select * from member where mid = ? and userDel = 'NO'";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, mid);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					vo.setMid(mid);
					vo.setPwd(rs.getString("pwd"));
					vo.setNickName(rs.getString("nickName"));
					vo.setTel(rs.getString("tel"));
					vo.setEmail(rs.getString("email"));
					vo.setLevel(rs.getInt("level"));
					vo.setLastDate(rs.getString("lastDate"));
					if(rs.getString("email")==null) {
						vo.setEmail(" ");
					}
				}
				else {
					vo = null;
				}
				
			} catch (SQLException e) {
				System.out.println("SQL 오류 : " + e.getMessage());
			} finally {
				getConn.rsClose();
			}
			return vo;
		}

		//회원 정보 수정
		public int setMemberUpdateOk(MemberVO vo) {
			int res = 0;
			try {
				sql = "update member set pwd=?, nickName=?, tel=?, email=? where mid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, vo.getPwd());
				pstmt.setString(2, vo.getNickName());
				pstmt.setString(3, vo.getTel());
				pstmt.setString(4, vo.getEmail());
				pstmt.setString(5, vo.getMid());
				pstmt.executeUpdate();
				res = 1;
			} catch (SQLException e) {
				System.out.println("SQL 오류 : " + e.getMessage());
			} finally {
				getConn.pstmtClose();
			}
			return res;
		}

		// 페이징 처리 - 총 회원 수 구하기
		public int totRecCnt(String mid) {
			int totRecCnt = 0;
			try {
				if(mid.equals("")){
					sql = "select count(*) from member";
					pstmt = conn.prepareStatement(sql);
				}
				else {
					sql = "select count(*) from member where mid like ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, "%"+mid+"%"); //아이디 부분일치 검색이니까 like 사용
				}
				rs = pstmt.executeQuery();
				rs.next();
				totRecCnt = rs.getInt(1);
			} catch (SQLException e) {
				System.out.println("SQL 오류 : " + e.getMessage());
			} finally {
				getConn.rsClose();
			}
			return totRecCnt;
		}

		
		//관리자 페이지 - 회원 전체 리스트&검색
		public ArrayList<MemberVO> getAdminMemList(int startIndexNo, int pageSize, String mid) {
			ArrayList<MemberVO> vos = new ArrayList<MemberVO>();
			try {
				if(mid.equals("")) {
					sql="select * from member order by idx desc limit ?,?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, startIndexNo);
					pstmt.setInt(2, pageSize);
				}
				else {
					sql = "select * from member where mid like ? order by idx desc limit ?, ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, "%"+mid+"%");
					pstmt.setInt(2, startIndexNo);
					pstmt.setInt(3, pageSize);
				}
				rs = pstmt.executeQuery();
				while(rs.next()) {
					vo = new MemberVO();
					vo.setIdx(rs.getInt("idx"));
					vo.setMid(rs.getString("mid"));
					vo.setNickName(rs.getString("nickName"));
					vo.setTel(rs.getString("tel"));
					vo.setEmail(rs.getString("email"));
					vo.setUserDel(rs.getString("userDel"));
					vo.setLastDate(rs.getString("lastDate"));
					vo.setLevel(rs.getInt("level"));
					//System.out.println(vo);
					vos.add(vo);
				}
			} catch (SQLException e) {
				System.out.println("SQL 오류 : " + e.getMessage());
			} finally {
				getConn.rsClose();
			}
			return vos;
		}

		// 로그인시 마지막 접속시간 갱신
		public void setLastDateUpdate(String mid) {
			try {
				sql="update member set lastDate = now(), visitCnt = visitCnt+1 where mid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, mid);
				pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("SQL 오류 : " + e.getMessage());
			} finally {
				getConn.pstmtClose();
			}
			
		}

		// 회원 탈퇴 처리(userDel의 값을 'OK'로 변경한다)
		public void memberDelete(String mid) {
			try {
				sql = "update member set userDel = 'OK' where mid =?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, mid);
				pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("SQL 오류 : " + e.getMessage());
			} finally {
				getConn.pstmtClose();
			}
		}

		// 탈퇴 신청한 회원 정보 삭제
		public void adminMemDel(int idx) {
			try {
				sql="delete from member where idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("SQL 오류 : " + e.getMessage());
			} finally {
				getConn.pstmtClose();
			}

		}
}
