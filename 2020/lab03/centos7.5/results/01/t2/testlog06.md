```
# Results of running 06.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q6)
     4	
     5	select
     6		sum(l_extendedprice * l_discount) as revenue
     7	from
     8		lineitem
     9	where
    10		l_shipdate >= date '1994-01-01'
    11		and l_shipdate < date '1994-01-01' + interval '1' year
    12		and l_discount between .06 - 0.01 and .06 + 0.01
    13		and l_quantity < 24;
    14	--where rownum <= -1;
>>> dbgen/queries/stub/06.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jan 3 02:23:21 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sun Jan 03 2021 02:23:18 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9  
   REVENUE
----------
 123141078

Elapsed: 00:00:01.42

Execution Plan
----------------------------------------------------------
Plan hash value: 2287326370

-------------------------------------------------------------------------------
| Id  | Operation	   | Name     | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |	      |     1 |    20 | 29625	(1)| 00:00:02 |
|   1 |  SORT AGGREGATE    |	      |     1 |    20 | 	   |	      |
|*  2 |   TABLE ACCESS FULL| LINEITEM |   109K|  2131K| 29625	(1)| 00:00:02 |
-------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   2 - filter("L_SHIPDATE"<TO_DATE(' 1995-01-01 00:00:00', 'syyyy-mm-dd
	      hh24:mi:ss') AND "L_QUANTITY"<24 AND "L_DISCOUNT">=.05 AND
	      "L_SHIPDATE">=TO_DATE(' 1994-01-01 00:00:00', 'syyyy-mm-dd hh24:mi
:ss')

	      AND "L_DISCOUNT"<=.07)


Statistics
----------------------------------------------------------
	  1  recursive calls
	  0  db block gets
     108299  consistent gets
	  0  physical reads
	  0  redo size
	555  bytes sent via SQL*Net to client
	595  bytes received via SQL*Net from client
	  2  SQL*Net roundtrips to/from client
	  0  sorts (memory)
	  0  sorts (disk)
	  1  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
# 06.sql:20210103022321:20210103022323:1609658602:1609658604:2 #
```
