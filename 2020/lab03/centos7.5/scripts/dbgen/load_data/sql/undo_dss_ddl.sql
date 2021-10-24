-- File: undo_dss_ddl.sql --

select table_name from user_tables;

drop table NATION;
drop table REGION;
drop table PART;
drop table SUPPLIER;
drop table PARTSUPP;
drop table CUSTOMER;
drop table ORDERS;
drop table LINEITEM;

select table_name from user_tables;
