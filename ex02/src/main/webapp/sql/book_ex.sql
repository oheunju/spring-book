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