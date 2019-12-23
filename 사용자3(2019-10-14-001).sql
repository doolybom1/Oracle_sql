-- user3 화면입니다

-- DUAL 시스템 table
-- Dummy Table 이라고 한다.
-- 표준 SQL에서는 일반적인 프로그래밍 코드에서 사용하는 간단한 연산을 SELECT문을 이용해서 실행할 수 있도록 하고 있다
-- 오라클에서는 SELECT 다음에 FROM절이 없으면 문법오류를 발생하도록 설계되어 있다.
-- 그래서 표준 SQL에서 사용하는 간단한 코드를 실행하기가 매우 까다롭다
-- 그래서 문법오류를 방지하고 간단한 코드를 실행하도록 하기 위해서 DUAL이라는 DUMMY TABLE을 준비해 두었다
SELECT * FROM DUAL;
SELECT '1' AS num, '홍길동' AS name, '컴공과' AS dept FROM DUAL;

SELECT '1' AS num, '홍길동' AS name, '컴공과' AS dept FROM tbl_student;


-- UNION : 여러 테이블을 SELECT 해서 생성된 VIEW 결과를 묶어서 마치 하나의 결과처럼 보고자 할때 사용
SELECT '1' AS num, '홍길동' AS name, '컴공과' AS dept FROM DUAL
UNION ALL SELECT '2' AS num, '이몽룡' AS name, '컴공과' AS dept FROM DUAL
UNION ALL SELECT '3' AS num, '성춘향' AS name, '컴공과' AS dept FROM DUAL
UNION ALL SELECT '4' AS num, '장길산' AS name, '컴공과' AS dept FROM DUAL
UNION ALL SELECT '5' AS num, '장보고' AS name, '컴공과' AS dept FROM DUAL
UNION ALL SELECT '6' AS num, '임꺽정' AS name, '컴공과' AS dept FROM DUAL
UNION ALL SELECT '7' AS num, '장영실' AS name, '컴공과' AS dept FROM DUAL
UNION ALL SELECT '8' AS num, '이성계' AS name, '컴공과' AS dept FROM DUAL;

-- 실제 사용하는 DBMS에 쿨리적인 테이블을 생성하지 않고 가상의 데이터를 만들어서 사용하고자 할때 임시로 
-- TABLE 구조와 데이터를 생성하여 테으스 용도로 사용하는 명령군
-- 이 명령군을 사용할 때 UNION 키워드를 사용한다

SELECT * FROM tbl_score;

SELECT '====' AS 학번,'====' AS 국어,'====' AS 영어, '====' AS 수학 FROM DUAL
UNION ALL SELECT '학번' AS 학번,'국어' AS 국어,'영어' AS 영어, '수학' AS 수학 FROM DUAL
UNION ALL SELECT '====' AS 학번,'====' AS 국어,'====' AS 영어, '====' AS 수학 FROM DUAL
UNION ALL SELECT s_num AS 학번, to_char(s_kor,'999') AS 국어, 
                                to_char(s_eng,'999') AS 영어, 
                                to_char(s_math,'999') AS 수학 FROM tbl_score
UNION ALL SELECT '----' AS 학번,'----' AS 국어,'----' AS 영어, '----' AS 수학 FROM DUAL
UNION ALL SELECT '총점' AS 학번, to_char(SUM(s_kor),'99,999') AS 국어, 
                                 to_char(SUM(s_eng),'99,999') AS 영어, 
                                 to_char(SUM(s_math),'99,999') AS 수학 FROM tbl_score
UNION ALL SELECT '====' AS 학번,'====' AS 국어,'====' AS 영어, '====' AS 수학 FROM DUAL;

-- 날짜형 데이터를 문자열형으로 바꿀때
-- YYYY : 연도형식으로 표시
-- MM : 월 형식
-- DD : 일 형식
-- HH : 12시간제 시간
-- HH24 : 24시간제 시간
-- MI : 분
-- SS : 초
-- to_char(날짜값, 'YYYY-MM-DD HH:MI:SS')
SELECT to_char(SYSDATE, 'YYYY-MM-DD HH:MI:SS') FROM DUAL;

