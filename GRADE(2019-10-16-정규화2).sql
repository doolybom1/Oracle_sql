-- GRADE 화면
DESC tbl_score;

/*
이름        널?       유형            
--------- -------- ------------- 
S_ID      NOT NULL NUMBER        
S_STD     NOT NULL NVARCHAR2(50) 
S_SCORE   NOT NULL NUMBER(3)     
S_REM              NVARCHAR2(50) 
S_SUBJECT          VARCHAR2(4)   

학생정보 칼럼을 제2정규화
score 테이블에는 학생이름이 일반적인 문자열로 저장이 되었다
일반적인 문자열로 저장된 경우 학생이름을 변경해야할 경우가 발생하면 
UPDATE tbl_score Set s_std = '이몽룡'
WHERE s_std = '이멍룡'
과 같은 방식으로 칼럼을 업데이트 수행할 것이다. 하지만, DBMS의 UPDATE 권장 패턴에서는 여러개의
레코드를 수정, 변경하는 것을 지양하도록 한다. 또한, 만약 학생정보에 다른 정보를 포함하고 싶을때는 tbl_score
테이블에 칼럼을 추가하는 등의 방식으로 처리를 해야하는데 이 방식 또한 좋은 방식이 아니다

그래서 학생정보 테이블을 생성하고 학생코드를 만들어준다음 score 테이블의 s_std 칼럼의 값을 학생코드로 변경하여
제2정규화를 수행하고자 한다.

단, tbl_score에 저장된 학생 이름이 동명이인이 없다라고 가정한다.
*/

-- 1. tbl_score 테이블로부터 학생이름을 추출하여 테이블로 생성
SELECT s_std FROM tbl_score
GROUP BY s_std;

CREATE TABLE tbl_student(
    st_num	VARCHAR2(5)	PRIMARY KEY,
    st_name	nVARCHAR2(50) NOT NULL,
    st_tel	VARCHAR2(20),
    st_addr	nVARCHAR2(125),
    st_grade	NUMBER(1) NOT NULL,
    st_dept	VARCHAR2(5) NOT NULL	
);

-- 5. 데이터 임포트 후 확인
SELECT COUNT(*) FROM tbl_student;

-- 6. tbl_score 테이블의 s_std 칼럼의 값을
-- 학생이름 -> 학번으로 변경
-- 가. 임시 칼럼을 생성

ALTER TABLE tbl_score ADD s_stcode VARCHAR2(5);

-- 나. tbl_student와 tbl_score를 연결해서 tbl_student의 학번정보를 tbl_score에 등록
SELECT * FROM tbl_score sc, tbl_student st
WHERE sc.s_std = st.st_name;

UPDATE tbl_score sc SET s_stcode = (SELECT st.st_num FROM tbl_student st WHERE st.st_name = sc.s_std);

SELECT s_stcode, st.st_num, sc.s_std, st.st_name FROM tbl_score sc, tbl_student st
WHERE sc.s_stcode = st.st_num;

-- 7. tbl_score의 s_std 칼럼을 삭제하고, s_stcode 칼럼을 s_std 칼럼으로 이름 변경
ALTER TABLE tbl_score DROP COLUMN s_std;
ALTER TABLE tbl_score RENAME COLUMN s_stcode TO s_std;

DESC tbl_score;

SELECT sc.s_id,sc.s_std,st.st_name,st.st_grade,st.st_dept,sc.s_score 
FROM tbl_score sc, tbl_student st
WHERE sc.s_std = st.st_num;


SELECT sc.s_id,sc.s_std,st.st_name,st.st_grade,st.st_dept,sc.s_subject,sb.sb_name,sc.s_score 
FROM tbl_score sc
    LEFT JOIN tbl_student st
        ON sc.s_std = st.st_num
    LEFT JOIN tbl_subject sb
        ON sc.s_subject = sb.sb_code
ORDER BY st.st_name, sb.sb_name;


CREATE TABLE tbl_dept(
    d_num	VARCHAR2(5)		PRIMARY KEY,
    d_name	nVARCHAR2(30)	NOT NULL,	
    d_pro	nVARCHAR2(20),		
    d_tel	VARCHAR2(20)		
);

DROP TABLE tbl_dept;

DROP VIEW view_score;
CREATE VIEW view_score
AS
(
SELECT sc.s_id, sc.s_std, st.st_name, st.st_grade, st.st_dept, dp.d_name, dp.d_tel, sc.s_subject, sb.sb_name, sc.s_score
FROM tbl_score sc
    LEFT JOIN tbl_student st
        ON sc.s_std = st.st_num
    LEFT JOIN tbl_subject sb
        ON sc.s_subject = sb.sb_code 
    LEFT JOIN tbl_dept dp
        ON st.st_dept = dp.d_num
--ORDER BY st.st_name, sb.sb_name;
);

SELECT * FROM view_score;
SELECT * FROM tbl_subject;


/*
    DECODE(칼럼,값, T결과)
    if(칼럼 == 값)
        print(T 결과)
    else
        print(null)
*/
CREATE VIEW view_score_pv
AS
(
SELECT s_std, st_name, d_name, st_grade, 
    SUM(DECODE(s_subject, 'S001', s_score)) AS 과학,
    SUM(DECODE(s_subject, 'S002', s_score)) AS 수학,
    SUM(DECODE(s_subject, 'S003', s_score)) AS 국어,
    SUM(DECODE(s_subject, 'S004', s_score)) AS 국사,
    SUM(DECODE(s_subject, 'S005', s_score)) AS 미술,
    SUM(DECODE(s_subject, 'S006', s_score)) AS 영어,
    SUM(s_score) AS 총점,
    ROUND(AVG(s_score),1) AS 평균,
    RANK() OVER (ORDER BY SUM(s_score) DESC) AS 석차
FROM view_score
GROUP BY s_std, st_name, d_name, st_grade
--ORDER BY s_std;
);
SELECT * FROM tbl_subject;


SELECT * FROM (SELECT s_std, st_name, d_name, st_grade, s_subject, s_score FROM view_score)
PIVOT
(
    SUM(s_score)
    FOR s_subject 
    IN(
        'S001' AS 과학,
        'S002' AS 수학,
        'S003' AS 국어,
        'S004' AS 국사,
        'S005' AS 미술,
        'S006' AS 영어
        )
);

SELECT * FROM view_score_pv;

-- 제2정규화가 완료된 4개의 table을 서로 RELATION 설정(참조 무결성 제약조건 설정)

ALTER TABLE tbl_score ADD CONSTRAINT FK_SCORE_SUBJECT FOREIGN KEY(s_subject)
REFERENCES tbl_subject(sb_code);

ALTER TABLE tbl_score ADD CONSTRAINT FK_SCORE_STUDENT FOREIGN KEY(s_std)
REFERENCES tbl_student(st_num);

ALTER TABLE tbl_student ADD CONSTRAINT FK_SCORE_DEPT FOREIGN KEY(st_dept)
REFERENCES tbl_dept(d_num);

DESC tbl_student;
DESC tbl_score;
