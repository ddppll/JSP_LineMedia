package board_apply;

public class ApplyVO {
	private int idx;
	private String company;
	private String nickName;
	private String title;
	private String email;
	private String category;
	private String sourceLang;
	private String targetLang;
	private String content;
	private String wDate;
	private int readNum;
	private String mid;
	
	private String tel;
	
	//날짜형식필드를 '문자'와 '숫자'로 저장시키기 위한 변수 선언
	private String wCdate;
	private int wNdate;
	
	// 이전글&다음글 처리를 위한 변수
	private int preIdx; // 이전글 idx 가져와서 담을 변수
	private int nextIdx; // 다음글 idx 가져와서 담을 변수
	private String preTitle;
	private String nextTitle;
	
	
	
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
	public int getPreIdx() {
		return preIdx;
	}
	public void setPreIdx(int preIdx) {
		this.preIdx = preIdx;
	}
	public int getNextIdx() {
		return nextIdx;
	}
	public void setNextIdx(int nextIdx) {
		this.nextIdx = nextIdx;
	}
	public String getPreTitle() {
		return preTitle;
	}
	public void setPreTitle(String preTitle) {
		this.preTitle = preTitle;
	}
	public String getNextTitle() {
		return nextTitle;
	}
	public void setNextTitle(String nextTitle) {
		this.nextTitle = nextTitle;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getSourceLang() {
		return sourceLang;
	}
	public void setSourceLang(String sourceLang) {
		this.sourceLang = sourceLang;
	}
	public String getTargetLang() {
		return targetLang;
	}
	public void setTargetLang(String targetLang) {
		this.targetLang = targetLang;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getwDate() {
		return wDate;
	}
	public void setwDate(String wDate) {
		this.wDate = wDate;
	}
	public int getReadNum() {
		return readNum;
	}
	public void setReadNum(int readNum) {
		this.readNum = readNum;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	@Override
	public String toString() {
		return "ApplyVO [idx=" + idx + ", company=" + company + ", nickName=" + nickName + ", title=" + title
				+ ", email=" + email + ", category=" + category + ", sourceLang=" + sourceLang + ", targetLang="
				+ targetLang + ", content=" + content + ", wDate=" + wDate + ", readNum=" + readNum + ", mid=" + mid
				+ ", tel=" + tel + ", wCdate=" + wCdate + ", wNdate=" + wNdate + ", preIdx=" + preIdx + ", nextIdx="
				+ nextIdx + ", preTitle=" + preTitle + ", nextTitle=" + nextTitle + "]";
	}
	
	
}
