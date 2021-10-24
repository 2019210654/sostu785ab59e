LOAD DATA INFILE '/home/oracle/dbgen/orders.tbl' INTO TABLE orders fields terminated by "|" TRAILING NULLCOLS (
    O_ORDERKEY      terminated by '|',
    O_CUSTKEY       terminated by '|',
    O_ORDERSTATUS   terminated by '|',
    O_TOTALPRICE    terminated by '|',
    O_ORDERDATE     DATE "YYYY-MM-DD",
    O_ORDERPRIORITY terminated by '|',
    O_CLERK         terminated by '|',
    O_SHIPPRIORITY  terminated by '|',
    O_COMMENT       terminated by '|'
)
