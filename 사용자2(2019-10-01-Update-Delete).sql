-- 여기는 user2 화면입니다
-- update, delete 명령

-- 새로운 사용자 사용할 Table을 생성
-- 주소록 테이블을 생성
-- 이름, 전화번호, 주소, 관계, 기타, 생년원일, 나이
-- name, tel,   address,chain ,remark, birth, age

CREATE TABLE tbl_address(

    name NVARCHAR2(20) NOT NULL, 
    tel VARCHAR2(20) NOT NULL,

    address NVARCHAR2(125),
    chain NVARCHAR2(10),
    rem NVARCHAR2(125),
    birth VARCHAR2(10),
    age NUMBER(3)
    
);

INSERT INTO tbl_address(name,tel)
VALUES('홍길동','서울특별시');

INSERT INTO tbl_address(name,tel)
VALUES('이몽룡','익산시');

INSERT INTO tbl_address(name,tel)
VALUES('성춘향','남원시');

INSERT INTO tbl_address(name,tel)
VALUES('장길산','부산광역시');

INSERT INTO tbl_address(name,tel)
VALUES('임꺽정','함경남도');

UPDATE tbl_address 
SET address = '서울특별시';

-- 현재 Transaction이 완료가 되었다는 것을 DBMS에게 알리는 명령
COMMIT;

SELECT * FROM tbl_address;

-- 데이터의 추가, 수정, 삭제를 취소하는 명령
ROLLBACK;
SELECT * FROM tbl_address;

UPDATE tbl_address SET address = '서울특별시'
WHERE name = '홍길동';

UPDATE tbl_address SET address = '남원시'
WHERE name = '이몽룡';

UPDATE tbl_address SET address = '익산시'
WHERE name = '성춘향';


UPDATE tbl_address SET address = '남원시'
WHERE name = '성춘향';

UPDATE tbl_address SET address = '익산시'
WHERE name = '이몽룡';


INSERT INTO tbl_address(name, tel)
VALUES('홍길동','서울특별시');

SELECT * FROM tbl_address;

UPDATE tbl_address SET address = '광주광역시'
WHERE address = '서울특별시';

DROP TABLE tbl_address;




CREATE TABLE tbl_address(

    id NUMBER PRIMARY KEY, -- 실제 주소록에는 필요없는 칼럼을 추가하고 PK 선언
    name NVARCHAR2(20) NOT NULL, 
    tel VARCHAR2(20) NOT NULL,

    address NVARCHAR2(125),
    chain NVARCHAR2(10),
    rem NVARCHAR2(125),
    birth VARCHAR2(10),
    age NUMBER(3)
    
);


INSERT INTO tbl_address(id,name,tel)
VALUES(1,'홍길동','서울특별시');

INSERT INTO tbl_address(id, name,tel)
VALUES(2,'홍길동','서울특별시');

INSERT INTO tbl_address(id,name,tel)
VALUES(3,'홍길동','서울특별시');

INSERT INTO tbl_address(id,name,tel)
VALUES(4,'이몽룡','남원시');

INSERT INTO tbl_address(id,name,tel)
VALUES(5,'성춘향','익산시');

UPDATE tbl_address SET address = '서울특별시'
WHERE id = 1;

UPDATE tbl_address SET address = '광주광역시'
WHERE id = 2;

UPDATE tbl_address SET address = '부산광역시'
WHERE id = 3;

COMMIT;

DELETE FROM tbl_address;

ROLLBACK;


SELECT * FROM tbl_address WHERE name = '성춘향';
SELECT * FROM tbl_address WHERE name = '홍길동';

DELETE FROM tbl_address 
WHERE id = 1;

SELECT * FROM tbl_address;

-- DBMS를 운영하는 과정에서 만헤하나 재난이 발생했을 때 데이터를 복구할 수 있는 준비를 해야 한다
-- 1. 백업: 업무가 종료도니 후 데이터를 다른 저장소, 저장매체에 복사하여 보관하는 것
-- 1-1. 복구: 백업해둔 데이터를 사용중인 시스템에 다시 설치하여 사용할 수 있도록 하고 복구는 원상태로
--            만드는데 상당한 시간이 필요하고 백업된 시점에 따라 오나전복구가 되지 않는 경우도 있다
-- 2. 로그 기록 복구 : INSERT,UPDATE, DELETE 명령이 수행될 때 수행되는 모든 명령들을 별도의 파일로 기록해 두고
--                     문제가 발생했을 때 로그를 다시 역으로 추적하여 복구하는 방법 저널링 복구
-- 3. 이중화, 삼중화
--      실제 운영중인 운영체제,DBMS,storage등을 똑같은 구조로 설치 위치를 달리하여 동시에 운영하는 것
--      재난이 발생하면 발생 지역의 시스템을 단절하고 정상 시스템으로 전환하여 운영을 계속하도록 하는 시스템

-- 데이터센터(데이터웨어 하우스)
--      대량의 데이터베이스를 운영ㅎ하는 서버시스템들을 모아서 통합 관리하는 곳










