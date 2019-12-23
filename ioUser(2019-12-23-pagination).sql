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
*/
