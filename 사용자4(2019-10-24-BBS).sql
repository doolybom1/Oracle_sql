-- 사용자4

/*
    id, bs_id PK
    작성일자, bs_date
    작성시각, bs_time
    작성자, bs_writer
    제목, bs_subject
    내용, bs_text
    조회수, bs_count
*/

CREATE TABLE tbl_bbs(
    bs_id NUMBER PRIMARY KEY,
    bs_date VARCHAR2(10) NOT NULL,
    bs_time VARCHAR2(10) NOT NULL,
    bs_writer NVARCHAR2(20) NOT NULL,
    bs_subjcet NVARCHAR2(125) NOT NULL, 
    bs_text NVARCHAR2(1000) NOT NULL,
    bs_count NUMBER
);