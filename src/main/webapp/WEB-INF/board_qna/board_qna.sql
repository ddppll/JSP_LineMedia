show tables;
create table board_qna(
	idx int not null auto_increment, 	 /* 게시글 고유번호 */
	nickName varchar(20) not null,		 /* 게시글 올린이 닉네임 */
	title varchar(100) not null,		 /* 게시글 제목 */
	email varchar(50),					 /* 게시글 올린이 이메일 */
	content text not null,				 /* 문의 내용 */
	wDate datetime not null default now(), /* 작성 날짜(기본값 : 현재 날짜/시간)*/
	readNum int default 0,				 /* 조회수 */
	mid	varchar(20) not null,			 /* 회원 아이디(게시글 조회시 사용) */
	secret char(2) default '0',			 /* 비밀글 여부(0 : 비밀글 / 1 : 전체보기) */
	primary key(idx)					 /* 기본키 : 글 고유번호 */
);

/* drop table board_qna; */
desc board_qna;
select * from board_qna;

select * from board_qna where mid='abc1234' order by idx desc limit 0,5;

select count(*) from board_qna where date_sub(now(), interval 1 day) < wDate order by idx desc limit 0,3;
select count(*) from board_qna where date_sub(now(), interval 1 day) < wDate and mid='abc1234' order by idx desc limit 0,3;

/*-----------------------------------댓글처리---------------------------------*/
create table qnaReply(
	idx int not null auto_increment primary key,	/* 댓글의 고유번호 */
	qnaIdx int not null,			/* 원본글의 고유번호(외래키 지정) */
	mid varchar(20) not null,		/* 올린이의 아이디 */
	nickName varchar(20) not null,	/* 올린이의 닉네임 */
	wDate datetime not null default now(),	/* 댓글 기록 날짜 */
	content text not null,			/* 댓글 내용 */
	foreign key(qnaIdx) references board_qna(idx) on update cascade on delete restrict 
); 

desc qnaReply;
select * from qnaReply order by idx desc;

select count(*) from replyBoard where boardIdx = 34;

drop table qnaReply;