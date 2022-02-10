package board_qna;

public class QnaVO {
	public int idx;
	public String nickName;
	public String title;
	public String email;
	public String tel;
	public String content;
	public String wDate;
	public int readNum;
	public String mid;
	public String secret;
	
	//날짜형식필드를 '문자'와 '숫자'로 저장시키기 위한 변수 선언
	private String wCdate;
	private int wNdate;
	
	// 이전글&다음글 처리를 위한 변수
	private int preIdx; // 이전글 idx 가져와서 담을 변수
	private int nextIdx; // 다음글 idx 가져와서 담을 변수
	private String preTitle;
	private String nextTitle;
	
	// 댓글 개수 표시를 위한 변수
	private int replyCount;
	
	
	
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
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
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
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
	public String getSecret() {
		return secret;
	}
	public void setSecret(String secret) {
		this.secret = secret;
	}
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
	@Override
	public String toString() {
		return "QnaVO [idx=" + idx + ", nickName=" + nickName + ", title=" + title + ", email=" + email + ", tel=" + tel
				+ ", content=" + content + ", wDate=" + wDate + ", readNum=" + readNum + ", mid=" + mid + ", secret="
				+ secret + ", wCdate=" + wCdate + ", wNdate=" + wNdate + ", preIdx=" + preIdx + ", nextIdx=" + nextIdx
				+ ", preTitle=" + preTitle + ", nextTitle=" + nextTitle + ", replyCount=" + replyCount + "]";
	}

	
	
	
	
}
