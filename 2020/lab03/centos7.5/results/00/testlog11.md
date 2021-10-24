```bash
oracle@FOO:queries$ ./runsql.sh -v stub/11.sql
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
>>> stub/11.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 2 23:45:28 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sat Jan 02 2021 23:45:25 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27  
no rows selected

Elapsed: 00:00:00.03

Execution Plan
----------------------------------------------------------
Plan hash value: 418290457

--------------------------------------------------------------------------------
------

| Id  | Operation		  | Name     | Rows  | Bytes | Cost (%CPU)| Time
     |

--------------------------------------------------------------------------------
------

|   0 | SELECT STATEMENT	  |	     |	   1 |	  39 |	   8  (25)| 00:0
0:01 |

|   1 |  SORT ORDER BY		  |	     |	   1 |	  39 |	   8  (25)| 00:0
0:01 |

|*  2 |   VIEW			  | VW_WIF_1 |	   1 |	  39 |	   7  (15)| 00:0
0:01 |

|   3 |    WINDOW BUFFER	  |	     |	   1 |	 118 |	   7  (15)| 00:0
0:01 |

|   4 |     HASH GROUP BY	  |	     |	   1 |	 118 |	   7  (15)| 00:0
0:01 |

|*  5 |      HASH JOIN		  |	     |	   1 |	 118 |	   6   (0)| 00:0
0:01 |

|   6 |       MERGE JOIN CARTESIAN|	     |	   1 |	  92 |	   4   (0)| 00:0
0:01 |

|*  7 |        TABLE ACCESS FULL  | NATION   |	   1 |	  40 |	   2   (0)| 00:0
0:01 |

|   8 |        BUFFER SORT	  |	     |	   1 |	  52 |	   2   (0)| 00:0
0:01 |

|   9 | 	TABLE ACCESS FULL | PARTSUPP |	   1 |	  52 |	   2   (0)| 00:0
0:01 |

|  10 |       TABLE ACCESS FULL   | SUPPLIER |	   1 |	  26 |	   2   (0)| 00:0
0:01 |

--------------------------------------------------------------------------------
------


Predicate Information (identified by operation id):
---------------------------------------------------

   2 - filter("ITEM_1">"ITEM_2"*0.0001000000)
   5 - access("S_NATIONKEY"="N_NATIONKEY" AND "PS_SUPPKEY"="S_SUPPKEY")
   7 - filter("N_NAME"='GERMANY')


Statistics
----------------------------------------------------------
	 20  recursive calls
	 12  db block gets
	 21  consistent gets
	  0  physical reads
       2104  redo size
	429  bytes sent via SQL*Net to client
	839  bytes received via SQL*Net from client
	  1  SQL*Net roundtrips to/from client
	  2  sorts (memory)
	  0  sorts (disk)
	  0  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
```
