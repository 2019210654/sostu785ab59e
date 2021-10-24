```
# Results of running 11.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q11)
     4	
     5	select
     6		ps_partkey,
     7		sum(ps_supplycost * ps_availqty) as value
     8	from
     9		partsupp,
    10		supplier,
    11		nation
    12	where
    13		ps_suppkey = s_suppkey
    14		and s_nationkey = n_nationkey
    15		and n_name = 'GERMANY'
    16	group by
    17		ps_partkey having
    18			sum(ps_supplycost * ps_availqty) > (
    19				select
    20					sum(ps_supplycost * ps_availqty) * 0.0001000000
    21				from
    22					partsupp,
    23					supplier,
    24					nation
    25				where
    26					ps_suppkey = s_suppkey
    27					and s_nationkey = n_nationkey
    28					and n_name = 'GERMANY'
    29			)
    30	order by
    31		value desc;
    32	--where rownum <= -1;
>>> dbgen/queries/stub/11.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jan 3 02:23:40 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sun Jan 03 2021 02:23:34 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27  
PS_PARTKEY	VALUE
---------- ----------
    129760 17538456.9
    166726 16503353.9
    191287   16474802
    161758 16101755.5
     34452 15983844.7
    139035 15907078.3
      9403 15451755.6
    154358 15212937.9
     38823 15064802.9
     85606 15053957.2
     33354 14408297.4

...<snip>...

PS_PARTKEY	VALUE
---------- ----------
     51968 7879102.21
     72073 7877736.11
      5182 7874521.73

1048 rows selected.

Elapsed: 00:00:00.47

Execution Plan
----------------------------------------------------------
Plan hash value: 3034599735

--------------------------------------------------------------------------------
--------------

| Id  | Operation		  | Name     | Rows  | Bytes |TempSpc| Cost (%CP
U)| Time     |

--------------------------------------------------------------------------------
--------------

|   0 | SELECT STATEMENT	  |	     | 32000 |	1218K|	     |	5502   (
1)| 00:00:01 |

|   1 |  SORT ORDER BY		  |	     | 32000 |	1218K|	1640K|	5502   (
1)| 00:00:01 |

|*  2 |   VIEW			  | VW_WIF_1 | 32000 |	1218K|	     |	5178   (
1)| 00:00:01 |

|   3 |    WINDOW BUFFER	  |	     | 32000 |	1687K|	     |	5178   (
1)| 00:00:01 |

|   4 |     HASH GROUP BY	  |	     | 32000 |	1687K|	2024K|	5178   (
1)| 00:00:01 |

|*  5 |      HASH JOIN		  |	     | 32000 |	1687K|	     |	4751   (
1)| 00:00:01 |

|   6 |       TABLE ACCESS FULL   | SUPPLIER | 10000 | 70000 |	     |	  68   (
0)| 00:00:01 |

|   7 |       MERGE JOIN CARTESIAN|	     |	 800K|	  35M|	     |	4681   (
1)| 00:00:01 |

|*  8 |        TABLE ACCESS FULL  | NATION   |	   1 |	  29 |	     |	   3   (
0)| 00:00:01 |

|   9 |        BUFFER SORT	  |	     |	 800K|	  13M|	     |	4678   (
1)| 00:00:01 |

|  10 | 	TABLE ACCESS FULL | PARTSUPP |	 800K|	  13M|	     |	4678   (
1)| 00:00:01 |

--------------------------------------------------------------------------------
--------------


Predicate Information (identified by operation id):
---------------------------------------------------

   2 - filter("ITEM_1">"ITEM_2"*0.0001000000)
   5 - access("S_NATIONKEY"="N_NATIONKEY" AND "PS_SUPPKEY"="S_SUPPKEY")
   8 - filter("N_NAME"='GERMANY')


Statistics
----------------------------------------------------------
	  1  recursive calls
	  0  db block gets
      16743  consistent gets
	  0  physical reads
	  0  redo size
      27607  bytes sent via SQL*Net to client
       1609  bytes received via SQL*Net from client
	 71  SQL*Net roundtrips to/from client
	  2  sorts (memory)
	  0  sorts (disk)
       1048  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
# 11.sql:20210103022340:20210103022341:1609658620:1609658621:1 #
```
