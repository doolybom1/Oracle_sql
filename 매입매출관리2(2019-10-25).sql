-- iolist2
-- 데이터 임포트 수행후 정확히 데이터가 있는지 확인
SELECT * FROM tbl_iolist;

SELECT io_inout, COUNT(*) FROM tbl_iolist
GROUP BY io_inout;

drop table tbl_iolist;

CREATE TABLE tbl_iolist(
    io_seq	NUMBER		PRIMARY KEY,
    io_date	VARCHAR2(10)	NOT NULL,	
    io_pname	NVARCHAR2(25)	NOT NULL,
    io_dname	NVARCHAR2(25)	,	
    io_dceo	NVARCHAR2(25)	,	
    io_inout	NVARCHAR2(2),		
    io_qty	NUMBER		,
    io_price	NUMBER	,	
    io_total	NUMBER		
);

SELECT io_pname
FROM tbl_iolist
WHERE io_inout = '매입'
GROUP BY io_pname
ORDER BY io_pname;

SELECT io_pname FROM tbl_iolist
GROUP BY io_pname;


-- 상품 테이블 생성
CREATE TABLE tbl_product(
    p_code	VARCHAR2(5)		PRIMARY KEY,
    p_name	NVARCHAR2(50)	NOT NULL,
    p_iprice	NUMBER,
    p_oprice	NUMBER,
    p_vat	VARCHAR2(1)		
);

SELECT COUNT(*) FROM tbl_product;

SELECT COUNT(*)
FROM tbl_iolist, tbl_product
WHERE io_pname = p_name;

SELECT COUNT(*) FROM tbl_product;

-- 매입매출데이터에 상품코드 칼럼을 추가
ALTER TABLE tbl_iolist ADD io_pcode VARCHAR2(5);

-- 상품테이블에서 상품코드를 가져와서
-- 매입매출데이터의 상품코드 칼럼에 update를 실행
UPDATE tbl_iolist SET io_pcode = (SELECT p_code FROM tbl_product WHERE io_pname = p_name);

-- 매입매출 테이블 전체를 펼처두고 각 레코드에서 상품이름을 추출하여 상품테이블의 SELECT문으로 주입하고
-- 상품테이블에서 해당 상품이름으로 WHERE 조건을 실행하여 나타나는 상품코드를 매입매출 테이블의 상품코드
-- 칼럼에 업데이트 실행하라

SELECT COUNT(*) FROM tbl_iolist, tbl_product
WHERE io_pcode = p_code;


SELECT * FROM tbl_product;

alter table tbl_iolist drop column io_pname;

select * from tbl_iolist, tbl_product
where io_pcode = p_code;

SELECT io_dname, COUNT(*)
FROM tbl_iolist
GROUP BY io_dname;

-- 거래처정보는 같은 이름의 거래처가 있을 수 있기 때문에 거래처정보 테이블을 생성할때는
-- 거래처명과 대표이름을 함께 묶어서 정보를 추출해야 한다
SELECT io_dname,io_dceo, COUNT(*)
FROM tbl_iolist
GROUP BY io_dname, io_dceo;

CREATE TABLE tbl_dept(
    d_code	VARCHAR2(5)		PRIMARY KEY,
    d_name	NVARCHAR2(50)	NOT NULL	,
    d_ceo	NVARCHAR2(50)	NOT NULL	,
    d_tel	VARCHAR2(20)		,
    d_addr	NVARCHAR2(125)		
);


SELECT COUNT(*) FROM tbl_dept;

-- 매입매출테이블 거래처코드 칼럼 추가
ALTER TABLE tbl_iolist
ADD io_dcode VARCHAR2(5);
DESC tbl_iolist;

-- 거래처정보 테이블과 매입매출정보 테이블 EQ JOIN을 실행해서
-- 거래처 정보가 정확히 생성되었느닞 확인
SELECT COUNT(*) FROM tbl_iolist, tbl_dept
WHERE io_dname = d_name AND io_dceo = d_ceo;

SELECT COUNT(*) FROM tbl_iolist;

UPDATE tbl_iolist SET io_dcode = (SELECT d_code FROM tbl_dept WHERE io_dname = d_name AND io_dceo = d_ceo);

SELECT * FROM tbl_iolist, tbl_dept
WHERE io_dcode = d_code;

DESC tbl_dept;


ALTER TABLE tbl_iolist DROP COLUMN io_dname;
ALTER TABLE tbl_iolist DROP COLUMN io_dceo;

SELECT * FROM tbl_iolist;



CREATE VIEW view_iolist
AS
(
SELECT
        io.IO_SEQ,
        io.IO_DATE,
        io.IO_INOUT,
        io.IO_DCODE,
        io.IO_PCODE,
        io.IO_QTY,
        io.IO_PRICE,
        io.IO_TOTAL,
        
        d.D_NAME AS IO_DNAME,
        d.D_CEO AS IO_DCEO,
        d.D_TEL AS IO_DTEL,
        d.D_ADDR AS IO_DADDR,
        
        p.P_NAME AS IO_PNAME,
        p.P_IPRICE AS IO_IPRICE,
        p.P_OPRICE AS IO_OPRICE, 
        p.P_VAT AS IO_PVAT
FROM tbl_iolist io
    LEFT JOIN tbl_product p
        ON io.io_pcode = p.p_code
    LEFT JOIN tbl_dept d
        ON io.io_dcode = d.d_code
);
        
SELECT * FROM view_iolist;
        
CREATE TABLE tbl_score(
sc_seq	NUMBER		PRIMARY KEY,
sc_name	NVARCHAR2(50)	NOT NULL,	
sc_subject	NVARCHAR2(5)	NOT NULL	,
sc_score	NUMBER	NOT NULL	,
sc_sbcode	VARCHAR2(5)		,
sc_stcode	VARCHAR2(5)		
);
SELECT * FROM tbl_score;

CREATE TABLE tbl_subject(
sb_code	VARCHAR2(5)		PRIMARY KEY,
sb_name	NVARCHAR2(50)	NOT NULL,	
sb_pro	NVARCHAR2(50)	
);
drop table tbl_subject;

ALTER TABLE tbl_score
ADD sc_code VARCHAR(5);

ALTER table tbl_score
DROP COLUMN sc_code;


SELECT sc_subject FROM tbl_score
GROUP BY sc_subject;

UPDATE tbl_score SET sc_sbcode = (SELECT sb_code FROM tbl_subject WHERE sc_subject = sb_name);

SELECT sc_sbcode, sb_code FROM tbl_score sc, tbl_subject sb
WHERE sc.sc_sbcode = sb.sb_code;

SELECT * FROM tbl_score;
SELECT * FROM tbl_subject;

        
        
        