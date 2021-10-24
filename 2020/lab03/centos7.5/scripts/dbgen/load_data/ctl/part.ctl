LOAD DATA INFILE '/home/oracle/dbgen/part.tbl' INTO TABLE part TRAILING NULLCOLS (
    P_PARTKEY       terminated by '|',
    P_NAME          terminated by '|',
    P_MFGR          terminated by '|',
    P_BRAND         terminated by '|',
    P_TYPE          terminated by '|',
    P_SIZE          terminated by '|',
    P_CONTAINER     terminated by '|',
    P_RETAILPRICE   terminated by '|',
    P_COMMENT       terminated by '|'
)
