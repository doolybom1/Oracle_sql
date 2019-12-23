-- iouser
-- pagination을 위한 오라클 SQL
/*
    pagination
    전체레코드를 모두 읽어서 화면에 보여주는 것은 실제상황에서는 매우 비효율적이다
    메모리도 문제가 될 수 있고, 성능면에서도 상당히 여러 문제를 일으킨다
    
    적당한 크기(1page 분량의 리스트)를 읽어들이고 처리를한 후 더 많은 내용을 보고 싶으면
    더보기, 다른 페이지를 선택해서 읽어 들이도록 SQL을 수행한다
    
    MySQL : limit라는 속성으로 매우 편리하게 pagination을 구현할 수 있다
    mssql : offset 과 limit라는 속성
    기타 DBMS : limit, offset과 같은 개념들이 있어서 편하게 구현이 가능하다
    
    오라클은 limit, offset 등을 실질적으로 지원하지 않는다
    오라클은 개발자, DBA가 limit등을 수행하지 않아도 엔진자체에서 optimizer 기능이 있어서 어느정도는 자체 커버가 된다
    
    실제 select * from [table]을 수행하더라도 보통 200개 단위로 구분하여 fetch(읽어들이기)를 수행하는 기능이 담겨있다
    
    select * from [table] order by를 사용할 경우 자체 엔진이 상당히 무리하게 작동을 한다
    하지만, 오라클에서는 order by와 where 절을 같이 사용하지만 않으면 자체 opt 엔진이 나름대로 방법으로 정렬을 수행한다
    
    오라클 pagination에서는 정렬따로, where 따로 만들어서 사용을 한다. sub query를 사용하여 sql을 만든다
*/

-- 표준 sql을 사용한 내림차순 정렬 sql
SELECT * FROM tbl_product ORDER BY p_code DESC;

/*
    INDEX_DESC[table] [index이름]
    [index이름]으로 설정된 인덱스를 사용하여 내림차순 정렬한 후 보여달라
    
    FIRST_ROWS
    우선적으로 앞쪽에 있는 레코드들을 먼저 보여달라
    데이터가 많을때 순서가 앞에 있는 레코드를 먼저 찾는 옵티마이저 알고리즘을 작동시켜라
    where 절에서 ROWNUM의 가상 칼럼값을 N이하
    
*/
-- 오라클의 Hint라는 기능을 사용하여 PK를 기준으로 내림차순 정렬한 sql
-- CURSOR 구현
SELECT /*+ FIRST_ROWS */ ROWNUM, IP.* FROM
(
    SELECT /*+ INDEX_DESC(P) FIRST_ROWS */ * FROM tbl_product P
)IP
WHERE ROWNUM <= 10;

/*
    FIRST_ROWS hint는 무조건 table의 첫번재 레코드부터 최적화 알고리즘을 작동시키도록 구조가 만들어져 있어서 between을 사용하면
    동작하지 않는다
*/
SELECT /*+ FIRST_ROWS */ ROWNUM, IP.* FROM
(
    SELECT /*+ INDEX_DESC(P) FIRST_ROWS */ * FROM tbl_product P
)IP
WHERE ROWNUM <= 100;

-- 사용자에게 입력받아서 테스트하는 코드
-- &변수를 사용하면 쿼리 실행에서 입력창이 나타나서 값을 입력할 수 있다
SELECT * FROM(
    SELECT /*+ FIRST_ROWS_100 */ ROWNUM AS NUM, IP.* FROM
    (
        SELECT /*+ INDEX_DESC(P) FIRST_ROWS */ * FROM tbl_product P
    )IP
    WHERE ROWNUM <= &LAST_NO
) TBL
WHERE NUM >= &FIRST_NO;

