-- github에 프로젝트를 업로드할 때
-- 불필요한 파일이나 비밀번호가 입력된 파일 등 업로드를 하지 않아야 될 파일들은
-- git 폴더에 .gitignore 파일을 생성하고 파일의 이름, 폴더 이름들을 기록해 주면 된다
-- data/ 라고 기록하면 git 폴더 아래에 data 폴더의 모든 파일을 업로드 되지 않는다
-- 단, 최초의 프로젝트를 올릴 때 .gitignore를 먼저 설정해 두어야 한다
-- 이미 업로드가 된 파일이나 폴더는 삭제하기가 매우 까다롭다

-- tbl_student 테이블에 데이터를 추가하고, 조회하기

SELECT * FROM tbl_student;

DELETE FROM tbl_student;

INSERT INTO tbl_student(st_num, st_name, st_tel, st_addr, st_age, st_dept)
VALUES('A0001', '홍길동','010-111-1234','서울시','33','컴공과');

INSERT INTO tbl_student(st_num, st_name,st_tel,st_addr,st_age,st_dept)
VALUES('A0002', '성춘향','010-111-2345','서울시','33','컴공과');

INSERT INTO tbl_student(st_num, st_name,st_tel,st_addr,st_age,st_dept)
VALUES('A0003', '이몽룡','010-111-3456','서울시','33','컴공과');

INSERT INTO tbl_student(st_num, st_name,st_tel,st_addr,st_age,st_dept)
VALUES('A0004', '장보고','010-111-4567','서울시','33','컴공과');

INSERT INTO tbl_student(st_num, st_name,st_tel,st_addr,st_age,st_dept)
VALUES('A0005', '임꺽정','010-111-5678','서울시','33','컴공과');

-- 데이터 입력시 순서대로 데이터를 넣어야함
INSERT INTO tbl_student(st_num, st_name,st_tel,st_addr,st_age,st_dept)
VALUES('A0006', '임꺽정','함경도','010-222-6666','33','컴공과');

DELETE FROM tbl_student
WHERE st_num = 'A0006';

-- 1. 모든 데이터를 조건없이 보여라
SELECT * FROM tbl_student;

-- 2. tbl_student에서 학번,이름,주소 전화번호 칼럼만 리스트에 보이면 좋겠다
SELECT st_num, St_name, st_addr,st_tel FROM tbl_student;

-- 3. 이름, 학번, 주소, 전화번호, 주소 순서로 칼럼을 리스트에 보이면 좋겠다
SELECT st_name, st_num, st_addr,st_tel FROM tbl_student;

-- 4. 리스트를 볼 때 원래의 칼럼이름 대신에 별명 사용하기

-- 표준SQL
SELECT st_num AS 학번, st_name AS 이름, st_tel AS 전화번호, st_addr AS 주소
FROM tbl_student;

-- 오라클SQL
SELECT st_num 학번, st_name 이름, st_tel 전화번호, st_addr 주소
FROM tbl_student;

-- 데이터 리스트(row, recored) 중에서 필요한 부분만 보고 싶을때
-- 1. tbl_student에 보관중인 데이터 중에서 이름이 '홍길동'인 리스트만 보고싶다
SELECT * FROM tbl_student
WHERE st_name = '홍길동';

SELECT st_num, st_name, st_tel FROM tbl_student
WHERE st_name = '홍길동';

-- SELECT 명령문을 사용할 때
-- 칼럼리스트 * 로 사용하지 않고 필요한 칼럼만 나열해 주는 것이 많은 양의 데이터를 조회할때는 속도면에서 다소 유리하다
SELECT * FROM tbl_student;

-- projection : 칼럼리스트를 나열하는 것
SELECT st_num, st_name, st_tel, st_addr,_st_grade, st_dept, st_age FROM tbl_student;

-- 학생테이블에서 이름이 홍길동이고 주소가 서울특별시인 데이터만 보고 싶다
-- 다중조건 조회
-- AND 조건 : 여러 조건이 모두 true인 리스트만 보여라
SELECT * FROM tbl_student
WHERE st_name = '홍길동' and st_addr = '서울시';

-- 학생테이블에서 이름이 홍길동이거나 이몽룡인 데이터들을 보고 싶다
-- OR 조건 : 여러 조건중에 한가지라도 true인 리스트를 보여라
SELECT * FROM tbl_student
WHERE st_name = '홍길동' OR st_name = '이몽룡';

-- 칼럼값들을 서로 연결해서 한개의 문자열처럼 리스트를 보는 방법
SELECT st_num || '+' || st_name || '+' || st_tel AS 칼럼
FROM tbl_student;

SELECT st_num || ':' || st_name || ':' || st_tel AS 칼럼
FROM tbl_student;

-- 문자열 칼럼에 저장된 값의 일부분만 조건으로 설정하는 방법
-- 데이터를 추가하면서 주소를 어떤 데이터는 '서울특별시'라고 하고 어떤 데이터는 '서울시'라고 했다
-- 이럴경우 서울특별시라고 조회를 하면 서울시인 데이터는 보이지 않고
-- 서울시라고 조회를 하면 서울특별시 데이터는 보이지 않게 된다
-- 이럴때 '서울'이라는 문자열이 포함된 데이터만 보고 싶을때
-- 부분 문자열 조건 조회라는 방법을 사용
SELECT * FROM tbl_student
WHERE st_addr LIKE '서울%';

SELECT * FROM tbl_student
WHERE st_addr LIKE '%시';

UPDATE tbl_student SET st_addr='해남군'
WHERE st_name = '이몽룡';

SELECT * FROM tbl_student;

SELECT * FROM tbl_student
WHERE st_name LIKE '%길%';

-- LIKE 연산자키워드
-- SELECT 조회 명령이 실행될 때 데이터 많으면 매우 속도가 느려진다
-- INDEX 라던가 기법들을 사용하여 SELECT 속도를 높이려고 만든 것들이 무력화 되어 버린다

SELECT * FROM tbl_student
WHERE st_tel >= '010-111-1111' AND st_tel <= '010-111-4000';


-- 학생데이터를 조회하고 싶은데 이름을 알지 못하고, 학번이 3번부터 6번 사이에 있었던 것 같다
-- 이럴때 학번 데이터는 문자열이지만 전장된 구조가 5자리로 일정하므로 비교연산자를 사용하여 데이터를 조회해 볼 수 있다
SELECT * FROM tbl_student
WHERE st_num >= 'A0003' AND st_num < 'A0006';

-- 어떤 범위내에 있는 데이터 리스트를 보고자 할때 BETWEEN 사용
SELECT * FROM tbl_student
WHERE st_num BETWEEN 'A0003' AND 'A0006';

-- 주소가 서울시, 남원시인 모든 데이터를 보고자 할때

SELECT * FROM tbl_student
WHERE st_addr IN('남원시', '서울시', '해남군');

SELECT st_name, st_tel, st_addr, st_grade, st_age, st_num, st_dept FROM tbl_student;
SELECT st_num, st_name, st_tel, st_addr,_st_grade, st_dept, st_age FROM tbl_student;

-- DBMS의 임시저장소에 임시로 저장된 데이터를 storage에 저장하는 명령
-- DCL 명령, TCL(Transaction Controll Language)
COMMIT;

SELECT * FROM tbl_student;