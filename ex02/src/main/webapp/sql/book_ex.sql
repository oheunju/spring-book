-----------------------------------
-------------- 게시글 --------------
-----------------------------------
create sequence seq_board;

create table tbl_board
(
    bno number(10,0),
    title varchar2(200) not null,
    content varchar2(2000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    updatedate date default sysdate
);
alter table tbl_board add constraint pk_board primary key (bno);

-- 댓글 수 추가
alter table tbl_board add (replycnt number default 0);
update tbl_board set replycnt = (select count(rno) from tbl_reply where tbl_reply.bno = tbl_board.bno);


insert into tbl_board (bno, title, content, writer)
select seq_board.nextval, title, content, writer from tbl_board;

select * from tbl_board;
commit;

---------------------------------
-------------- 댓글 --------------
---------------------------------
create table tbl_reply
(
    rno number(10,0),
    bno number(10,0) not null,
    reply varchar2(1000) not null,
    replyer varchar2(50) not null,
    replyDate date default sysdate,
    updateDate date default sysdate
);
alter table tbl_reply add constraint pk_reply primary key (rno);
alter table tbl_reply add constraint fk_reply_board foreign key (bno) references tbl_board (bno);

create sequence seq_reply;

-- 댓글 페이징 인덱스 설계
create index idx_reply on tbl_reply (bno desc, rno asc);




select * from tbl_reply;
commit;

----------------------------
----- transaction test -----
----------------------------

create table tbl_sample1 (col1 varchar2(500));
create table tbl_sample2 (col2 varchar2(50));

select * from tbl_sample1;
select * from tbl_sample2;

delete tbl_sample1;
commit;

-----------------------------
---------- 첨부파일 ----------
-----------------------------
create table tbl_attach
(
    uuid varchar2(100) not null,
    uploadPath varchar2(200) not null,
    fileName varchar2(100) not null,
    filetype char(1) default 'I',
    bno number(10,0)
);
alter table tbl_attach add constraint pk_attach primary key (uuid);
alter table tbl_attach add constraint fk_board_attach foreign key(bno) references tbl_board(bno);

select * from tbl_attach;

-----------------------------
----- 간편 인증/권한 처리------
-----------------------------
-- 지정된 SQL
create table users
(
    username varchar2(50) not null primary key,
    password varchar2(50) not null,
    enabled char(1) default '1'
);

create table authorities
(
    username varchar2(50) not null,
    authority varchar2(50) not null,
    constraint fk_authorities_users foreign key(username) references users(username)
);

create unique index ix_auth_username on authorities (username, authority);

insert into users (username, password) values ('user00', 'pw00');
insert into users (username, password) values ('member00', 'pw00');
insert into users (username, password) values ('admin00', 'pw00');

insert into authorities (username, authority) values ('user00', 'ROLE_USER');
insert into authorities (username, authority) values ('member00', 'ROLE_MANAGER');
insert into authorities (username, authority) values ('admin00', 'ROLE_MANAGER');
insert into authorities (username, authority) values ('admin00', 'ROLE_ADMIN');

commit;

select * from users;
select * from authorities;

-- 커스텀
create table tbl_member
(
    userid varchar2(50) not null primary key,
    userpw varchar2(100) not null,
    username varchar2(100) not null,
    regdate date default sysdate,
    updatedate date default sysdate,
    enabled char(1) default '1'
);

create table tbl_member_auth
(
    userid varchar2(50) not null,
    auth varchar2(50) not null,
    constraint fk_member_auth foreign key(userid) references tbl_member(userid)
);

select * from tbl_member;
select * from tbl_member_auth;


--- remember-me 기능
--- 지정된 형식의 테이블
create table persistent_logins
(
    username varchar(64) not null,
    series varchar(64) primary key,
    token varchar(64) not null,
    last_used timestamp not null
);