LOAD DATA INFILE '/home/oracle/dbgen/lineitem.tbl' INTO TABLE lineitem fields terminated by "|" TRAILING NULLCOLS (
        L_ORDERKEY      terminated by "|" ,
        L_PARTKEY       terminated by "|",
        L_SUPPKEY       terminated by "|",
        L_LINENUMBER    terminated by "|",
        L_QUANTITY      terminated by "|",
        L_EXTENDEDPRICE terminated by "|",
        L_DISCOUNT      terminated by "|",
        L_TAX           terminated by "|",
        L_RETURNFLAG    CHAR(3),
        L_LINESTATUS    CHAR(3),
        L_SHIPDATE      DATE "YYYY-MM-DD",
        L_COMMITDATE    DATE "YYYY-MM-DD",
        L_RECEIPTDATE   DATE "YYYY-MM-DD",
        L_SHIPINSTRUCT  CHAR(25),
        L_SHIPMODE      CHAR(10),
        L_COMMENT       CHAR(44)
)
