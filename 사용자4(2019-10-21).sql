-- 사용자4 화면입니다

UPDATE tbl_books SET b_price = ROUND(DBMS_RANDOM.VALUE(10000,50000));
SELECt * FROM tbl_books;

commit;