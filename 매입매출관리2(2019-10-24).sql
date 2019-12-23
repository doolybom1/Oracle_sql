-- iolist2 화면
CREATE TABLE tbl_iolist(
    io_seq	NUMBER		PRIMARY KEY,
    io_date	VARCHAR2(10)	NOT NULL,	
    io_pname	NVARCHAR2(25)	NOT NULL,
    io_dname	NVARCHAR2(25)	,	
    io_dceo	NVARCHAR2(25)	,	
    io_input	NVARCHAR2(2),		
    io_qty	NUMBER		,
    io_price	NUMBER	,	
    io_total	NUMBER		
);

