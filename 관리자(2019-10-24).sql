-- 관리자 화면
-- 새로운 환경으로 데이터를 사용할거야
CREATE TABLESPACE new_grade_db
DATAFILE '/bizwork/oracle/data/new_grade.dbf'
SIZE 100M AUTOEXTEND ON NEXT 100K;

CREATE USER new_grade IDENTIFIED BY grade;
GRANT DBA TO new_grade;
