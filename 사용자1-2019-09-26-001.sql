-- USER1 화면입니다
-- TABLE 생성 연습

CREATE TABLE tbl_addr(

    -- 이름, 주소, 전화번호, 나이, 관계
    name VARCHAR2(10), 
    addr VARCHAR2(125), 
    tel VARCHAR2(20), 
    age int, 
    chain VARCHAR2(20)
);
SELECT * FROM tbl_addr;

-- 한개의 데이터를 tbl_addr table에 추가하라
INSERT INTO tbl_addr (name,addr,tel,age,chain)
VALUES('홍길동','서울시','010-111-1111',33,'친구');

UPDATE tbl_addr SET addr = '광주광역시';
DELETE FROM tbl_addr;