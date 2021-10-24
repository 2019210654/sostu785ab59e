LOAD DATA INFILE '/home/oracle/dbgen/region.tbl' INTO TABLE region (
    R_REGIONKEY terminated by '|',
    R_NAME      terminated by '|',
    R_COMMENT   terminated by '|'
)
