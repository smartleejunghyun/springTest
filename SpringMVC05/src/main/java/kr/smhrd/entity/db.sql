create table tblBoard(
idx int not null auto_increment,
memId varchar(30) not null,
title varchar(100) not null,
content varchar(2000) not null,
writer varchar(30) not null,
indate datetime default now(),
count int default 0,

primary key(idx)
);
drop table tblboard;

insert into tblBoard(title, content, writer)
values('게시글 1', '게시글 1 내용', '작성자 1');

insert into tblBoard(title, content, writer)
values('게시글 2', '게시글 2 내용', '작성자 2');

insert into tblBoard(title, content, writer)
values('게시글 3', '게시글 3 내용', '작성자 3');

select * from tblBoard;

delete from tblboard where title = null;

commit;

create table tblMember(
memId varchar(30) not null,
memPwd varchar(30) not null,
memName varchar(30) not null,
primary key(memId)
);

select * from tblMember;


insert into tblMember(memId, memPwd, memName)
values('smhrd01', 'smhrd01', '관리자');

insert into tblMember(memId, memPwd, memName)
values('smhrd02', 'smhrd02', '홍길동');

insert into tblMember(memId, memPwd, memName)
values('smhrd03', 'smhrd03', '이정현');

alter table tblBoard add memId varchar(30) not null;


create table tblReply(
idx int not null auto_increment,
memId varchar(30) not null,
title varchar(100) not null,
content varchar(2000) not null,
writer varchar(30) not null,
indate datetime default now(),
count int default 0,
bgroup int,
bseq int,
blevel int,
bdelete int,
primary key(idx)
);

select IFNULL(max(bgroup)+1, 0) from tblReply; -- 기본 값은 NULL

insert into tblReply(title, content, writer, memId, bgroup, bseq, blevel, bdelete)  values(#{title}, #{content}, #{writer}, #{memId}, IFNULL(select max(bgroup) from tblBoard)), 0, 0, 1)

select * from tblReply;

update tblReply set bgroup = bgroup+1 where bgroup>0;


