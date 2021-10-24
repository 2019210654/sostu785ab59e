```bash
oracle@FOO:queries$ ./runsql.sh -v stub/03.sql
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
>>> stub/03.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 2 23:45:03 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sat Jan 02 2021 23:45:00 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22  
no rows selected

Elapsed: 00:00:00.04

Execution Plan
----------------------------------------------------------
Plan hash value: 1290894729

--------------------------------------------------------------------------------
----

| Id  | Operation		| Name	   | Rows  | Bytes | Cost (%CPU)| Time
   |

--------------------------------------------------------------------------------
----

|   0 | SELECT STATEMENT	|	   |	 1 |   121 |	 8  (25)| 00:00:
01 |

|   1 |  SORT ORDER BY		|	   |	 1 |   121 |	 8  (25)| 00:00:
01 |

|   2 |   HASH GROUP BY 	|	   |	 1 |   121 |	 8  (25)| 00:00:
01 |

|*  3 |    HASH JOIN		|	   |	 1 |   121 |	 6   (0)| 00:00:
01 |

|   4 |     MERGE JOIN CARTESIAN|	   |	 1 |	73 |	 4   (0)| 00:00:
01 |

|*  5 |      TABLE ACCESS FULL	| CUSTOMER |	 1 |	25 |	 2   (0)| 00:00:
01 |

|   6 |      BUFFER SORT	|	   |	 1 |	48 |	 2   (0)| 00:00:
01 |

|*  7 |       TABLE ACCESS FULL | LINEITEM |	 1 |	48 |	 2   (0)| 00:00:
01 |

|*  8 |     TABLE ACCESS FULL	| ORDERS   |	 1 |	48 |	 2   (0)| 00:00:
01 |

--------------------------------------------------------------------------------
----


Predicate Information (identified by operation id):
---------------------------------------------------

   3 - access("C_CUSTKEY"="O_CUSTKEY" AND "L_ORDERKEY"="O_ORDERKEY")
   5 - filter("C_MKTSEGMENT"='BUILDING')
   7 - filter("L_SHIPDATE">TO_DATE(' 1995-03-15 00:00:00', 'syyyy-mm-dd
	      hh24:mi:ss'))
   8 - filter("O_ORDERDATE"<TO_DATE(' 1995-03-15 00:00:00', 'syyyy-mm-dd
	      hh24:mi:ss'))


Statistics
----------------------------------------------------------
	 44  recursive calls
	 53  db block gets
	 26  consistent gets
	  0  physical reads
      10032  redo size
	596  bytes sent via SQL*Net to client
	747  bytes received via SQL*Net from client
	  1  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
	  0  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
```
