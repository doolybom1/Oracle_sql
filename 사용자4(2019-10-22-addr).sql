SELECT * FROM tbl_books;

/*
주소록 테이블

임의의ID값을 PK설정 NUMBER
이름 nVARCHAR2(50)
전화번호 nVARCHAR2(20)
주소 nVARCHAR2(120)
관계 이름 nVARCHAR2(10)
*/

CREATE TABLE tbl_addr (
    id NUMBER PRIMARY KEY,
    name NVARCHAR2(50) NOT NULL,
    tel VARCHAR2(20),
    addr NVARCHAR2(125),
    chain NVARCHAR2(10)
);
CREATE SEQUENCE SEQ_ADDR
START WITH 1 INCREMENT BY 1;

INSERT INTO tbl_addr(id, name, tel, addr, chain)
VALUES(1,'홍길동','010-111-1111','광주광역시','친구');

INSERT INTO tbl_addr(id, name, tel, addr, chain)
VALUES(2,'장길산','010-111-2222','서울특별시','친구');

INSERT INTO tbl_addr(id, name, tel, addr, chain)
VALUES(3,'임꺽정','010-111-3333','미쿡','친구');

INSERT INTO tbl_addr(id, name, tel, addr, chain)
VALUES(4,'전지현','010-111-4444','미쿡','엄마');

INSERT INTO tbl_addr(id, name, tel, addr, chain)
VALUES(5,'장도현','010-111-4444','미쿡','누나');

COMMIT;
drop table tbl_addr;
SELECT * FROM tbl_addr;