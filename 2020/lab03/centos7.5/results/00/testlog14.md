```bash
oracle@FOO:queries$ ./runsql.sh -v stub/14.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q14)
     4	
     5	select
     6		100.00 * sum(case
     7			when p_type like 'PROMO%'
     8				then l_extendedprice * (1 - l_discount)
     9			else 0
    10		end) / sum(l_extendedprice * (1 - l_discount)) as promo_revenue
    11	from
    12		lineitem,
    13		part
    14	where
    15		l_partkey = p_partkey
    16		and l_shipdate >= date '1995-09-01'
    17		and l_shipdate < date '1995-09-01' + interval '1' month;
    18	--where rownum <= -1;
>>> stub/14.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 2 23:45:37 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sat Jan 02 2021 23:45:34 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13  
PROMO_REVENUE
-------------


Elapsed: 00:00:00.02

Execution Plan
----------------------------------------------------------
Plan hash value: 3423467992

--------------------------------------------------------------------------------
| Id  | Operation	    | Name     | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------
|   0 | SELECT STATEMENT    |	       |     1 |    75 |     4	 (0)| 00:00:01 |
|   1 |  SORT AGGREGATE     |	       |     1 |    75 |	    |	       |
|*  2 |   HASH JOIN	    |	       |     1 |    75 |     4	 (0)| 00:00:01 |
|*  3 |    TABLE ACCESS FULL| LINEITEM |     1 |    48 |     2	 (0)| 00:00:01 |
|   4 |    TABLE ACCESS FULL| PART     |     1 |    27 |     2	 (0)| 00:00:01 |
--------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("L_PARTKEY"="P_PARTKEY")
   3 - filter("L_SHIPDATE">=TO_DATE(' 1995-09-01 00:00:00',
	      'syyyy-mm-dd hh24:mi:ss') AND "L_SHIPDATE"<TO_DATE(' 1995-10-01
	      00:00:00', 'syyyy-mm-dd hh24:mi:ss'))


Statistics
----------------------------------------------------------
	 10  recursive calls
	  0  db block gets
	  7  consistent gets
	  0  physical reads
	  0  redo size
	553  bytes sent via SQL*Net to client
	685  bytes received via SQL*Net from client
	  2  SQL*Net roundtrips to/from client
	  0  sorts (memory)
	  0  sorts (disk)
	  1  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
```
