
create table tbl_files(
    file_seq NUMBER PRIMARY KEY,
	file_p_code VARCHAR2(5),
    file_origin_name nVARCHAR2(255),
    file_upload_name nVARCHAR2(255)
);
drop table tbl_fils;


create SEQUENCE seq_files
START WITH 1 INCREMENT by 1;

select FILE_SEQ,FILE_P_CODE,FILE_ORIGIN_NAME,FILE_UPLOAD_NAME from tbl_files;

insert into tbl_files
select 16,'P0001','2019.jpg','10202020-2019.jpg' from dual;
insert into tbl_files
select 17,'P0001','2019.jpg','10202020-2019.jpg' from dual;
insert into tbl_files
select 18,'P0001','2019.jpg','10202020-2019.jpg' from dual;

select * from tbl_files;

delete from tbl_Files;

select * from tbl_product, tbl_files
where p_code = file_p_code;

commit;