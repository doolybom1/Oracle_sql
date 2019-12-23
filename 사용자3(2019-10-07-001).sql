-- 여기는 user3 화면입니다

-- 도서정보를 저장하기 위한 테이블 생성
CREATE TABLE tbl_books(
    	b_isbn	VARCHAR2(13) PRIMARY KEY,
    	b_title	nVARCHAR2(50) NOT NULL,	
    	b_comp	nVARCHAR2(50) NOT NULL,	
    	b_writer nVARCHAR2(50) NOT NULL,
    	b_price	NUMBER(5),
    	b_year	VARCHAR2(10),
    	b_ganre	VARCHAR2(3)		
);

-- 도서정보 추가
INSERT INTO tbl_books(b_isbn, b_title, b_comp, b_writer, b_price)
VALUES('979-001','오라클 프로그래밍','생능출판사','서진수','30000');

INSERT INTO tbl_books(b_isbn, b_title, b_comp, b_writer, b_price)
VALUES('979-002','Do it 자바','이지퍼블리싱','박은종','25000');

INSERT INTO tbl_books(b_isbn, b_title, b_comp, b_writer, b_price)
VALUES('979-003','SQL 활용','교육부','교육부','10000');

INSERT INTO tbl_books(b_isbn, b_title, b_comp, b_writer, b_price)
VALUES('979-004','무궁화꽃이피었습니다','새웅','김진영','15000');

INSERT INTO tbl_books(b_isbn, b_title, b_comp, b_writer, b_price)
VALUES('979-005','직지','쌤앤파커스','김진영','12600');

-- ISBM 순서로 목록확인
SELECT * FROM tbl_books ORDER BY b_isbn;

-- table을 유지하면서 칼럼의 자릿수를 늘려보자
ALTER TABLE tbl_books  -- tbl_books 테이블을 변경하겠다
MODIFY(b_price NUMBER(7)); -- 칼럼의 타입 또는 자릿수를 변경

INSERT INTO tbl_books(b_isbn,b_title,b_comp,b_writer,b_price)
VALUES('978-801','effective Java','Addison','Joshua Bloch','159000');

-- 이미 생성된 테이블에 새로운 칼럼을 추가하기
ALTER TABLE tbl_books
ADD(b_remark NVARCHAR2(125));

DESC tbl_books;

-- 기존의 칼럼을 삭제
ALTER TABLE tbl_books
DROP COLUMN b_remark;

-- 칼럼의 이름을 변경
ALTER TABLE tble_books
RENAME COLUMN b_remark TO b_rem;

-- ALTER TABLE 명령을 수행할 때 매우 주의할 사항
-- 1. DROP COLUMN
-- 기존에 사용하던 TABLE에서 칼럼을 삭제하면 저장된 데이터가 변형되어 문제가 발생할 수 있다

-- 2. MODIFY
-- 칼럼의 타입을 변경하는 것으로 저장된 데이터가 변형될 수 있다
-- 가. 자릿수를 줄이면 보통 실행 오류가 발생한다. 그렇지 않은 경우도 있는데 이때는 저장된 데이터 일부가 잘릴 수 있다
-- 나. 타입변경 : 기존 데이터 형식이 변경되면서 데이터가 손실, 소실될 수 있다
--                특히 CHAR형과 VARCHAR2 사이에서 타입을 변경하면 기존의 SQL(SELECT) 명령 결과가 전혀 엉뚱하게 나타나거나
--                데이터를 못 찾을 수 있다

-- 3. RENAME COLUMN
-- 칼럼의 이름을 변경하는 것은 데이터 변형이 잘 되지는 않지만 다른 SQL명령문이나, 내장 프로시저, JAVA 프로그래밍에서
-- TABLE에 접근하여 데이터를 CRUD를 실행할 때 문제가 발생할 수 있다

-- 사용자의 비밀번호 변경하기
ALTER USER user3 IDENTIFIED BY 1234;

CREATE TABLE tbl_genre(
    g_code	VARCHAR2(13) PRIMARY KEY,
    g_name	nVARCHAR2(15) NOT NULL,	
    g_remark nVARCHAR2(125)		
);

INSERT INTO tbl_genre(g_code,g_name)
VALUES('001','프로그래밍');

INSERT INTO tbl_genre(g_code,g_name)
VALUES('002','데이터베이스');

