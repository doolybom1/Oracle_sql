-- 여기는 GRADE화면 입니다

-- DB이론상 정규화 과정

/*
1. 실무에서 사용하던 엑셀 데이터
===================================
학생이름 학년 학과      취미
-----------------------------------
홍길동     3  컴공과   낚시,등산,독서
*/


/*
2. 엑셀 데이터를 단순히 DBMS의 테이블로 구현
    - 만약 취미가 4개인 학생은 4개중에 3개만 선택해야하는 상황
    - 취미가 3개 미만인 학생은 사용하지 않는 칼럼이 있어 낭비되는 상황
===================================================
학생이름 학년 학과      취미1     취미2     취미3
---------------------------------------------------
홍길동     3  컴공과    낚시      등산      독서


3. 제1정규화가 수행된 TABLE 스키마
===================================================
학생이름 학년 학과      취미     
---------------------------------------------------
홍길동     3  컴공과    낚시     
홍길동     3  컴공과    등산
홍길동     3  컴공과    독서

-- 제2정규화
    테이블의 고정값을 다른 테이블로 분리하고 테이블간의 JOIN을 통해서 VIEW를 생성하도록 구조적 변경을 하는 작업

tbl_student
===================================================
학생이름 학년 학과      취미     
---------------------------------------------------
홍길동     3  컴공과    낚시     
홍길동     3  컴공과    등산
홍길동     3  컴공과    독서


tbl_hobby
=================================
CODE        취미
---------------------------------
001         낚시
002         등산
003         독서
=================================

tbl_dept
=================================
CODE        학과명       담임교수
---------------------------------
001         컴공과
002         국어과
003         영어과
=================================
*/

DESC tbl_score;

/*
==================================
성적일람표 테이블 구조
----------------------------------
S_ID      NOT NULL NUMBER        
S_STD     NOT NULL NVARCHAR2(50) 
S_SUBJECT NOT NULL NVARCHAR2(50) 
S_SCORE   NOT NULL NUMBER(3)     
S_REM              NVARCHAR2(50) 

*/

CREATE TABLE tbl_subject(
    sb_code	VARCHAR2(4)	PRIMARY KEY,
    sb_name	nVARCHAR2(20) NOT NULL,
    sb_pro	nVARCHAR2(20)		
);

-- 엑셀데이터 임포트
SELECT * FROM tbl_subject;

-- tbl_score 에서 tbl_subject 테이블 데이터를 생성 완료
-- 생성된 tbl_subject하고 tbl_score하고 잘 연결되는지 테스트
-- 아래의 두 SQL문의 결과 값이 같으면 정상적으로 수행 완료
SELECT COUNT(*) FROM tbl_score;
SELECT COUNT(*) FROM tbl_score sc, tbl_subject sb
    WHERE sc.s_subject = sb.sb_name;
    
-- tbl_score의 s_subject 칼럼에 있는 과목명을 코드로 변경하는 작업 수행
-- 1. 임시로 칼럼을 하나 tbl_score 추가
-- tbl_subject의 sb_code 칼럼과 구조가 같은 칼럼을 추가
ALTER TABLE tbl_score ADD s_sbcode VARCHAR2(4);


-- tbl_subject 테이블에서 과목명을 조회하여 해당하는 과목코드를 tbl_score 테이블의 s_sbcode 칼럼에 UPDATE 수행하라
UPDATE tbl_score SC 
SET s_sbcode = (SELECT sb_code FROM tbl_subject SB WHERE SC.s_subject = SB.sb_name);

SELECT * FROM tbl_score;
SELECT * FROM tbl_subject;

-- UPDATE 수행 후 검증
SELECT SC.s_sbcode, SB.sb_code, SC.s_subject, SB.sb_name 
FROM tbl_score SC, tbl_subject SB
WHERE SC.s_sbcode = SB.sb_code;

-- tbl_score의 s_subject 칼럼을 삭제
ALTER TABLE tbl_score DROP COLUMN s_subject;

-- tbl_score s_sbcode 칼럼을 s_subject로 이름 변경
ALTER TABLE tbl_score RENAME COLUMN s_sbcode TO s_subject;

DESC tbl_score;

/*
제 2 정규화 완료된 테이블
이름        널?       유형            
--------- -------- ------------- 
S_ID      NOT NULL NUMBER        
S_STD     NOT NULL NVARCHAR2(50) 
S_SCORE   NOT NULL NUMBER(3)     
S_REM              NVARCHAR2(50) 
S_SUBJECT          VARCHAR2(4)   


*/

-- JOIN을 통해서 데이터 확인
SELECT s_std, s_subject, SB.sb_name, SB.sb_pro, s_score
FROM tbl_score SC, tbl_subject SB
WHERE SC.s_subject = SB.sb_code;

SELECT s_id, s_std , s_subject, s_rem FROM tbl_score
WHERE s_id > 600;


DELETE FROM tbl_score
WHERE s_id = 603;




