```
# Results of running 18.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q18)
     4	
     5	select
     6		c_name,
     7		c_custkey,
     8		o_orderkey,
     9		o_orderdate,
    10		o_totalprice,
    11		sum(l_quantity)
    12	from
    13		customer,
    14		orders,
    15		lineitem
    16	where
    17		o_orderkey in (
    18			select
    19				l_orderkey
    20			from
    21				lineitem
    22			group by
    23				l_orderkey having
    24					sum(l_quantity) > 300
    25		)
    26		and c_custkey = o_custkey
    27		and o_orderkey = l_orderkey
    28	group by
    29		c_name,
    30		c_custkey,
    31		o_orderkey,
    32		o_orderdate,
    33		o_totalprice
    34	order by
    35		o_totalprice desc,
    36		o_orderdate;
    37	--where rownum <= 100;
>>> dbgen/queries/stub/18.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jan 3 01:18:06 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sun Jan 03 2021 01:18:04 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28   29   30   31   32  
C_NAME			   C_CUSTKEY O_ORDERKEY O_ORDERDA O_TOTALPRICE
------------------------- ---------- ---------- --------- ------------
SUM(L_QUANTITY)
---------------
Customer#000128120	      128120	4722021 07-APR-94    544089.09
	    323

Customer#000144617	      144617	3043270 12-FEB-97    530604.44
	    317

Customer#000013940	       13940	2232932 13-APR-97    522720.61
	    304

...<snip>...


C_NAME			   C_CUSTKEY O_ORDERKEY O_ORDERDA O_TOTALPRICE
------------------------- ---------- ---------- --------- ------------
SUM(L_QUANTITY)
---------------
Customer#000013072	       13072	1481925 15-MAR-98    399195.47
	    301

Customer#000082441	       82441	 857959 07-FEB-94    382579.74
	    305

Customer#000088703	       88703	2995076 30-JAN-94    363812.12
	    302


57 rows selected.

Elapsed: 00:00:03.41

Execution Plan
----------------------------------------------------------
Plan hash value: 2591122236

--------------------------------------------------------------------------------
------------

| Id  | Operation		| Name	   | Rows  | Bytes |TempSpc| Cost (%CPU)
| Time	   |

--------------------------------------------------------------------------------
------------

|   0 | SELECT STATEMENT	|	   |   304K|	18M|	   | 86374   (1)
| 00:00:04 |

|   1 |  SORT GROUP BY		|	   |   304K|	18M|	21M| 86374   (1)
| 00:00:04 |

|*  2 |   HASH JOIN		|	   |   304K|	18M|  4912K| 81710   (1)
| 00:00:04 |

|*  3 |    HASH JOIN		|	   | 75000 |  4028K|  3152K| 45892   (1)
| 00:00:02 |

|*  4 |     HASH JOIN RIGHT SEMI|	   | 75000 |  2270K|	   | 44526   (1)
| 00:00:02 |

|   5 |      VIEW		| VW_NSO_1 | 73952 |   433K|	   | 37904   (1)
| 00:00:02 |

|*  6 |       HASH GROUP BY	|	   | 73952 |   649K|   114M| 37904   (1)
| 00:00:02 |

|   7 |        TABLE ACCESS FULL| LINEITEM |  6001K|	51M|	   | 29591   (1)
| 00:00:02 |

|   8 |      TABLE ACCESS FULL	| ORDERS   |  1500K|	35M|	   |  6618   (1)
| 00:00:01 |

|   9 |     TABLE ACCESS FULL	| CUSTOMER |   150K|  3515K|	   |   956   (1)
| 00:00:01 |

|  10 |    TABLE ACCESS FULL	| LINEITEM |  6001K|	51M|	   | 29591   (1)
| 00:00:02 |

--------------------------------------------------------------------------------
------------


Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("O_ORDERKEY"="L_ORDERKEY")
   3 - access("C_CUSTKEY"="O_CUSTKEY")
   4 - access("O_ORDERKEY"="L_ORDERKEY")
   6 - filter(SUM("L_QUANTITY")>300)


Statistics
----------------------------------------------------------
	 15  recursive calls
	  0  db block gets
     244212  consistent gets
	  0  physical reads
	  0  redo size
       4419  bytes sent via SQL*Net to client
	819  bytes received via SQL*Net from client
	  5  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
	 57  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
# 18.sql:20210103011806:20210103011810:1609654686:1609654691:5 #
```