INSERT INTO tbl_genre(g_code,g_name)
VALUES('003','장편소설');

ALTER TABLE tbl_genre MODIFY(g_name nVARCHAR2(50));

DESC tbl_books;

ALTER TABLE tbl_books MODIFY(b_ganre nVARCHAR2(10));


UPDATE tbl_books
SET b_ganre = '데이터베이스'
WHERE b_isbn = '979-001';

UPDATE tbl_books
SET b_ganre = '데이터베이스'
WHERE b_isbn = '979-003';

UPDATE tbl_books
SET b_ganre = '장편소설'
WHERE b_isbn = '979-004';

UPDATE tbl_books
SET b_ganre = '프로그래밍'
WHERE b_isbn = '979-002';

UPDATE tbl_books
SET b_ganre = '장편소설'
WHERE b_isbn = '979-005';

UPDATE tbl_books
SET b_ganre = '프로그래밍'
WHERE b_isbn = '978-801';

SELECT * FROM tbl_books
WHERE b_ganre = '데이터베이스';

SELECT * FROM tbl_books
WHERE b_ganre = '장편소설';

-- books 테이블의 데이터 중에 장르가 장편소설인 데이터를 장르소설로 바꾸고 싶다
UPDATE tbl_books SET b_ganre = '장르소설'
WHERE b_ganre = '장편소설';

INSERT INTO tbl_books(b_isbn,b_title,b_comp,b_writer,b_price,b_ganre)
VALUES('979-006','황태자비 납치사건','새움','김진명','25000','장르 소설');

DELETE FROM tbl_books
WHERE b_isbn = '979-006';

SELECT * FROM tbl_books
WHERE b_ganre = '장르소설';

-- 도서정보 데이터를 저장하기 위해 테이블을 만들고 많은 도서를 여러사람이 입력하다보니
-- 일부 데이터에 빈칸 등이 잘못 삽입되어 데이터를 조회할때 문제가 발생하는 것을 알게 되었다
-- 이러한 논리적 문제를 해결하기위해서 '장르 테이블'을 하나 별도로 생성하고
-- books 테이블을 '정규화' 과정을 통해서 조회 오류가 발생하지 않도록 해보자

-- 1. book 테이블의 장르 칼럼에 저장된 문자열을 tbl_genre 테이블에 있는 코드값으로 변경하기

SELECT * FROM tbl_books
WHERE b_ganre = '데이터베이스';
UPDATE tbl_books SET b_ganre ='002'
WHERE b_ganre = '데이터베이스';

UPDATE tbl_books SET b_ganre ='001'
WHERE b_ganre = '프로그래밍';

UPDATE tbl_books SET b_ganre ='003'
WHERE b_ganre = '장르소설';

UPDATE tbl_books SET b_ganre ='003'
WHERE b_ganre = '장르 소설';


SELECT * FROM tbl_genre;
SELECT * FROM tbl_books;

--도서 정보를 확인하면서 장르칼럼의 코드값 대신에 장르 이름으로 보고 싶다
--* 테이블의 JOIN 수행

SELECT * FROM tbl_books, tbl_genre
WHERE tbl_books.b_ganre = tbl_genre.g_code;

SELECT tbl_books.b_isbn, tbl_books.b_title, tbl_books.b_comp, tbl_books.b_writer, tbl_books.b_ganre, --tbl_genre.b_code, 
tbl_genre.g_name
FROM tbl_books, tbl_genre
WHERE tbl_books.b_ganre = tbl_genre.g_code;


-- TABLE 명에 Alias를 설정하는 방법
SELECT b.b_isbn, b.b_title, b.b_comp, b.b_writer, b.b_ganre, --tbl_genre.b_code, 
g.g_name
FROM tbl_books b, tbl_genre g
WHERE b.b_ganre = g.g_code;


INSERT INTO tbl_books(b_isbn,b_title,b_comp,b_writer,b_ganre)
VALUES('979-007','자바의 정석','도울출판','남궁성','004');


SELECT * FROM [table1], [table2]
WHERE table1.col = table2.col;
-- 완전 조인, EQ 조인 이라고 하며 결과를 카티션곱이라고 표현한다
-- table1과 table2를 Relation할 때 서로 연결하는 칼럼의 값이 두 테이블에 모두 존재할 때 정상적인 결과를 낼 수 있다



SELECT * FROM tbl_books;