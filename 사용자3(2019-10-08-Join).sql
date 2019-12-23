-- 여기는 user3 화면입니다

-- 조인 : 보통 2개 이상의 테이블에 나뉘어서 보관중인 데이터를 서로 연계해서 하나의 리스트처럼 출력하는 SQL 명령형태

-- EQ, 완전, 내부조인
-- 두 테이블에 연계된 칼러밍 모두 존재할 경우
-- 두 테이블간에 완전 참조무결성이 보장되는 경우
-- 이 조인이 표시하는 리스트를 카티션곱이라고 표현한다
SELECT * FROM tbl_books B, tbl_genre G
WHERE b.b_ganre = g.g_code;

/*
참조 무결성 조건 : 테이블간에 EQ JOIN을 실행햇을때 결과에 신뢰성을 보장하는 조건
-----------------------------------------------------
원본 Table(칼럼)      =         참조Table(칼럼)
-----------------------------------------------------
값이 있다             >>           반드시 있다
있을수도 있다         <<              있다
절대 있을 수 없다     <<              없다
-----------------------------------------------------
*/

-- 두 테이블간에 참조무결성을 무시하고 조인 시행하기
-- 새로운 도서가 입고가 되었는데 그 동안에 사용하던 장르와 완전 다른 분야이다
--그래서 새로운 장르코드를 생성해서 010이라고 사용하기로 결정을 했다
INSERT INTO tbl_books(b_isbn, b_title,b_comp, b_writer, b_ganre)
VALUES('979-009','아침형인간','하늘소식','이몽룡','010');



SELECT * FROM tbl_books B, tbl_genre G
WHERE b.b_ganre = g.g_code;


-- LEFT JOIN
-- LEFT 에 있는 테이블의 리스트는 모두 보여주고 ON 조건에 일치하는 값이 오른쪽의 테이블에
-- 있으면 그 값을 보이고 없으면 null값을 보여줘라
SELECT * FROM tbl_books B -- 리스트를 확인하고자하는 테이블
    LEFT JOIN tbl_genre G -- 참조할 테이블
        ON B.b_ganre = G.g_code -- 참조할 칼럼연계
ORDER BY B.b_isbn;

SELECT * FROM tbl_books B
    LEFT JOIN tbl_genre G
        ON B.b_ganre = G.g_code
WHERE B.b_title = '아침형인간';


SELECT b.b_isbn, b.b_title, b.b_comp, b.b_writer, g.g_code, g.g_name FROM tbl_books b 
LEFT JOIN tbl_genre g
ON b.b_ganre = g.g_code;

    
    
SELECT b.b_isbn, b.b_title, b.b_comp, b.b_writer, g.g_code, g.g_name FROM tbl_books b 
LEFT JOIN tbl_genre g
ON b.b_ganre = g.g_code
WHERE g.g_name = '장편소설';

UPDATE tbl_genre SET g_name = '장르소설'
WHERE g_code = '003';

SELECT b.b_isbn, b.b_title, b.b_comp, b.b_writer, g.g_code, g.g_name FROM tbl_books b 
LEFT JOIN tbl_genre g
ON b.b_ganre = g.g_code;


        