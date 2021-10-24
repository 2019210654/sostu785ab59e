```bash
oracle@FOO:queries$ ./runsql.sh -v stub/19.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q19)
     4	
     5	select
     6		sum(l_extendedprice* (1 - l_discount)) as revenue
     7	from
     8		lineitem,
     9		part
    10	where
    11		(
    12			p_partkey = l_partkey
    13			and p_brand = 'Brand#12'
    14			and p_container in ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG')
    15			and l_quantity >= 1 and l_quantity <= 1 + 10
    16			and p_size between 1 and 5
    17			and l_shipmode in ('AIR', 'AIR REG')
    18			and l_shipinstruct = 'DELIVER IN PERSON'
    19		)
    20		or
    21		(
    22			p_partkey = l_partkey
    23			and p_brand = 'Brand#23'
    24			and p_container in ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK')
    25			and l_quantity >= 10 and l_quantity <= 10 + 10
    26			and p_size between 1 and 10
    27			and l_shipmode in ('AIR', 'AIR REG')
    28			and l_shipinstruct = 'DELIVER IN PERSON'
    29		)
    30		or
    31		(
    32			p_partkey = l_partkey
    33			and p_brand = 'Brand#34'
    34			and p_container in ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG')
    35			and l_quantity >= 20 and l_quantity <= 20 + 10
    36			and p_size between 1 and 15
    37			and l_shipmode in ('AIR', 'AIR REG')
    38			and l_shipinstruct = 'DELIVER IN PERSON'
    39		);
    40	--where rownum <= -1;
>>> stub/19.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 2 23:45:53 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sat Jan 02 2021 23:45:50 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28   29   30   31   32   33   34   35  
   REVENUE
----------


Elapsed: 00:00:00.04

Execution Plan
----------------------------------------------------------
Plan hash value: 3423467992

--------------------------------------------------------------------------------
| Id  | Operation	    | Name     | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------
|   0 | SELECT STATEMENT    |	       |     1 |   141 |     4	 (0)| 00:00:01 |
|   1 |  SORT AGGREGATE     |	       |     1 |   141 |	    |	       |
|*  2 |   HASH JOIN	    |	       |     1 |   141 |     4	 (0)| 00:00:01 |
|*  3 |    TABLE ACCESS FULL| LINEITEM |     1 |    91 |     2	 (0)| 00:00:01 |
|*  4 |    TABLE ACCESS FULL| PART     |     1 |    50 |     2	 (0)| 00:00:01 |
--------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("P_PARTKEY"="L_PARTKEY")
       filter("P_BRAND"='Brand#12' AND ("P_CONTAINER"='SM BOX' OR
	      "P_CONTAINER"='SM CASE' OR "P_CONTAINER"='SM PACK' OR "P_CONTAINER
"='SM

	      PKG') AND "L_QUANTITY">=1 AND "L_QUANTITY"<=11 AND "P_SIZE"<=5 OR
	      "P_BRAND"='Brand#23' AND ("P_CONTAINER"='MED BAG' OR "P_CONTAINER"
='MED

	      BOX' OR "P_CONTAINER"='MED PACK' OR "P_CONTAINER"='MED PKG') AND
	      "L_QUANTITY">=10 AND "L_QUANTITY"<=20 AND "P_SIZE"<=10 OR
	      "P_BRAND"='Brand#34' AND ("P_CONTAINER"='LG BOX' OR "P_CONTAINER"=
'LG

	      CASE' OR "P_CONTAINER"='LG PACK' OR "P_CONTAINER"='LG PKG') AND
	      "L_QUANTITY">=20 AND "L_QUANTITY"<=30 AND "P_SIZE"<=15)
   3 - filter(("L_QUANTITY"<=30 AND "L_QUANTITY">=20 OR
	      "L_QUANTITY"<=20 AND "L_QUANTITY">=10 OR "L_QUANTITY"<=11 AND
	      "L_QUANTITY">=1) AND "L_SHIPINSTRUCT"='DELIVER IN PERSON' AND
	      ("L_SHIPMODE"='AIR' OR "L_SHIPMODE"='AIR REG'))
   4 - filter("P_SIZE">=1 AND ("P_SIZE"<=15 AND "P_BRAND"='Brand#34'
	      AND ("P_CONTAINER"='LG BOX' OR "P_CONTAINER"='LG CASE' OR
	      "P_CONTAINER"='LG PACK' OR "P_CONTAINER"='LG PKG') OR "P_SIZE"<=10
 AND

	      "P_BRAND"='Brand#23' AND ("P_CONTAINER"='MED BAG' OR "P_CONTAINER"
='MED

	      BOX' OR "P_CONTAINER"='MED PACK' OR "P_CONTAINER"='MED PKG') OR
	      "P_SIZE"<=5 AND "P_BRAND"='Brand#12' AND ("P_CONTAINER"='SM BOX' O
R

	      "P_CONTAINER"='SM CASE' OR "P_CONTAINER"='SM PACK' OR "P_CONTAINER
"='SM

	      PKG')))


Statistics
----------------------------------------------------------
	 27  recursive calls
	 12  db block gets
	 14  consistent gets
	  0  physical reads
       1908  redo size
	547  bytes sent via SQL*Net to client
       1309  bytes received via SQL*Net from client
	  2  SQL*Net roundtrips to/from client
	  0  sorts (memory)
	  0  sorts (disk)
	  1  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
```
