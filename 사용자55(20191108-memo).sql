-- 간단한 메모를 저장하기 위한 테이블 생성
/*
    메모를 작성한 일자
    작성시각
    작성자
    제목
    내용
    중요도
    약속장소
    약속실행여부
*/
CREATE TABLE tbl_memo(
    m_seq NUMBER PRIMARY KEY,
    m_date VARCHAR2(10) NOT NULL, -- 2019-11-08, 한글제외
    m_time VARCHAR2(8) NOT NULL, -- 09:22:00
    m_auth nVARCHAR2(20) NOT NULL,
    m_subject nVARCHAR2(125) NOT NULL,
    m_text nVARCHAR2(1000),
    m_flag nVARCHAR2(1),
    m_field nVARCHAR2(20),
    m_ok VARCHAR2(1)
);

DESC tbl_memo;

INSERT INTO tbl_memo (m_seq,m_date,m_time,m_auth,m_subject)
VALUES(1,'2019-11-08','09:42:00','홍길동','메모작성');

-- INSERT를 수행할때 칼럼을 나열하지 않고 projection을 생략할 수 있다
-- INSERT INTO tbl_memo VALUES(....)
-- 전체 칼럼에 모든 데이터를 다 입력하고 데이터를 추가할때만 가능
-- 만약 프로젝트가 징행되는 과정에서 table의 칼럼 순서 구조가 변경되는 경우
-- 칼럼을 추가하는 경우 보통 table구조에서 끝부분에 칼럼이 추가되는데 이때는
-- 데이터가 순서대로 원하는 칼럼에 저장될 것이다라는 보장을 할 수 없게 된다.



INSERT INTO tbl_memo (m_seq,m_date,m_time,m_auth,m_subject)
VALUES(1,'2019-11-08','09:42:00','홍길동','메모작성');


-- SEQ_MEMO란 시퀀스를 생성하고, 시작값을 1로 설정, 자동으로 1씩 증가되는 값으로 
CREATE SEQUENCE SEQ_MEMO
START WITH 1 INCREMENT BY 1;

--SEQ.NEXTVAL : 메서드와 같은 형식이고
--SELECT, INSERT, UPDATE 명령분내에서 사용이 되면 설정한 옵션에 따라 자동으로 값을 생성해 낸다.
SELECT SEQ_MEMO.NEXTVAL FROM DUAL;


INSERT INTO tbl_memo (m_seq,m_date,m_time,m_auth,m_subject)
VALUES(SEQ_MEMO.NEXTVAL,'2019-11-08','09:42:00','홍길동','메모작성');

SELECT * FROM tbl_memo
WHERE m_seq = 6;

UPDATE tbl_memo SET m_auth = '성춘향'
WHERE m_seq = 6;


DELETE FROM tbl_memo
WHERE m_seq = 6;

SELECT * FROM tbl_memo;

CREATE TABLE tbl_iolist(
 io_seq	NUMBER		PRIMARY KEY,
io_date	VARCHAR2(10)	NOT NULL,	
io_pname	NVARCHAR2(25)	NOT NULL	,
io_dname	NVARCHAR2(25)		,
io_dceo	NVARCHAR2(25)		,
io_input	NVARCHAR2(2)	,	
io_qty	NUMBER		,
io_price	NUMBER	,	
io_total	NUMBER		

);

CREATE TABLE tbl_product(
p_code	VARCHAR2(5)		PRIMARY KEY,
p_name	NVARCHAR2(50)	NOT NULL	,
p_iprice	NUMBER		,
p_oprice	NUMBER		,
p_vat	VARCHAR2(1)		

);

CREATE TABLE tbl_dept(
d_code	VARCHAR2(5)		PRIMARY KEY,
d_name	NVARCHAR2(50)	NOT NULL	,
d_ceo	NVARCHAR2(50)	NOT NULL	,
d_tel	VARCHAR2(20)		,
d_addr	NVARCHAR2(125)		

);

SELECT io_input, count(*) FROM tbl_iolist
GROUP BY io_input;

-- 매입 매출의 합계를 pivot 방식으로 알아보기
SELECT 
    SUM(DECODE(io_input,'매입',io_total, 0)) AS 매입,
    SUM(DECODE(io_input,'매출',io_total, 0)) AS 매출
FROM tbl_iolist;

-- 매입, 매출의 합계를 월별로 부분합을 구하여 pivot 방식으로 알아보기
SELECT 
    SUBSTR(io_date,0,7) 월별,
    SUM(DECODE(io_input,'매입',io_total, 0)) AS 매입,
    SUM(DECODE(io_input,'매출',io_total, 0)) AS 매출
FROM tbl_iolist
GROUP BY SUBSTR(io_date,0,7);

-- 매입, 매출의 합계를 거래처별로 부분합을 구하여 pivot방식으로 알아보기
SELECT 
    io_dname,
    SUM(DECODE(io_input,'매입',io_total, 0)) AS 매입,
    SUM(DECODE(io_input,'매출',io_total, 0)) AS 매출
FROM tbl_iolist
GROUP BY io_dname;

-- 거래처명과 대표가 동시에 같은 거래처는 없다는 가정
SELECT 
    io_dname,io_dceo,
    SUM(DECODE(io_input,'매입',io_total, 0)) AS 매입,
    SUM(DECODE(io_input,'매출',io_total, 0)) AS 매출
FROM tbl_iolist
GROUP BY io_dname,io_dceo;