-- UNION
-- 테이블의 결과를 결합하여 하느이 VIEW 처럼 보여주는 형식
/*=============================================
UNION                        UNION ALL
중복데이터 배제             무조건 결합
                            중복데이터 모두 표시
내부적으로 SORT작동

중복제가 작업으로
쿼리가 늦어질 수 있음
===============================================
*/
-- 임시로 사용할 테이블 생서
WITH tbl_temp AS
(
    SELECT '1' AS num, '홍길동' AS name FROM DUAL
    UNION ALL SELECT '2' AS num, '이몽룡' AS name FROM DUAL
    UNION ALL SELECT '3' AS num, '임꺽정' AS name FROM DUAL
    UNION ALL SELECT '4' AS num, '성춘향' AS name FROM DUAL
    UNION ALL SELECT '5' AS num, '장보고' AS name FROM DUAL
)
SELECT * FROM tbl_temp;


WITH tbl_temp AS
(
    SELECT '1' AS num, '홍길동' AS name FROM DUAL
    UNION ALL SELECT '2' AS num, '이몽룡' AS name FROM DUAL
    UNION ALL SELECT '3' AS num, '임꺽정' AS name FROM DUAL
    UNION ALL SELECT '4' AS num, '성춘향' AS name FROM DUAL
    UNION ALL SELECT '5' AS num, '장보고' AS name FROM DUAL
)
SELECT * FROM tbl_temp
WHERE num IN( '3', '1', '5')
ORDER BY name;

SELECT * FROM tbl_student
WHERE st_name IN ('갈한수', '남동예', '내세원', '기은성','공동영');


WITH tbl_temp AS
(
    SELECT '공동영' AS name FROM DUAL
    UNION ALL SELECT '갈한수' AS name FROM DUAL
    UNION ALL SELECT '남동예' AS name FROM DUAL
    UNION ALL SELECT '내세원' AS name FROM DUAL
    UNION ALL SELECT '기은성' AS name FROM DUAL
)
SELECT * FROM tbl_temp;



/*
WHERE 절에 포함된 SELECT 실행 : SELECT name FROM tbl_temp
'공동영' '갈한수' '남동예' '내세원' '기은성' 리스트를 생성하고
WHERE IN ('공동영', '갈한수', '남동예', '내세원', '기은성') 코드를 생성한다
그리고 이 WHERE 절을 사용해서 tbl_student의 데이터를 조회한다
*/
WITH tbl_temp AS
(
    SELECT '공동영' AS name FROM DUAL
    UNION ALL SELECT '갈한수' AS name FROM DUAL
    UNION ALL SELECT '남동예' AS name FROM DUAL
    UNION ALL SELECT '내세원' AS name FROM DUAL
    UNION ALL SELECT '기은성' AS name FROM DUAL
)
SELECT * FROM tbl_student
WHERE st_name IN ( SELECT name FROM tbl_temp);
    

-- FROM 절에 포함되는 SUBQ 인라인뷰라고하며 다른 TABLE의 결과를 FROM절에서 사용하는 것
-- 여러 table을 결합하여 나오는 결과값들을 모아서 하나의 쿼리로 연결하여 view로 보여주기 위한 SQUERY
-- EQ JOIN을 대신해서 사용하기도 한다
SELECT * FROM 
    (SELECT * FROM tbl_student WHERE st_grade = 1 );
    
SELECT * FROM tbl_score2 sc, tbl_student st
    WHERE sc.s_num = st.st_num;

-- 단순한 JOIN을 이용해서 보여주기 어려운 복잡한 통계, 집계 등을 사용할 때 먼저 SUBQ에서 통계, 집계 등을 계산하고
-- 그 결과와 main table을 JOIN하고자 할 때
SELECT * FROM tbl_student st, (SELECT sc.s_num, sc.s_kor, sc.s_eng, sc.s_math FROM tbl_score sc) sc
WHERE st.st_num = sc.s_num;


SELECT * FROM tbl_score;

-- SELECT SUB : 스칼라 서브쿼리
-- 스칼라 서브쿼리에서는 절대 LIST를 출력하면 안된다. SUBQ에서는 단 1줄의 Record만 결과로 나와야 한다

SELECT st_num, 
    ( 
    SELECT SUM(s_kor + s_eng + s_math) FROM tbl_score sc
    WHERE st.st_num = sc.s_num
    )
FROM tbl_student st;