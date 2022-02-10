create table pds (
	idx int not null auto_increment,	/* 자료실 고유번호 */
	mid varchar(20) not null,			/* 자료 올린 사람 아이디 */
	company varchar(20) not null,		/* 업체명 */
	tel varchar(15),					/* 연락처 */
	email varchar(30) not null,			/* 올린 사람 이메일 */
	fName varchar(200) not null,		/* 업로드 할 때 파일명(멀티파일이라 이름이 길어짐) */
	fSName varchar(200) not null,		/* 파일서버에 저장되는 실제 파일명 */
	fSize int,							/* 총 파일 사이즈 */
	fDate datetime default now(),		/* 파일 업로드 날짜 */
	primary key (idx)
);

/*drop table pds;*/
desc pds;
select * from pds order by idx desc;