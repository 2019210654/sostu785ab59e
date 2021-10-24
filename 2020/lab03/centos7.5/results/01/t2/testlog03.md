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

SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jan 3 02:23:11 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sun Jan 03 2021 02:23:10 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22  
L_ORDERKEY    REVENUE O_ORDERDA O_SHIPPRIORITY
---------- ---------- --------- --------------
   2456423 406181.011 05-MAR-95 	     0
   3459808 405838.699 04-MAR-95 	     0
    492164 390324.061 19-FEB-95 	     0
   1188320 384537.936 09-MAR-95 	     0
   2435712 378673.056 26-FEB-95 	     0
   4878020 378376.795 12-MAR-95 	     0
   5521732 375153.922 13-MAR-95 	     0
   2628192 373133.309 22-FEB-95 	     0
    993600  371407.46 05-MAR-95 	     0
   2300070 367371.145 13-MAR-95 	     0
   1166660 365967.442 27-FEB-95 	     0

...<snip>...

L_ORDERKEY    REVENUE O_ORDERDA O_SHIPPRIORITY
---------- ---------- --------- --------------
   4276512     960.68 31-DEC-94 	     0
   4810887     947.04 31-DEC-94 	     0
    617767    901.588 17-FEB-95 	     0
   3283971    850.518 27-DEC-94 	     0

11620 rows selected.

Elapsed: 00:00:02.38

Execution Plan
----------------------------------------------------------
Plan hash value: 2480932863

--------------------------------------------------------------------------------
------------

| Id  | Operation	       | Name	   | Rows  | Bytes |TempSpc| Cost (%CPU)
| Time	   |

--------------------------------------------------------------------------------
------------

|   0 | SELECT STATEMENT       |	   |   497K|	19M|	   | 53613   (1)
| 00:00:03 |

|   1 |  SORT ORDER BY	       |	   |   497K|	19M|	26M| 53613   (1)
| 00:00:03 |

|   2 |   HASH GROUP BY        |	   |   497K|	19M|	26M| 53613   (1)
| 00:00:03 |

|*  3 |    HASH JOIN	       |	   |   497K|	19M|  6608K| 42874   (1)
| 00:00:02 |

|   4 |     VIEW	       | VW_GBF_10 |   218K|  4049K|	   |  7581   (1)
| 00:00:01 |

|*  5 |      HASH JOIN	       |	   |   218K|  7884K|	   |  7581   (1)
| 00:00:01 |

|*  6 |       TABLE ACCESS FULL| CUSTOMER  | 30142 |   470K|	   |   958   (1)
| 00:00:01 |

|*  7 |       TABLE ACCESS FULL| ORDERS    |   729K|	14M|	   |  6621   (1)
| 00:00:01 |

|*  8 |     TABLE ACCESS FULL  | LINEITEM  |  3225K|	70M|	   | 29618   (1)
| 00:00:02 |

--------------------------------------------------------------------------------
------------


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
	 14  recursive calls
	  3  db block gets
     135914  consistent gets
	  0  physical reads
	636  redo size
     446057  bytes sent via SQL*Net to client
       9272  bytes received via SQL*Net from client
	776  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
      11620  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
# 03.sql:20210103022311:20210103022315:1609658592:1609658595:3 #
```
