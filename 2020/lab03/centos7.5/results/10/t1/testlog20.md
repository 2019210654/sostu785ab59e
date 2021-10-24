```
# Results of running 20.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q20)
     4	
     5	select
     6		s_name,
     7		s_address
     8	from
     9		supplier,
    10		nation
    11	where
    12		s_suppkey in (
    13			select
    14				ps_suppkey
    15			from
    16				partsupp
    17			where
    18				ps_partkey in (
    19					select
    20						p_partkey
    21					from
    22						part
    23					where
    24						p_name like 'forest%'
    25				)
    26				and ps_availqty > (
    27					select
    28						0.5 * sum(l_quantity)
    29					from
    30						lineitem
    31					where
    32						l_partkey = ps_partkey
    33						and l_suppkey = ps_suppkey
    34						and l_shipdate >= date '1994-01-01'
    35						and l_shipdate < date '1994-01-01' + interval '1' year
    36				)
    37		)
    38		and s_nationkey = n_nationkey
    39		and n_name = 'CANADA'
    40	order by
    41		s_name;
    42	--where rownum <= -1;
>>> dbgen/queries/stub/20.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jan 3 03:48:36 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sun Jan 03 2021 03:48:18 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28   29   30   31   32   33   34   35   36   37  
S_NAME			  S_ADDRESS
------------------------- ----------------------------------------
Supplier#000000020	  iybAE,RmTymrZVYaFZva2SH,j
Supplier#000000285	  Br7e1nnt1yxrw6ImgpJ7YdhFDjuBf
Supplier#000000358	  V3yxhHhHSXqOoc5UPv5TwkVDGKQsG
Supplier#000000361	  f8IUYRmdVXhQC9qJQjWknCXmzhe38vCbk6
Supplier#000000402	  i9Sw4DoyMhzhKXCH9By,AYSgmD
Supplier#000000555	  TfB,a5bfl3Ah 3Z 74GqnNs6zKVGM
Supplier#000000688	  D fw5ocppmZpYBBIPI718hCihLDZ5KhKX
Supplier#000000729	  pqck2ppy758TQpZCUAjPvlU55K3QjfL7Bi
Supplier#000000744	  5NKuw5W4mFDMQBbUjUO4k kfokG8yvAe
Supplier#000000752	  l cHMtEnodxj3FV
Supplier#000000783	  dMpZwZ95xznZWg4acMQW dK8AQMhB

...<snip>...

S_NAME			  S_ADDRESS
------------------------- ----------------------------------------
Supplier#000099837	  9PvUcmWMhf
Supplier#000099851	  FdYM9nxb2ump vezSSe4qaoMtD
Supplier#000099853	  zC1TZJiRLFu2I129lxqdI6QB
Supplier#000099869	  ZDpGfmbiqeGovro2O6frw302sqW
Supplier#000099877	  d35WQgRbGIaZiPCv20ymP5bTV
Supplier#000099879	  YVoWulAwdZQ
Supplier#000099892	  bu8PEUEDsU0CeTeW8w4gDr5k
Supplier#000099942	  LJJzV6PR4YnaDm6LCRcw
Supplier#000099955	  1P1DzqT1P MT0qrO0Vuc6 zk8
Supplier#000099980	  As8Iaeb75i1DfvXqnl0M6eQFeax4
Supplier#000099985	  8NDclMS,EEJOa4kVqiNiilk3kPfvgOg3KY

1804 rows selected.

Elapsed: 00:00:17.04

Execution Plan
----------------------------------------------------------
Plan hash value: 1111411882

--------------------------------------------------------------------------------
------

| Id  | Operation		  | Name     | Rows  | Bytes | Cost (%CPU)| Time
     |

--------------------------------------------------------------------------------
------

|   0 | SELECT STATEMENT	  |	     |	  13 |	1196 | 35436   (1)| 00:0
0:02 |

|   1 |  SORT ORDER BY		  |	     |	  13 |	1196 | 35436   (1)| 00:0
0:02 |

|*  2 |   HASH JOIN		  |	     |	  13 |	1196 | 35435   (1)| 00:0
0:02 |

|*  3 |    TABLE ACCESS FULL	  | NATION   |	   1 |	  29 |	   3   (0)| 00:0
0:01 |

|*  4 |    HASH JOIN RIGHT SEMI   |	     |	 317 | 19971 | 35432   (1)| 00:0
0:02 |

|   5 |     VIEW		  | VW_NSO_2 |	 317 |	1268 | 35364   (1)| 00:0
0:02 |

|*  6 |      FILTER		  |	     |	     |	     |		  |
     |

|   7 |       HASH GROUP BY	  |	     |	 317 | 30432 | 35364   (1)| 00:0
0:02 |

|*  8 |        HASH JOIN	  |	     |	6326 |	 593K| 35363   (1)| 00:0
0:02 |

|*  9 | 	HASH JOIN	  |	     |	6326 |	 469K|	5739   (1)| 00:0
0:01 |

|* 10 | 	 TABLE ACCESS FULL| PART     |	1597 | 81447 |	1059   (1)| 00:0
0:01 |

|  11 | 	 TABLE ACCESS FULL| PARTSUPP |	 800K|	  19M|	4677   (1)| 00:0
0:01 |

|* 12 | 	TABLE ACCESS FULL | LINEITEM |	 869K|	  16M| 29622   (1)| 00:0
0:02 |

|  13 |     TABLE ACCESS FULL	  | SUPPLIER | 10000 |	 576K|	  68   (0)| 00:0
0:01 |

--------------------------------------------------------------------------------
------


Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("S_NATIONKEY"="N_NATIONKEY")
   3 - filter("N_NAME"='CANADA')
   4 - access("S_SUPPKEY"="PS_SUPPKEY")
   6 - filter("PS_AVAILQTY">0.5*SUM("L_QUANTITY"))
   8 - access("L_PARTKEY"="PS_PARTKEY" AND "L_SUPPKEY"="PS_SUPPKEY")
   9 - access("PS_PARTKEY"="P_PARTKEY")
  10 - filter("P_NAME" LIKE 'forest%')
  12 - filter("L_SHIPDATE"<TO_DATE(' 1995-01-01 00:00:00', 'syyyy-mm-dd
	      hh24:mi:ss') AND "L_SHIPDATE">=TO_DATE(' 1994-01-01 00:00:00', 'sy
yyy-mm-dd

	      hh24:mi:ss'))


Statistics
----------------------------------------------------------
	 22  recursive calls
	  0  db block gets
    1302069  consistent gets
	  0  physical reads
	  0  redo size
     119319  bytes sent via SQL*Net to client
       2252  bytes received via SQL*Net from client
	122  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
       1804  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
# 20.sql:20210103034836:20210103034855:1609663717:1609663735:18 #
```
