```
# Results of running 03.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q3)
     4	
     5	select
     6		l_orderkey,
     7		sum(l_extendedprice * (1 - l_discount)) as revenue,
     8		o_orderdate,
     9		o_shippriority
    10	from
    11		customer,
    12		orders,
    13		lineitem
    14	where
    15		c_mktsegment = 'BUILDING'
    16		and c_custkey = o_custkey
    17		and l_orderkey = o_orderkey
    18		and o_orderdate < date '1995-03-15'
    19		and l_shipdate > date '1995-03-15'
    20	group by
    21		l_orderkey,
    22		o_orderdate,
    23		o_shippriority
    24	order by
    25		revenue desc,
    26		o_orderdate;
    27	--where rownum <= 10;
>>> dbgen/queries/stub/03.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jan 3 04:33:18 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sun Jan 03 2021 04:33:16 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22  
L_ORDERKEY    REVENUE O_ORDERDA O_SHIPPRIORITY
---------- ---------- --------- --------------
   4791171 440715.219 23-FEB-95 	     0
  46678469 439855.325 27-JAN-95 	     0
  23906758 432728.574 14-MAR-95 	     0
  23861382 428739.137 09-MAR-95 	     0
  59393639 426036.066 12-FEB-95 	     0
   3355202 425100.666 04-MAR-95 	     0
   9806272 425088.057 13-MAR-95 	     0
  22810436 423231.969 02-JAN-95 	     0
  16384100 421478.729 02-MAR-95 	     0
  52974151  415367.12 05-FEB-95 	     0
   3778628 411836.283 25-FEB-95 	     0

...<snip>...

L_ORDERKEY    REVENUE O_ORDERDA O_SHIPPRIORITY
---------- ---------- --------- --------------
  47866401   927.1728 04-MAR-95 	     0
  48416807   916.4246 04-JAN-95 	     0
  35329478     913.64 29-JAN-95 	     0
   4542402   910.9464 29-NOV-94 	     0
  27752806     906.16 16-FEB-95 	     0
  44149381   904.3968 16-JAN-95 	     0
  34297697   897.8464 06-MAR-95 	     0
  25478115   887.2318 28-NOV-94 	     0
  52204674     860.25 18-DEC-94 	     0
  47255457   838.9381 18-NOV-94 	     0

114003 rows selected.

Elapsed: 00:00:23.53

Execution Plan
----------------------------------------------------------
Plan hash value: 2480932863

---------------------------------------------------------------------------------------------
| Id  | Operation	       | Name	   | Rows  | Bytes |TempSpc| Cost (%CPU) | Time     |
---------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT       |	   |   497K|	19M|	   | 53613   (1) | 00:00:03 |
|   1 |  SORT ORDER BY	       |	   |   497K|	19M|	26M| 53613   (1) | 00:00:03 |
|   2 |   HASH GROUP BY        |	   |   497K|	19M|	26M| 53613   (1) | 00:00:03 |
|*  3 |    HASH JOIN	       |	   |   497K|	19M|  6608K| 42874   (1) | 00:00:02 |
|   4 |     VIEW	       | VW_GBF_10 |   218K|  4049K|	   |  7581   (1) | 00:00:01 |
|*  5 |      HASH JOIN	       |	   |   218K|  7884K|	   |  7581   (1) | 00:00:01 |
|*  6 |       TABLE ACCESS FULL| CUSTOMER  | 30142 |   470K|	   |   958   (1) | 00:00:01 |
|*  7 |       TABLE ACCESS FULL| ORDERS    |   729K|	14M|	   |  6621   (1) | 00:00:01 |
|*  8 |     TABLE ACCESS FULL  | LINEITEM  |  3225K|	70M|	   | 29618   (1) | 00:00:02 |
---------------------------------------------------------------------------------------------


Predicate Information (identified by operation id):
---------------------------------------------------

   3 - access("L_ORDERKEY"="ITEM_1")
   5 - access("C_CUSTKEY"="O_CUSTKEY")
   6 - filter("C_MKTSEGMENT"='BUILDING')
   7 - filter("O_ORDERDATE"<TO_DATE(' 1995-03-15 00:00:00', 'syyyy-mm-dd
	      hh24:mi:ss'))
   8 - filter("L_SHIPDATE">TO_DATE(' 1995-03-15 00:00:00', 'syyyy-mm-dd
	      hh24:mi:ss'))

Note
-----
   - this is an adaptive plan


Statistics
----------------------------------------------------------
	 10  recursive calls
	  0  db block gets
    1371674  consistent gets
	  0  physical reads
	  0  redo size
    4387879  bytes sent via SQL*Net to client
      84358  bytes received via SQL*Net from client
       7602  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
     114003  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
# 03.sql:20210103043318:20210103043342:1609666398:1609666423:25 #
```
