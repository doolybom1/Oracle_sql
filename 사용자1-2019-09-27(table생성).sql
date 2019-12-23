-- user1 사용자화면입니다
-- DBA 역할중에서 데이터 저장소의 기초인 Table을 만드는 것

-- 학생 정보를 저장할 tbl_student Table 생성

-- tbl_student라는 이름으로 table(물리적 저장소)을 생성한다
-- 이름명명규칙 : Java에서 변수, 클래스, 메서드 등의 이름을 명명하는 것과 같다
-- 단, 오라클에서는 대소문자를 구별하지 않는다

-- 테이블 명명패턴
-- 일반적으로 테이블을 만들때 테이블 이름앞에 접두사로 tbl_ 사용한다 
-- data type에는 () 사용하여 최대 저장할 크기를 byte 단위로 지정



-- CHAR 고정길이 문자열
-- 최대 2000글자까지 저장
-- 오라클에서 CHAR칼럼에 순수 숫자로만 되어있는 데이터를 저장할 경우 약간의 문제가 있다
-- A0001 형식으로 저장하면 당연히 문자열로 인식한다
-- 0001 형식으로 저장하면 오라클DB에는 문자열로 저장이 되는데 java를 통해서 DB에 접속을 할경우에
-- 숫자로 인식해버리는 오류가 있다
-- 그래서 CHAR는 아주특별한 경우가 아니면 그냥 VARCHAR2 를 사용

-- VARCHAR 가변길이 문자열
-- 최대 4000글자까지 저장
-- 저장하는 데이터의 길이가 일정하지 않을 경우는 데이터 길이만큼 칼럼이 변환되어 파일에 저장

-- nVARCHAR2() : 유니코드, 다국어 지원 칼럼
-- 한글 데이터가 입력될 가능성이 있는 칼럼은 반드시 NVARCHAR2()를 사용하자
CREATE TABLE tbl_student(
    -- 칼럼 : 필드(멤버)변수와 같은 개념
    st_num CHAR(5),
    
    st_name nVARCHAR2(20),
    st_addr nVARCHAR2(125),
    
    -- 숫자를 저장할 칼럼
    -- 표준 SQL에서는 INT, FLOAT, LONG, DOUBLE 등등의 keyword가 있다
    -- 오라클에서도 표준 SQL 숫자 type을 사용할 수 있지만 오라클 코드에서는 NUMBER 칼럼을 사용
    -- INT라는 keyword를 사용하면 NUMBER(38)로 변환되어 생성된다
    st_tel VARCHAR2(20),
    
    st_grade NUMBER(1),
    st_dept nVARCHAR2(10),
    st_age NUMBER(3)

    
);

INSERT INTO tbl_student(st_num, st_name, st_addr)
VALUES('0001', '성춘향','익산시');
INSERT INTO tbl_student(st_num, st_name, st_addr)
VALUES('0001', '성춘향','남원시');

SELECT * FROM tbl_student;

DROP TABLE TBL_STUDENT;

CREATE TABLE tbl_student(
  
    st_num CHAR(5) UNIQUE,
    st_name nVARCHAR2(20) ,
    st_addr nVARCHAR2(125),
    st_tel VARCHAR2(20),
    st_dept nVARCHAR2(20),
    st_grade NUMBER(1),
    st_age NUMBER(3)
);

INSERT INTO tbl_student(st_num, st_name, st_addr)
VALUES('00001', '성춘향','남원시');

INSERT INTO tbl_student(st_num, st_name, st_addr, st_dept)
VALUES('00001', '이몽룡','서울시','컴퓨터');

-- UNIQUE : 중복배제, 중복금지

CREATE TABLE tbl_student(
  
    st_num CHAR(5) UNIQUE,
    st_name nVARCHAR2(20) NOT NULL,
    st_addr nVARCHAR2(125) NOT NULL,
    st_tel VARCHAR2(20),
    st_dept nVARCHAR2(20) NOT NULL,
    st_grade NUMBER(1),
    st_age NUMBER(3)
);

-- 학생 데이터를 추가하는 과정에서 학번은 위에서 중복금지 제약조건을 설정하여
-- 중복된 값이 추가되지 못하도록 설정을 했다

-- 많은 양의 데이터를 추가하다보니 실수로 학생이름, 전화번호 등을 입력하지 않고 추가한 데이터들이 존재한다
-- 나중에 TBL_STUDENT 테이블의 데이터를 사용하여 업무를 수행하려고 했더니
-- 이름 , 전화번호가 없어서 상당히 문제를 일으킨다

INSERT INTO tbl_student(st_num, st_tel)
VALUES('20111', '010-111-1111');

-- 어떤 칼럼의 값을 조회했을ㄹ때 유일하게 1개의 데이터만 추출되도록 설정할 수 있는데 이런 설정을
-- 한 칼럼을 기본키(PRIMARY KEY)라고 한다

SELECT * FROM tbl_student;

DROP TABLE TBL_STUDENT;

CREATE TABLE tbl_student(
  
    -- st_num 칼럼은 PK 조건을 설정한다
    -- PK(PRIMARY KEY)를 설정한 칼럼은 UNIQUE NOT NULL 조건을 만족하며 더불어 KEY로서 조회를 할때 
    -- 매우 빨리 값을 조회할 수 있도록 DBMS가 별도로 관리를 한다
    st_num CHAR(5) PRIMARY KEY,  -- UNIQUE NOT NULL,
    st_name nVARCHAR2(20) NOT NULL,
    st_addr nVARCHAR2(125) NOT NULL,
    st_tel VARCHAR2(20),
    st_dept nVARCHAR2(20) NOT NULL,
    st_grade NUMBER(1),
    st_age NUMBER(3)
);

-- table의 구조를 호가인하는 명령문
DESCRIBE tbl_student;
DESC tbl_student;

-- user1 사용자가 생성한 테이블이 어떤 것들이 있나?
SELECT * FROM dba_tables
WHERE OWNER = 'USER1';

-- tbl_student에 데이터 추가하기

INSERT INTO tbl_student(st_num, st_name,st_tel,st_addr,st_age,st_dept)
VALUES('00001', '홍길동','010-111-1234','서울시','33','컴공과');

INSERT INTO tbl_student(st_num, st_name,st_tel,st_addr,st_age,st_dept)
VALUES('00002', '성춘향','010-111-1234','서울시','33','컴공과');

INSERT INTO tbl_student(st_num, st_name,st_tel,st_addr,st_age,st_dept)
VALUES('00003', '이몽룡','010-111-1234','서울시','33','컴공과');

INSERT INTO tbl_student(st_num, st_name,st_tel,st_addr,st_age,st_dept)
VALUES('00004', '장보고','010-111-1234','서울시','33','컴공과');

INSERT INTO tbl_student(st_num, st_name,st_tel,st_addr,st_age,st_dept)
VALUES('00005', '임꺽정','010-111-1234','서울시','33','컴공과');


SELECT * FROM tbl_student;


