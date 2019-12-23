-- iouser 화면입니다
drop table tbl_iolist;

CREATE VIEW view_iolist 
AS (
select
    IO_SEQ AS IO_SEQ,
IO_DATE AS IO_DATE,
IO_INOUT AS IO_INOUT,
D_CEO AS IO_DCEO,
D_NAME AS D_NAME,
D_CEO AS D_CEO,
IO_PCODE AS IO_PCODE,
P_NAME AS P_NAME,
P_IPRICE AS P_IPRICE,
P_OPRICE AS P_OPRICE,
P_VAT AS P_VAT,
IO_QTY AS IO_QTY,
IO_PRICE AS IO_PRICE,
IO_TOTAL AS IO_TOTAL

FROM tbl_iolist io
    LEFT JOIN tbl_dept d
        ON io.io_dcode = D.d_code
    LEFT JOIN tbl_product p
        ON io.io_pcode = P.p_code
);


select
    IO_SEQ AS IO_SEQ,
IO_DATE AS IO_DATE,
IO_INOUT AS IO_INOUT,
D_CEO AS IO_DCEO,
D_NAME AS D_NAME,
D_CEO AS D_CEO,
IO_PCODE AS IO_PCODE,
P_NAME AS P_NAME,
P_IPRICE AS P_IPRICE,
P_OPRICE AS P_OPRICE,
P_VAT AS P_VAT,
IO_QTY AS IO_QTY,
IO_PRICE AS IO_PRICE,
IO_TOTAL AS IO_TOTAL

FROM tbl_iolist io
    LEFT JOIN tbl_dept d
        ON io.io_dcode = D.d_code
    LEFT JOIN tbl_product p
        ON io.io_pcode = P.p_code