-- 매입매출관리
-- 상품정보 제2정규화 작업

-- 매입매출정보에 상품정보가 어떻게 저장되어 있는지 확인
SELECT io_pname
FROM tbl_iolist
GROUP BY io_pname
ORDER BY io_pname;

CREATE TABLE tbl_product(
    p_code	VARCHAR(6)	NOT NULL	PRIMARY KEY,
    p_name	VARCHAR2(50)	NOT NULL,
    p_iprice	NUMBER,
    p_oprice	NUMBER		
);

DROP TABLE tbl_product;


SELECT * FROM tbl_product;

-- 검증
SELECT io_inout,COUNT(*)
FROM tbl_iolist io, tbl_product p
WHERE io.io_pname = p.p_name
GROUP BY io_inout;


-- 상품들의 매입단가를 확인
SELECT io_inout, io.io_pname,io.io_price, COUNT(*) FROM tbl_iolist io, tbl_product p
WHERE io.io_pname = p.p_name
    AND io.io_inout = 1
GROUP BY io_inout, io_pname, io_price;

-- 매입매출 테이블에서 매입단가를 조회해 봤더니 다행히 상품이름이 같은데 단가가 다른 상품이 없는 것 같다
-- 매입매출 테이블에서 매입단가를 상품정보테이블의 매입단가 칼럼에 세팅을 하려고 한다.

UPDATE tbl_product p
SET p_iprice = (
                SELECT MAX(io.io_price)  FROM tbl_iolist io
                WHERE io_inout = 1 AND p.p_name = io.io_pname
);


UPDATE tbl_product p
SET p_oprice = (
                SELECT MAX(io.io_price)  FROM tbl_iolist io
                WHERE io_inout = 2 AND p.p_name = io.io_pname
);


SELECT * FROM tbl_product;


-- 상품거래정보에서 상품정보 매입, 매출단가를 생성을 했더니 NULL인 값이 있다
-- 어떤 상품은 매입만되고 어떤 상품은 매출만된 경우

/*
    매입단가에서 매출단가 생성하기
    공산품일경우 매입단가의 약 18%를 더해서 매출단가를 계산
    그리고 여기에 10% VAT을 붙여서 다시 계산
    매출단가 : 매입단가 + (매입단가 * 0.18) * 1.1
    
    매출단가에서 매입단가 생성하기
    매출단가에서 부가세를 제외하고 그 금액에서 18%를 빼서 매입단가를 계산
    
    매입단가 = (매출단가 / 1.1) - ((매출단가 / 1.1) * 0.18)
    매입단가 = (매출단가 / 1.1) * 0.82
*/

UPDATE tbl_product SET p_iprice = ROUND((p_oprice / 1.1) * 0.82,0 )
WHERE p_iprice IS NULL;

UPDATE tbl_product SET p_oprice = ROUND((p_iprice * 0.18)  * 1.1,0)
WHERE p_oprice IS NULL;

UPDATE tbl_product
SET p_iprice = ROUND(p_iprice,0),
    p_oprice = ROUND(p_oprice,0);
    
SELECT * FROM tbl_product;
