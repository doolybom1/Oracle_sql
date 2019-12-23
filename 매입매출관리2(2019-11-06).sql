-- Master Detail Table 관계설정

CREATE TABLE tbl_master(

    m_seq NUMBER PRIMARY KEY,
    m_subject NVARCHAR2(1000) NOT NULL
);

CREATE TABLE tbl_detail(
    d_seq NUMBER PRIMARY KEY,
    d_m_seq NUMBER NOT NULL,
    d_subject NVARCHAR2(1000) NOT NULL,
    d_ok VARCHAR(1) DEFAULT 'N'
);
drop SEQUENCE SEQ_DETAIL;
drop SEQUENCE SEQ_Master;
CREATE SEQUENCE SEQ_MASTER
START WITH 1 INCREMENT BY 1;


CREATE SEQUENCE SEQ_DETAIL
START WITH 1 INCREMENT BY 1;

ALTER TABLE tbl_detail
ADD CONSTRAINT FK_MD
FOREIGN KEY(d_m_seq)
REFERENCES tbl_master(m_seq);

INSERT INTO tbl_master(m_seq,m_subject)
VALUES(SEQ_MASTER.NEXTVAL,'다음중 OSI 7계층 중 가장 하위 계층으로 맞는 것은?');

INSERT INTO tbl_detail(d_seq,d_m_seq,d_subject)
VALUES(SEQ_MASTER.NEXTVAL,1 ,'전송계층'); 

INSERT INTO tbl_detail(d_seq,d_m_seq,d_subject)
VALUES(SEQ_MASTER.NEXTVAL,1 ,'세션계층'); 

INSERT INTO tbl_detail(d_seq,d_m_seq,d_subject, d_ok)
VALUES(SEQ_MASTER.NEXTVAL,1 ,'물리계층','Y'); 

INSERT INTO tbl_detail(d_seq,d_m_seq,d_subject)
VALUES(SEQ_MASTER.NEXTVAL,1 ,'네트워크계층'); 



INSERT INTO tbl_master(m_seq,m_subject)
VALUES(SEQ_MASTER.NEXTVAL,'다음중 사용자의 데이터가 저장되는 메모리는?');

INSERT INTO tbl_detail(d_seq,d_m_seq,d_subject)
VALUES(SEQ_MASTER.NEXTVAL,16 ,'ROM'); 

INSERT INTO tbl_detail(d_seq,d_m_seq,d_subject, d_ok)
VALUES(SEQ_MASTER.NEXTVAL,16 ,'RAM','Y'); 

INSERT INTO tbl_detail(d_seq,d_m_seq,d_subject)
VALUES(SEQ_MASTER.NEXTVAL,16 ,'CACHE'); 

INSERT INTO tbl_detail(d_seq,d_m_seq,d_subject)
VALUES(SEQ_MASTER.NEXTVAL,16 ,'RESISTER'); 

delete from tbl_master
where m_subject = '다음중 사용자의 데이터가 저장되는 메모리는?';



commit;

select * from tbl_master;



SELECT MAX(m_seq) FROM tbl_master;





SELECT * FROM tbl_master,tbl_detail
WHERE m_seq = d_m_seq;


rollback;

drop table tbl_detail;
drop table tbl_master;

commit;