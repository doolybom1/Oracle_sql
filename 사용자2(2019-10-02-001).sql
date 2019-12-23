-- 여기는 user2 화면입니다

UPDATE tbl_address SET age = 33
WHERE id = 5;

UPDATE tbl_address SET age = 0
WHERE id = 4;

SELECT * FROM tbl_address 
WHERE age IS NULL;

SELECT * FROM tbl_address
WHERE age IS NOT NULL;

-- 오라클에서는 '' 중간에 빈칸 등 아무런 문자열이 없는 형태는 NULL과 같은 의미로 본다
UPDATE tbl_address SET chain = ''
WHERE id =3;

--  1개 이상의 space 문자열이 저장되어 있는 것을 WHIETE SPACE라고 한다
UPDATE tbl_address SET chain = ' '
WHERE id =3;

SELECT * FROM tbl_address WHERE address IS NULL;
SELECT * FROM tbl_address WHERE address IS NOT NULL;

UPDATE tbl_address SET chain = '001'
WHERE id = 1;
UPDATE tbl_address SET chain = '001'
WHERE id = 2;
UPDATE tbl_address SET chain = '002'
WHERE id = 3;
UPDATE tbl_address SET chain = '003'
WHERE id = 4;
UPDATE tbl_address SET chain = '003'
WHERE id = 5;

-- 001은 가족, 002는 친구, 003은 이웃
-- 이 SQL에서 만일 '관계' 항목에 NULL값이 존재한다는 것은 chain칼럼에 값이 잘못 입력되었거나
-- 조건식이 잘못되었거나 한 경우가 된다
SELECT id ,name,address,chain,
    DECODE(chain, '001', '가족',
        DECODE(chain,'002','친구',
            DECODE(chain,'003','이웃'))) AS 관계
FROM tbl_address
WHERE DECODE(chain, '001', '가족',
        DECODE(chain,'002','친구',
            DECODE(chain,'003','이웃'))) IS NULL;
 
 
-- 테스트를 위해서 아래 SQL문을 수행하며너서 chain 칼럼에 값을 101로 저장했다
-- 그리고 위의 SELECT SQL을 수행했더니 1개의 레코드가 보였다
-- 결국 chain 칼럼에 데이터는 모두 NULL값이 아닌 상태이어서 값이 저장은 되어 있지만
-- 원하지 않은 값이 저장되어 있음을 알 수 있다
INSERT INTO tbl_address ( id,name,tel,chain)
VALUES(6,'장보고','010-777-7777','101');

-- 리스트를 보이는데 보여지는 칼럼의 순서를 id, name, tel, address, chain, birth, age
-- projection(칼럼들의 나열)을 원하는 순서대로 보고자 할때는 SELECT 키워드에 칼럼 리스트를 나열해 주어야 한다
SELECT id, name, tel, address, chain, birth, age
FROM tbl_address;

INSERT INTO tbl_address(id,name,tel)
VALUES (10,'조덕배','010-222-2222');

INSERT INTO tbl_address(id,name,tel)
VALUES (9,'조용필','010-333-3333');

INSERT INTO tbl_address(id,name,tel)
VALUES (8,'양희은','010-123-1234');

SELECT * FROM tbl_address
ORDER BY tel;

-- 처음 name 컬럼을 기준으로 정려을 해주고 나서 같은 리스트가 2개 이상보이면 address 컬럼을 정렬
SELECT * FROM tbl_address
ORDER BY name, address;

SELECT * FROM tbl_address
ORDER BY name DESC, address;

SELECT * FROM tbl_address
ORDER BY id,name,address,tel,chain,rem,birth,age;

COMMIT;



SELECT * FROM tbl_address;
