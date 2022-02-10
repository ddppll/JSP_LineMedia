show tables;
create table board_apply(
	idx int not null auto_increment, 	 /* 게시글 고유번호 */
	nickName varchar(20) not null,		 /* 게시글 올린이 닉네임 */
	company varchar(20) not null,		 /* 업체명/담당자명 */
	title varchar(100) not null,		 /* 게시글 제목 */
	email varchar(50),					 /* 게시글 올린이 이메일 */
	tel varchar(15),					/* 연락처 */
	category varchar(50),				 /* 관심 번역 서비스 */
	sourceLang varchar(50),				 /* 출발언어 */
	targetLang varchar(50),				 /* 도착언어 */
	content text not null,				 /* 문의 내용 */
	wDate datetime not null default now(), /* 작성 날짜(기본값 : 현재 날짜/시간)*/
	readNum int default 0,				 /* 조회수 */
	mid	varchar(20) not null,			 /* 회원 아이디(게시글 조회시 사용) */
	primary key(idx)					 /* 기본키 : 글 고유번호 */
);

desc board_apply;
select * from board_apply;
select count(*) from board_apply where mid = 'abc1234' order by idx desc;
select count(*) from board_apply where date_sub(now(), interval 1 day) < wDate and mid='abc1234';
select count(*) from board_apply where date_sub(now(), interval 1 day) < wDate and mid='abc1234' order by idx desc limit 0,5
select * from board_apply where mid='abc1111' order by idx desc limit 0,5 ;
/*drop table board_apply;*/