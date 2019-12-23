SELECT * FROM tbl_books;

/*
PRIMARY KEY
개체(객체) 무결성을 보장하기 위해 사용하는 중요한 요소

개체 무결성
1. 내가 어떤 데이터를 조회했을 때 나타나는 데이터는 내가 필요로 했던 테이터이다라는 보장
2. PK를 WHERE 조건으로 SELECT 했을 때 나나타는 데이터는 1개의 레코드이며 이 데이터는 내가 원하는 데이터이다라는 보장
3. PK는 1개의 칼럼을 지정하는 것이 원칙이지만 실제 상황에서 1개의 칼럼만으로 PK를 지정하지 못하는 경우가 있다.
   이럴때는 2개 이상의 복수 칼럼을 묶어서 PK로 지정하는 경우도 있다.
4. 복수의 칼럼을 PK로 지정하는 경우
   UPDATE, DELETE를 수행할때 PK를 WHERE 조건으로 명령을 수행할때 상당히 번잡한 SQL을 구성해야 하는 경우도 있다.
   
5. PK로 지정할 칼럼이 없는 경우에는 새로운 칼럼을 하나 추가하고 그 칼럼을 PK로 지정하는 방법도 있다.
   EX) 코드 칼럼
6. 'ID' 칼럼은 보편적인 DBMS에서는 최대 자릿수를 갖는 숫자형으로 지정하고 해당 칼럼에 AUTO INCREMENT라는 옵션을 지정하여
   INSERT를 수행할때마다 자도응로 새로운 숫자값이 생성되도록 할 수 있다. 하지만, 오라클 11이하에서는 AUTO INCREMENT 
   옵션이 없어서 여러가지 방법으로 사용한다

   그중 가장 많이 사용하는 방법이 SEQUENCE Object를 생성하고 SEQUENCE의 NEXTVAL 값을 활용하여 데이터를 추가할때 
   ID칼럼에 새로운 값이 만들어져 저장되도록 사용한다

   오라클의 SEQ는 한번 생성을 하면 현재상태를 영구히 보관하고 있다가 언제든지 NEXTVAL을 호출하면 
   현재상태 + (INCREMENT BY로 지정한 값만큼) 연산을 수행하여 새로운 값을 만들어 낸다.

*/

/*
    오라클에서 RANDOM, SEQ외에 사용할 수 있는 PK값 생성하기
    GUID
    Global Unique IDENTIFIED 범 우주적으로 유일한 값
    
    오라클에서는 GUID를 저장할 칼럼의 데이터 형식을 RAW(무한히 크기 제한이 없는 바이너리 형태) 값으로 지정하거나
    NVARCHAR2(125) 이상으로 지정해서 사용한다
*/
SELECT SYS_GUID() FROM DUAL;

INSERT INTO tbl_books(b_code, b_name)
VALUES(SYS_GUID(), 'GUID 연습');


/*
자주 SELECT를 수행하는 칼럼이 있을경우
해당 칼럼을 INDEX라는 OBJECT로 생성을 해두면 SELECT를 수행할때 INDEX를 먼저 조회하고 INDEX로부터 해당 데이터가
저장된 RECORD의 주소를 얻고 주소를 통해서 TABLE로부터 데이터를 가져와서 SELECT(조회) 수행속도 효율을 높이는 기법

TABLE을 생성할때 PK로 지정하면 PK 칼럼은 기본적으로 INDEX로 설정이 됨
*/

CREATE INDEX IDX_NAME ON tbl_books(b_name);
SELECT * FROM tbl_books WHERE b_name = '자바';

-- DBMS 업무중에 b_name과 b_writer를 조건으로 하는 SELECT문을 자주 수행한다라면 INDEX 로 지정해서 사용할 수 있다
SELECT * FROM tbl_books WHERE b_name = '자바' AND b_writer = '홍길동';
CREATE INDEX IDX_NAME_WRITER ON tbl_books(b_name, b_writer);
DROP INDEX IDX_NAME_WRITER;


/*
INDEX는 SELECT를 수행하는데 매우 효율적으로 작동되는 구조이다
하지만 개발초기에 많은 양의 데이터를 INSERT를 수행해야 할 경우에는 INDEX를 일단 설정하지 말고 사용하는 것이 효율적이다

초기 데이터를 추가할 때 가급적이면 PK로 설정된 칼럼을 기준으로 정렬된 원본 데이터로 INSERT를 수행하는 것이 효율적이다

INDEX를 필요이상으로 많이 설정하면 INSERT, UPDATE를 수행할때 비효율적으로 작동될 수 있고
INDEX OBJECT가 문제를 일으키는 상황도 만들어질 수 있다

INDEX는 최소한으로 만들어라
*/
DROP INDEX IDX_NAME;

-- UNIQUE INDEX
-- 마치 TABLE을 생성할 때 해당하는 칼럼에 UNIQUE 제약조건을 설정한 것처럼 작동이 된다.
-- 기존에 저장되어 잇는 데이터가 UNIQUE 상태가 아니면 인덱스가 생성되지 않는다
CREATE UNIQUE INDEX IDX_NAME ON tbl_books(b_name);

-- INDEX가 손상된 것 같다. DROP 후 CREATE 실행
-- 상용 DBMS에서는 INDEX가 손상되면 DBMS 자체적으로 Rebuild하는 기능이 포함되어 있다