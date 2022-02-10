package board_pds;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conn.GetConn;
import conn.TimeDiff;

public class PdsDAO {
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	PdsVO vo = null;

	// 자료실 업로드 파일 DB에 저장하기
		public int pdsInput(PdsVO vo) {
			int res = 0;
			try {
				sql = "insert into pds values (default,?,?,?,?,?,?,?,default)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, vo.getMid());
				pstmt.setString(2, vo.getCompany());
				pstmt.setString(3, vo.getTel());
				pstmt.setString(4, vo.getEmail());
				pstmt.setString(5, vo.getfName());
				pstmt.setString(6, vo.getfSName());
				pstmt.setInt(7, vo.getfSize());
				pstmt.executeUpdate();
				res = 1;
			} catch (SQLException e) {
				System.out.println("SQL 에러 : " + e.getMessage());
			}finally {
				getConn.pstmtClose();
			}
			return res;
		}

		//전체 레코드 건수 구하기
		public int totRecCnt() {
			int totRecCnt = 0;
			try {
				sql = "select count(*) from pds";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				rs.next();
				totRecCnt = rs.getInt(1);
			} catch (SQLException e) {
				System.out.println("SQL 에러 : " + e.getMessage());
			}finally {
				getConn.rsClose();
			}
			return totRecCnt;
		}

		public List<PdsVO> getPdsList(int startIndexNo, int pageSize) {
			List<PdsVO> vos = new ArrayList<PdsVO>();
			try {
					sql = "select * from pds order by idx desc limit ?,?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, startIndexNo);
					pstmt.setInt(2, pageSize);
					rs = pstmt.executeQuery();
				
				while(rs.next()) {
					vo = new PdsVO();
					
					vo.setIdx(rs.getInt("idx"));
					vo.setMid(rs.getString("mid"));
					vo.setCompany(rs.getString("company"));
					vo.setTel(rs.getString("tel"));
					vo.setEmail(rs.getString("email"));
					vo.setfName(rs.getString("fName"));
					vo.setfSName(rs.getString("fSName"));
					vo.setfSize(rs.getInt("fSize"));
					//vo.setfDate(rs.getString("fDate"));
					// 날짜를 24시간제로 체크하기 위해 사용자정의메소드로 만든 timeDiff()를 사용한다
					vo.setfDate(rs.getString("fDate")); 
					vo.setwCdate(rs.getString("fDate")); 
					TimeDiff timeDiff = new TimeDiff(); 
					int res = timeDiff.timeDiff(vo.getwCdate()); 	// 문자타입 wCdate를 timeDiff()메소드 인자값으로 보내서 오늘시간과 계산해서 시간차 리턴받기
					vo.setwNdate(res); 	//시간차를 숫자형식변수에 저장
					
					vos.add(vo);
				}
			} catch (SQLException e) {
				System.out.println("SQL 에러 : " + e.getMessage());
			}finally {
				getConn.rsClose();
			}
			return vos;
	}

		public PdsVO getPdsContent(int idx) {
			try {
				sql = "select * from pds where idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					vo = new PdsVO();
					
					vo.setIdx(rs.getInt("idx"));
					vo.setMid(rs.getString("mid"));
					vo.setCompany(rs.getString("company"));
					vo.setTel(rs.getString("tel"));
					vo.setEmail(rs.getString("email"));
					vo.setfName(rs.getString("fName"));
					vo.setfSName(rs.getString("fSName"));
					vo.setfSize(rs.getInt("fSize"));
					vo.setfDate(rs.getString("fDate")); 
					vo.setwCdate(rs.getString("fDate")); 
					TimeDiff timeDiff = new TimeDiff(); 
					int res = timeDiff.timeDiff(vo.getwCdate()); 	
					vo.setwNdate(res); 	
				}
			} catch (SQLException e) {
				System.out.println("SQL 에러 : " + e.getMessage());
			}finally {
				getConn.rsClose();
			}
			return vo;
		}

		public int pdsDelete(int idx) {
			int res = 0;
			try {
				sql="delete from pds where idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				pstmt.executeUpdate();
				res= 1;
			} catch (SQLException e) {
				System.out.println("SQL 에러 : " + e.getMessage());
			}finally {
				getConn.pstmtClose();
			}
			return res;
		}
		
		

}
