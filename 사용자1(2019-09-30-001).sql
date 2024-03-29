-- 여기는 user1 화면입니다
-- 테이블 생성
-- 테이블은 java의 VO와 같은 개념의 데이터 저장소
-- VO에 담긴 데이터들을 영구저장소에 보관하여
-- 차후 데이터를 추출하여 사용

-- tlb_test : 저장소의 이름 = table명이라고 한다
-- 각 요소들 : 칼럼, java에서 필드변수 개념
-- 칼럼명 type 제약조건
CREATE TABLE tbl_test (
    num NVARCHAR2(20) NOT NULL UNIQUE PRIMARY KEY,
    name NVARCHAR2(50) NOT NULL,
    age NUMBER(3) NOT NULL
);

-- 필요없어진 table을 삭제
-- 테이블을 영구적으로 물리저장소로부터 삭제
-- 삭제하면 데이터가 모두 손실되므로 신중하게 명령어를 수행해야함
DROP TABLE tbl_test;