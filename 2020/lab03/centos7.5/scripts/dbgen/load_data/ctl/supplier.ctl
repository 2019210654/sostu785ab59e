LOAD DATA INFILE '/home/oracle/dbgen/supplier.tbl' INTO TABLE supplier TRAILING NULLCOLS (
    S_SUPPKEY       terminated by '|',
    S_NAME          terminated by '|',
    S_ADDRESS       terminated by '|',
    S_NATIONKEY     terminated by '|',
    S_PHONE         terminated by '|',
    S_ACCTBAL       terminated by '|',
    S_COMMENT       terminated by '|'
)
