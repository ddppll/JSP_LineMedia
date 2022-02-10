package board_pds;

public class PdsVO {
	private int idx;
	private String mid;
	private String email;
	private String company;
	private String fName;
	private String fSName;
	private int fSize;
	private String fDate;
	private String tel;
	
	//날짜형식필드를 '문자'와 '숫자'로 저장시키기 위한 변수 선언
	private String wCdate;
	private int wNdate;
	
	
	public String getwCdate() {
		return wCdate;
	}
	public void setwCdate(String wCdate) {
		this.wCdate = wCdate;
	}
	public int getwNdate() {
		return wNdate;
	}
	public void setwNdate(int wNdate) {
		this.wNdate = wNdate;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getfName() {
		return fName;
	}
	public void setfName(String fName) {
		this.fName = fName;
	}
	public String getfSName() {
		return fSName;
	}
	public void setfSName(String fSName) {
		this.fSName = fSName;
	}
	public int getfSize() {
		return fSize;
	}
	public void setfSize(int fSize) {
		this.fSize = fSize;
	}
	public String getfDate() {
		return fDate;
	}
	public void setfDate(String fDate) {
		this.fDate = fDate;
	}
	@Override
	public String toString() {
		return "PdsVO [idx=" + idx + ", mid=" + mid + ", email=" + email + ", company=" + company + ", fName=" + fName
				+ ", fSName=" + fSName + ", fSize=" + fSize + ", fDate=" + fDate + ", tel=" + tel + ", wCdate=" + wCdate
				+ ", wNdate=" + wNdate + "]";
	}
	
	
	
	
}
