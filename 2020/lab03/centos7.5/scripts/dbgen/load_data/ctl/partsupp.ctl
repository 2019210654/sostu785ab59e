LOAD DATA INFILE '/home/oracle/dbgen/partsupp.tbl' INTO TABLE partsupp TRAILING NULLCOLS (
    PS_PARTKEY      terminated by '|',
    PS_SUPPKEY      terminated by '|',
    PS_AVAILQTY     terminated by '|',
    PS_SUPPLYCOST   terminated by '|',
    PS_COMMENT      terminated by '|'
)
