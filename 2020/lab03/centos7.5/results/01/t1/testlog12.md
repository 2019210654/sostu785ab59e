```
# Results of running 12.sql
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
>>> dbgen/queries/stub/12.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jan 3 01:17:52 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sun Jan 03 2021 01:17:51 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28  
L_SHIPMODE HIGH_LINE_COUNT LOW_LINE_COUNT
---------- --------------- --------------
MAIL		      6202	     9324
SHIP		      6200	     9262

Elapsed: 00:00:01.94

Execution Plan
----------------------------------------------------------
Plan hash value: 1376789630

--------------------------------------------------------------------------------
--

| Id  | Operation	      | Name	 | Rows  | Bytes | Cost (%CPU)| Time
 |

--------------------------------------------------------------------------------
--

|   0 | SELECT STATEMENT      | 	 |     2 |   130 | 36262   (1)| 00:00:02
 |

|   1 |  SORT GROUP BY	      | 	 |     2 |   130 | 36262   (1)| 00:00:02
 |

|*  2 |   HASH JOIN	      | 	 |  8393 |   532K| 36261   (1)| 00:00:02
 |

|   3 |    VIEW 	      | VW_GBF_5 |  8276 |   347K| 29638   (1)| 00:00:02
 |

|   4 |     HASH GROUP BY     | 	 |  8276 |   331K| 29638   (1)| 00:00:02
 |

|*  5 |      TABLE ACCESS FULL| LINEITEM |  8276 |   331K| 29637   (1)| 00:00:02
 |

|   6 |    TABLE ACCESS FULL  | ORDERS	 |  1500K|    31M|  6619   (1)| 00:00:01
 |

--------------------------------------------------------------------------------
--


Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("O_ORDERKEY"="ITEM_1")
   5 - filter("L_COMMITDATE"<"L_RECEIPTDATE" AND
	      "L_RECEIPTDATE"<TO_DATE(' 1995-01-01 00:00:00', 'syyyy-mm-dd hh24:
mi:ss')

	      AND "L_COMMITDATE"<TO_DATE(' 1995-01-01 00:00:00', 'syyyy-mm-dd
	      hh24:mi:ss') AND "L_SHIPDATE"<TO_DATE(' 1995-01-01 00:00:00',
	      'syyyy-mm-dd hh24:mi:ss') AND "L_SHIPDATE"<"L_COMMITDATE" AND
	      "L_RECEIPTDATE">=TO_DATE(' 1994-01-01 00:00:00', 'syyyy-mm-dd
	      hh24:mi:ss') AND ("L_SHIPMODE"='MAIL' OR "L_SHIPMODE"='SHIP'))


Statistics
----------------------------------------------------------
	 10  recursive calls
	  0  db block gets
     132441  consistent gets
	  0  physical reads
	  0  redo size
	806  bytes sent via SQL*Net to client
	935  bytes received via SQL*Net from client
	  2  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
	  2  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
# 12.sql:20210103011752:20210103011755:1609654673:1609654676:3 #
```
