-- USER4 화면입니다

/*
테이블 생성
이름 : tbl_books
칼럼 
    코드 : b_code
    이름 : b_name
    출판사 : b_comp
    저자 : b_writer
    가격 : b_price
*/

/*
도서정보를 추가하는데 ISBN과는 별도로 자체적으로 일련번호를 부여하여 관리를 하겠다

일련번호이기 때문에 일단 칼럼을 NUMBER로 설정을해서 1 ~ 입력순서대로 번호를 부여하겠다

요구사항2
기존에 입력된 번호와 다른 새로운 번호를 사용해서 데이터를 입력한다.

요구사항3
데이터를 입력할 때 일련번호를 기억하기 싫다.
항상 새로운 번호로 일련번호를 생성하여 데이터를 추가할 수 있도록 해달라

요구사항4
입력된 데이터 중에서 b_price는 숫자 값인데 값이 없이 추가가 되면 (null)형태가 된다. 이럴 경우 
프로그래밍 언어에서 데이터를 가져가서 사용할 때 문제를 일으킬 수 있다. 그래서, 가격 칼럼ㅇ데 값이 없이
데이터가 추가되면 자동으로 0을 채우도록 하자
*/
CREATE TABLE tbl_books(
    b_code NUMBER PRIMARY KEY,
    b_name VARCHAR2(50) NOT NULL,
    b_comp VARCHAR2(50),
    b_writer VARCHAR2(20),
    b_price NUMBER DEFAULT 0
);

INSERT INTO TBL_BOOKS(b_code, b_name, b_comp, b_writer)
VALUES (1, '자바입문','이지퍼블','박은종');

DELETE FROM tbl_books
WHERE b_code = 1;

-- 가급적 사용하지 말자
INSERT INTO TBL_BOOKS
VALUES(2,'오라클','생능','서진수',35000);

/*
데이터를 추가할때마다 b_code 칼럼의 값을 새로 생성하고 싶다
1. Random() 을 사용하는 방법
간혹 중복값이 나올 수 있음 그래서, primary key를 사용하면 random()을 사용할 수 없음
*/
INSERT INTO tbl_books(b_code, b_name)
VALUES( ROUND(dbms_random.value(100000000, 9999999999),0),'연습도서');


/*
SEQUENCE 객체를 사용하여 만드는 방법
다른 DBMS의 AUTO INCREAMENT 기능을 대체하여 사용하는 방법
*/

-- 1부터 1씩 증가하는 값을 만들어라
CREATE SEQUENCE SEQ_BOOKS
START WITH 1 INCREMENT BY 1;



SELECT SEQ_BOOKS.nextval FROM DUAL;

-- 일련번호 부여방법
INSERT INTO tbl_books(b_code, b_name)
VALUES(SEQ_BOOKS.NEXTVAL, '시퀀스 연습');

-- 기존에 생성된 테이블에 SEQ를 적용하기
/*
매입매출에서 TBL_IOLIST에 데이터를 추가하면서 엑셀로 데이터를 정리하고 SEQ 칼럼을 만든다음 일련번호를 추가해 두었다
이제 새로만든 App에서 데이터를 추가할때 SEQUENCE를 사용하고자 한다.
*/

1. 기존데이터의 SEQ 칼럼의 최대값이 얼마냐 확인 : 589
2. 새로운 시퀀스를 생성할때 START WITH : 600으로 설정
CREATE SEQUENCE SEQ_IOLIST
START WITH 600 INCREMENT BY 1;

/*
만약 실수로 SEQ 시작값을 잘못 설정했을 경우
*/
ALTER SEQUENCE SEQ_IOLIST START WITH 600;
ALTER SEQUENCE SEQ_IOLIST INCREMENT BY 600;

SELECT SEQ_IOLIST.NEXTVAL FROM DUAL;
ALTER SEQUENCE SEQ_IOLIST INCREMENT BY 1;

SELECT SEQ_BOOKS.currval from dual;

/*
도서 코드를 B0001 형식으로 일련번호를 만들고 싶다. 이 방식은 oracle이외의 다른 dbms에서는 상당히 복잡하다.
*/
CREATE TABLE tbl_books(
    b_code VARCHAR2(5) PRIMARY KEY,
    b_name NVARCHAR2(50) NOT NULL,
    b_comp NVARCHAR2(50),
    b_writer NVARCHAR2(20),
    b_price NUMBER DEFAULT 0
);

/*
    TO_CHAR(값, 포맷형)
    TO_CHAR(숫자, '0000') : 자릿수를 4개로 설정하고, 공백부분을 0으로 채워라
*/
INSERT INTO tbl_books(b_code, b_name)
VALUES('B' || TRIM(TO_CHAR(SEQ_BOOKS.NEXTVAL,'0000')), 'SEQ 연습');

-- 오라클의 고정길이 문자열 생성
/*
원래 값이 숫자형일경우
TO_CHAR(값, 포맷형)

원래값이 다양한 형일 경우
LPAD(값, 총길이, 채움문자)
RPAD(값, 총길이, 채움문자)
*/

-- LPAD
-- 총 길이를 10개로 하고 공백(남은부분)은 * 로 표시하여 문자열 생성
SELECT LPAD(30,10,'*') FROM DUAL;

-- RPAD
SELECT RPAD(30,10,'A') FROM DUAL;
SELECT'B' || LPAD(SEQ_BOOKS.NEXTVAL,4,'0') FROM DUAL;


SELECT RPAD('우리',20,' ') FROM DUAL
UNION ALL SELECT RPAD('대한민국',20,' ') FROM DUAL
UNION ALL SELECT RPAD('미연방합중국',20,' ') FROM DUAL
UNION ALL SELECT RPAD('중화인민공화국',20,' ') FROM DUAL;

SELECT LPAD('우리',20,' ') FROM DUAL
UNION ALL SELECT LPAD('대한민국',20,' ') FROM DUAL
UNION ALL SELECT LPAD('미연방합중국',20,' ') FROM DUAL
UNION ALL SELECT LPAD('중화인민공화국',20,' ') FROM DUAL;


SELECT * FROM tbl_books;
INSERT INTO tbl_books(b_code, b_name)
VALUES('B' || TRIM(TO_CHAR(SEQ_BOOKS.NEXTVAL,'0000')), 'SEQ연습');

INSERT INTO tbl_books(b_code, b_name)
VALUES('B' || LPAD(SEQ_BOOKS.NEXTVAL,4,'0'), 'SEQ연습2');


DROP TABLE tbl_books;
TRUNCATE TABLE tbl_books;
SELECT * FROM tbl_books;
DESC tbl_books;







