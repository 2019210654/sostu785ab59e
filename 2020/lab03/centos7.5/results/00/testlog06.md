```bash
oracle@FOO:queries$ ./runsql.sh -v stub/06.sql
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
>>> stub/06.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 2 23:45:12 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sat Jan 02 2021 23:45:09 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9  
   REVENUE
----------


Elapsed: 00:00:00.02

Execution Plan
----------------------------------------------------------
Plan hash value: 2287326370

-------------------------------------------------------------------------------
| Id  | Operation	   | Name     | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |	      |     1 |    48 |     2	(0)| 00:00:01 |
|   1 |  SORT AGGREGATE    |	      |     1 |    48 | 	   |	      |
|*  2 |   TABLE ACCESS FULL| LINEITEM |     1 |    48 |     2	(0)| 00:00:01 |
-------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   2 - filter("L_SHIPDATE">=TO_DATE(' 1994-01-01 00:00:00',
	      'syyyy-mm-dd hh24:mi:ss') AND "L_SHIPDATE"<TO_DATE(' 1995-01-01
	      00:00:00', 'syyyy-mm-dd hh24:mi:ss') AND "L_DISCOUNT">=.05 AND
	      "L_DISCOUNT"<=.07 AND "L_QUANTITY"<24)


Statistics
----------------------------------------------------------
	 13  recursive calls
	  7  db block gets
	  5  consistent gets
	  0  physical reads
       1032  redo size
	547  bytes sent via SQL*Net to client
	595  bytes received via SQL*Net from client
	  2  SQL*Net roundtrips to/from client
	  0  sorts (memory)
	  0  sorts (disk)
	  1  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
```
