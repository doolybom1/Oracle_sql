-- iolist 사용자 화면
SELECT * FROM tbl_product;

-- 상품정보 테이블에서 판매가격의 원단위를 제거하고 0으로 세팅
-- ROUND(판매가격 / 10,0) * 10

UPDATE tbl_product SET p_oprice = ROUND(p_oprice / 10,0) * 10;

-- 매입매출장과 상품정보를 테이블 JOIN 하기위해 
-- 1. 매입매출장에 상품코드 칼럼을 추가하고
-- 2. 상품이름과 연결된 상품코드로 업데이트하고 
-- 3. 상품이름 칼럼 제거

-- 1. 매입매출장에 상품코드 칼럼을 추가
ALTER TABLE tbl_iolist ADD io_pcode VARCHAR2(6);

-- 2. 매입매출장의 상품코드 칼럼을 업데이트 ( 서브쿼리 사용 )
-- update를 수행하는 서브쿼리의 SELECT Projection에는 칼럼 1개만 사용해야 한다
-- 서브쿼리에서 나타나는 레코드수도 반드시 1개만 나타나야 한다
UPDATE tbl_iolist io SET io_pcode = (SELECT p_code FROM tbl_product p WHERE io.io_pname = p.p_name);

-- 업데이트 후에 검증
-- iolist와 product를 EQ JOIN
SELECT * FROM tbl_iolist, tbl_product
WHERE io_pcode = p_code;



/*
자동 커밋 : CREATE , ALTER, DROP
자동 커밋 X : DELETE, UPDATE, INSERT
*/
-- 3. 상품이름 칼럼 제거
ALTER TABLE tbl_iolist DROP COLUMN io_pname;

-- pcode끼리 JOIN 수행해서 검증
SELECT COUNT(*) FROM tbl_iolist, tbl_product
WHERE io_pcode = p_code;



SELECT * FROM tbl_product;
SELECT * FROM tbl_iolist;