```
# Results of running 09.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q9)
     4	
     5	select
     6		nation,
     7		o_year,
     8		sum(amount) as sum_profit
     9	from
    10		(
    11			select
    12				n_name as nation,
    13				extract(year from o_orderdate) as o_year,
    14				l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity as amount
    15			from
    16				part,
    17				supplier,
    18				lineitem,
    19				partsupp,
    20				orders,
    21				nation
    22			where
    23				s_suppkey = l_suppkey
    24				and ps_suppkey = l_suppkey
    25				and ps_partkey = l_partkey
    26				and p_partkey = l_partkey
    27				and o_orderkey = l_orderkey
    28				and s_nationkey = n_nationkey
    29				and p_name like '%green%'
    30		) --as profit
    31	group by
    32		nation,
    33		o_year
    34	order by
    35		nation,
    36		o_year desc;
    37	--where rownum <= -1;
>>> dbgen/queries/stub/09.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jan 3 03:44:55 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sun Jan 03 2021 03:44:37 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28   29   30   31   32  
NATION			      O_YEAR SUM_PROFIT
------------------------- ---------- ----------
ALGERIA 			1998  271504047
ALGERIA 			1997  457035987
ALGERIA 			1996  457125199
ALGERIA 			1995  460972497
ALGERIA 			1994  456444976
ALGERIA 			1993  456449926
ALGERIA 			1992  459548355
ARGENTINA			1998  277792985
ARGENTINA			1997  467555915
ARGENTINA			1996  473886193
ARGENTINA			1995  468457260

...<snip>...

NATION			      O_YEAR SUM_PROFIT
------------------------- ---------- ----------
UNITED STATES			1994  476447816
UNITED STATES			1993  460120427
UNITED STATES			1992  468157792
VIETNAM 			1998  272979518
VIETNAM 			1997  473777591
VIETNAM 			1996  466048777
VIETNAM 			1995  468658193
VIETNAM 			1994  478019623
VIETNAM 			1993  469271926
VIETNAM 			1992  463962944

175 rows selected.

Elapsed: 00:00:34.53

Execution Plan
----------------------------------------------------------
Plan hash value: 4024282606

--------------------------------------------------------------------------------
------------

| Id  | Operation		| Name	   | Rows  | Bytes |TempSpc| Cost (%CPU)
| Time	   |

--------------------------------------------------------------------------------
------------

|   0 | SELECT STATEMENT	|	   | 40172 |  5099K|	   | 47314   (1)
| 00:00:02 |

|   1 |  SORT GROUP BY		|	   | 40172 |  5099K|  5552K| 47314   (1)
| 00:00:02 |

|*  2 |   HASH JOIN		|	   | 40172 |  5099K|	   | 46149   (1)
| 00:00:02 |

|   3 |    TABLE ACCESS FULL	| NATION   |	25 |   725 |	   |	 3   (0)
| 00:00:01 |

|*  4 |    HASH JOIN		|	   | 40172 |  3962K|	   | 46146   (1)
| 00:00:02 |

|   5 |     TABLE ACCESS FULL	| SUPPLIER | 10000 | 70000 |	   |	68   (0)
| 00:00:01 |

|*  6 |     HASH JOIN		|	   | 40172 |  3687K|  3560K| 46078   (1)
| 00:00:02 |

|*  7 |      HASH JOIN		|	   | 39610 |  3094K|	19M| 37435   (1)
| 00:00:02 |

|   8 |       TABLE ACCESS FULL | PARTSUPP |   800K|	10M|	   |  4678   (1)
| 00:00:01 |

|*  9 |       HASH JOIN 	|	   |   297K|	18M|	   | 30673   (1)
| 00:00:02 |

|* 10 |        TABLE ACCESS FULL| PART	   | 10000 |   380K|	   |  1059   (1)
| 00:00:01 |

|  11 |        TABLE ACCESS FULL| LINEITEM |  6001K|   154M|	   | 29597   (1)
| 00:00:02 |

|  12 |      TABLE ACCESS FULL	| ORDERS   |  1500K|	20M|	   |  6618   (1)
| 00:00:01 |

--------------------------------------------------------------------------------
------------


Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("S_NATIONKEY"="N_NATIONKEY")
   4 - access("S_SUPPKEY"="L_SUPPKEY")
   6 - access("O_ORDERKEY"="L_ORDERKEY")
   7 - access("PS_SUPPKEY"="L_SUPPKEY" AND "PS_PARTKEY"="L_PARTKEY")
   9 - access("P_PARTKEY"="L_PARTKEY")
  10 - filter("P_NAME" LIKE '%green%')


Statistics
----------------------------------------------------------
	 47  recursive calls
	  0  db block gets
    1543371  consistent gets
	  3  physical reads
	  0  redo size
       6669  bytes sent via SQL*Net to client
       1065  bytes received via SQL*Net from client
	 13  SQL*Net roundtrips to/from client
	 14  sorts (memory)
	  0  sorts (disk)
	175  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
# 09.sql:20210103034455:20210103034530:1609663496:1609663531:35 #
```
