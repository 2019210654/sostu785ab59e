```bash
oracle@FOO:queries$ ./runsql.sh -v stub/12.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q12)
     4	
     5	select
     6		l_shipmode,
     7		sum(case
     8			when o_orderpriority = '1-URGENT'
     9				or o_orderpriority = '2-HIGH'
    10				then 1
    11			else 0
    12		end) as high_line_count,
    13		sum(case
    14			when o_orderpriority <> '1-URGENT'
    15				and o_orderpriority <> '2-HIGH'
    16				then 1
    17			else 0
    18		end) as low_line_count
    19	from
    20		orders,
    21		lineitem
    22	where
    23		o_orderkey = l_orderkey
    24		and l_shipmode in ('MAIL', 'SHIP')
    25		and l_commitdate < l_receiptdate
    26		and l_shipdate < l_commitdate
    27		and l_receiptdate >= date '1994-01-01'
    28		and l_receiptdate < date '1994-01-01' + interval '1' year
    29	group by
    30		l_shipmode
    31	order by
    32		l_shipmode;
    33	--where rownum <= -1;
>>> stub/12.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 2 23:45:31 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sat Jan 02 2021 23:45:28 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28  
no rows selected

Elapsed: 00:00:00.03

Execution Plan
----------------------------------------------------------
Plan hash value: 3706227421

--------------------------------------------------------------------------------
| Id  | Operation	    | Name     | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------
|   0 | SELECT STATEMENT    |	       |     1 |    82 |     5	(20)| 00:00:01 |
|   1 |  SORT GROUP BY	    |	       |     1 |    82 |     5	(20)| 00:00:01 |
|*  2 |   HASH JOIN	    |	       |     1 |    82 |     4	 (0)| 00:00:01 |
|   3 |    TABLE ACCESS FULL| ORDERS   |     1 |    30 |     2	 (0)| 00:00:01 |
|*  4 |    TABLE ACCESS FULL| LINEITEM |     1 |    52 |     2	 (0)| 00:00:01 |
--------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("O_ORDERKEY"="L_ORDERKEY")
   4 - filter("L_COMMITDATE"<"L_RECEIPTDATE" AND
	      "L_SHIPDATE"<"L_COMMITDATE" AND "L_RECEIPTDATE">=TO_DATE(' 1994-01
-01

	      00:00:00', 'syyyy-mm-dd hh24:mi:ss') AND "L_RECEIPTDATE"<TO_DATE('


	      1995-01-01 00:00:00', 'syyyy-mm-dd hh24:mi:ss') AND
	      "L_COMMITDATE"<TO_DATE(' 1995-01-01 00:00:00', 'syyyy-mm-dd
	      hh24:mi:ss') AND "L_SHIPDATE"<TO_DATE(' 1995-01-01 00:00:00',
	      'syyyy-mm-dd hh24:mi:ss') AND ("L_SHIPMODE"='MAIL' OR
	      "L_SHIPMODE"='SHIP'))


Statistics
----------------------------------------------------------
	 18  recursive calls
	  7  db block gets
	  9  consistent gets
	  0  physical reads
       1072  redo size
	523  bytes sent via SQL*Net to client
	924  bytes received via SQL*Net from client
	  1  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
	  0  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
```
