```bash
oracle@FOO:queries$ ./runsql.sh -v stub/04.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q4)
     4	
     5	select
     6		o_orderpriority,
     7		count(*) as order_count
     8	from
     9		orders
    10	where
    11		o_orderdate >= date '1993-07-01'
    12		and o_orderdate < date '1993-07-01' + interval '3' month
    13		and exists (
    14			select
    15				*
    16			from
    17				lineitem
    18			where
    19				l_orderkey = o_orderkey
    20				and l_commitdate < l_receiptdate
    21		)
    22	group by
    23		o_orderpriority
    24	order by
    25		o_orderpriority;
    26	--where rownum <= -1;
>>> stub/04.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 2 23:45:06 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sat Jan 02 2021 23:45:03 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21  
no rows selected

Elapsed: 00:00:00.03

Execution Plan
----------------------------------------------------------
Plan hash value: 168290725

--------------------------------------------------------------------------------
| Id  | Operation	    | Name     | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------
|   0 | SELECT STATEMENT    |	       |     1 |    70 |     5	(20)| 00:00:01 |
|   1 |  SORT GROUP BY	    |	       |     1 |    70 |     5	(20)| 00:00:01 |
|*  2 |   HASH JOIN SEMI    |	       |     1 |    70 |     4	 (0)| 00:00:01 |
|*  3 |    TABLE ACCESS FULL| ORDERS   |     1 |    39 |     2	 (0)| 00:00:01 |
|*  4 |    TABLE ACCESS FULL| LINEITEM |     1 |    31 |     2	 (0)| 00:00:01 |
--------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("L_ORDERKEY"="O_ORDERKEY")
   3 - filter("O_ORDERDATE">=TO_DATE(' 1993-07-01 00:00:00',
	      'syyyy-mm-dd hh24:mi:ss') AND "O_ORDERDATE"<TO_DATE(' 1993-10-01
	      00:00:00', 'syyyy-mm-dd hh24:mi:ss'))
   4 - filter("L_COMMITDATE"<"L_RECEIPTDATE")


Statistics
----------------------------------------------------------
	 18  recursive calls
	 17  db block gets
	 10  consistent gets
	  0  physical reads
       3164  redo size
	440  bytes sent via SQL*Net to client
	692  bytes received via SQL*Net from client
	  1  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
	  0  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
```
