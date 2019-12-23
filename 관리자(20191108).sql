--tablespace를 만들지 않고 사용자를 생성하고 데이터를 저장하면 system의 tablespace에 데이터가 저장되어서
--보안등의 문제를 일으킬 수 있다
--오라클에서는 사용자를 생성하기전에 항상 tablespace를 만들어서 사용하라고 권장을 한다.

CREATE TABLESPACE user55_DB
DATAFILE '/bizwork/oracle/data/user.dbf'
SIZE 10M AUTOEXTEND ON NEXT 1K;

CREATE USER user55 IDENTIFIED BY user55
DEFAULT TABLESPACE user55_db;

GRANT DBA TO user55;


-- 만약 user55로 접속하여 user4가 가지고 있는 어떤 table을 select하고 싶다
-- >> SELECT * FROM user4.TBL_TABLE
