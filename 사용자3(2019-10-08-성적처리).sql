-- 여기는 USER3 화면입니다
CREATE TABLE tbl_score(
    s_num VARCHAR2(3)PRIMARY KEY,
    s_kor NUMBER(3),
    s_eng NUMBER(3),
    s_math NUMBER(3)		
);

INSERT INTO tbl_score(s_num, s_kor, s_eng, s_math)
VALUES('001',90 ,80 ,70);

INSERT INTO tbl_score(s_num, s_kor, s_eng, s_math)
VALUES('002',90 ,80 ,70);

INSERT INTO tbl_score(s_num, s_kor, s_eng, s_math)
VALUES('003',90 ,80 ,70);

INSERT INTO tbl_score(s_num, s_kor, s_eng, s_math)
VALUES('004',90 ,80 ,70);

INSERT INTO tbl_score(s_num, s_kor, s_eng, s_math)
VALUES('005',90 ,80 ,70);

INSERT INTO tbl_score(s_num, s_kor, s_eng, s_math)
VALUES('006',90 ,80 ,70);

INSERT INTO tbl_score(s_num, s_kor, s_eng, s_math)
VALUES('007',90 ,80 ,70);

-- 성적의 총점, 평균
SELECT s_kor, s_eng, s_math,
       s_kor + s_eng + s_math AS 총점,
       (s_kor + s_eng + s_math) / 3 AS 평균
FROM tbl_score;

-- 50 ~ 100까지 임의의 정수 생성
-- ROUND(DBMS_RANDOM.VALUE(50,100),0)


UPDATE tbl_score 
SET s_kor = ROUND(DBMS_RANDOM.VALUE(50,100),0),
    s_eng = ROUND(DBMS_RANDOM.VALUE(50,100),0),
    s_math = ROUND(DBMS_RANDOM.VALUE(50,100),0);

SELECT * FROM tbl_score;

UPDATE tbl_score SET s_eng = '30'
WHERE s_num = '003';


SELECT * FROM tbl_score;

SELECT s_num, s_kor, s_eng, s_math,
       s_kor + s_eng + s_math AS 총점,
       (s_kor + s_eng + s_math) / 3 AS 평균
FROM tbl_score;

SELECT s_num, s_kor, s_eng, s_math,
       s_kor + s_eng + s_math AS 총점,
       ROUND((s_kor + s_eng + s_math) / 3, 1) AS 평균
FROM tbl_score;

SELECT s_num, s_kor, s_eng, s_math,
       s_kor + s_eng + s_math AS 총점,
       ROUND((s_kor + s_eng + s_math) / 3, 1) AS 평균
FROM tbl_score
WHERE (s_kor + s_eng + s_math)/3 >= 80;

SELECT s_num, s_kor, s_eng, s_math,
       s_kor + s_eng + s_math AS 총점,
       ROUND((s_kor + s_eng + s_math) / 3, 1) AS 평균
FROM tbl_score
WHERE (s_kor + s_eng + s_math)/3 BETWEEN 70 AND 80;

-- 통계, 집계함수
-- SUM(), AVG(), MAX(), MIN(), COUNT()

-- 전체리스트의 각 과목별 총점 계산하기
SELECT SUM(s_kor) FROM tbl_score;

SELECT SUM(s_kor) AS 국어총점,
        SUM(s_eng) AS 영어총점,
        SUM(s_math) AS 수학총점,
        SUM(s_kor+s_eng+s_math) AS 전체총점,
        ROUND(AVG((s_kor + s_eng + s_math)/3),0) AS 전체평균
FROM tbl_score;



-- 개인 총점이 200점 이상인 리스트들의 집계
SELECT SUM(s_kor) AS 국어총점,
        SUM(s_eng) AS 영어총점,
        SUM(s_math) AS 수학총점,
        SUM(s_kor+s_eng+s_math) AS 전체총점,
        ROUND(AVG((s_kor + s_eng + s_math)/3),0) AS 전체평균
FROM tbl_score
WHERE s_kor + s_eng + s_math >= 200;


SELECT SUM(s_kor) AS 국어총점,
        SUM(s_eng) AS 영어총점,
        SUM(s_math) AS 수학총점,
        SUM(s_kor+s_eng+s_math) AS 전체총점,
        ROUND(AVG((s_kor + s_eng + s_math)/3),0) AS 전체평균
FROM tbl_score
WHERE (s_kor + s_eng + s_math) / 3 >= 70;


-- 1. (s_kor + s_eng + s_math)를 계산하고
-- 2. 계산결과를 내림차순으로 정렬하고
-- 3. 순서대로 값을 매겨라
SELECT s_num, s_kor + s_eng + s_math AS 총점,
    RANK() OVER ( ORDER BY (s_kor + s_eng + s_math) DESC) AS 석차 
FROM tbl_score;


select * from tbl_score;


CREATE TABLE tbl_score2(
    s_num VARCHAR2(3) PRIMARY KEY,
    s_dept VARCHAR2(3),
    s_kor NUMBER(3),
    s_eng NUMBER(3),
    s_math NUMBER(3)		
);

CREATE TABLE tbl_dept(
    d_num VARCHAR2(3) PRIMARY KEY,
    d_name nVARCHAR2(20) NOT NULL,
    d_pro VARCHAR2(3)		
);


