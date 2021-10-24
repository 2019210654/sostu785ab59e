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

SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jan 3 01:17:42 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sun Jan 03 2021 01:17:38 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28   29   30   31   32  
NATION			      O_YEAR SUM_PROFIT
------------------------- ---------- ----------
ALGERIA 			1998 27136900.2
ALGERIA 			1997 48611833.5
ALGERIA 			1996 48285482.7
ALGERIA 			1995 44402273.6
ALGERIA 			1994 48694008.1
ALGERIA 			1993 46044207.8
ALGERIA 			1992 45636849.5
ARGENTINA			1998 28341663.8
ARGENTINA			1997 47143964.1
ARGENTINA			1996 45255278.6
ARGENTINA			1995 45631769.2

...<snip>...

NATION			      O_YEAR SUM_PROFIT
------------------------- ---------- ----------
UNITED STATES			1994 45099092.1
UNITED STATES			1993 46181600.5
UNITED STATES			1992 46168214.1
VIETNAM 			1998   27281931
VIETNAM 			1997 48735914.2
VIETNAM 			1996 47824595.9
VIETNAM 			1995 48235135.8
VIETNAM 			1994 47729256.3
VIETNAM 			1993 45352676.9
VIETNAM 			1992 47846355.6

175 rows selected.

Elapsed: 00:00:03.43

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
	 22  recursive calls
	  0  db block gets
     152986  consistent gets
	  0  physical reads
	  0  redo size
       6493  bytes sent via SQL*Net to client
       1065  bytes received via SQL*Net from client
	 13  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
	175  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
# 09.sql:20210103011741:20210103011746:1609654662:1609654666:4 #
```
