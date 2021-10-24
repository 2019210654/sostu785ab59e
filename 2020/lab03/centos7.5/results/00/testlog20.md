```bash
oracle@FOO:queries$ ./runsql.sh -v stub/20.sql
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
>>> stub/20.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 2 23:45:56 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sat Jan 02 2021 23:45:53 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28   29   30   31   32   33   34   35   36   37  
no rows selected

Elapsed: 00:00:00.05

Execution Plan
----------------------------------------------------------
Plan hash value: 4116306686

--------------------------------------------------------------------------------
------

| Id  | Operation		  | Name     | Rows  | Bytes | Cost (%CPU)| Time
     |

--------------------------------------------------------------------------------
------

|   0 | SELECT STATEMENT	  |	     |	   1 |	 128 |	  11  (10)| 00:0
0:01 |

|   1 |  SORT ORDER BY		  |	     |	   1 |	 128 |	  11  (10)| 00:0
0:01 |

|*  2 |   HASH JOIN		  |	     |	   1 |	 128 |	  10   (0)| 00:0
0:01 |

|   3 |    MERGE JOIN CARTESIAN   |	     |	   1 |	  53 |	   8   (0)| 00:0
0:01 |

|*  4 |     TABLE ACCESS FULL	  | NATION   |	   1 |	  40 |	   2   (0)| 00:0
0:01 |

|   5 |     BUFFER SORT 	  |	     |	   1 |	  13 |	   6   (0)| 00:0
0:01 |

|   6 |      VIEW		  | VW_NSO_1 |	   1 |	  13 |	   6   (0)| 00:0
0:01 |

|   7 |       HASH UNIQUE	  |	     |	   1 |	  81 |		  |
     |

|*  8 |        FILTER		  |	     |	     |	     |		  |
     |

|*  9 | 	HASH JOIN	  |	     |	   1 |	  81 |	   4   (0)| 00:0
0:01 |

|* 10 | 	 TABLE ACCESS FULL| PART     |	   1 |	  42 |	   2   (0)| 00:0
0:01 |

|  11 | 	 TABLE ACCESS FULL| PARTSUPP |	   1 |	  39 |	   2   (0)| 00:0
0:01 |

|  12 | 	SORT AGGREGATE	  |	     |	   1 |	  48 |		  |
     |

|* 13 | 	 TABLE ACCESS FULL| LINEITEM |	   1 |	  48 |	   2   (0)| 00:0
0:01 |

|  14 |    TABLE ACCESS FULL	  | SUPPLIER |	   1 |	  75 |	   2   (0)| 00:0
0:01 |

--------------------------------------------------------------------------------
------


Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("S_SUPPKEY"="PS_SUPPKEY" AND "S_NATIONKEY"="N_NATIONKEY")
   4 - filter("N_NAME"='CANADA')
   8 - filter("PS_AVAILQTY"> (SELECT 0.5*SUM("L_QUANTITY") FROM "LINEITEM"
	      "LINEITEM" WHERE "L_PARTKEY"=:B1 AND "L_SUPPKEY"=:B2 AND
	      "L_SHIPDATE">=TO_DATE(' 1994-01-01 00:00:00', 'syyyy-mm-dd hh24:mi
:ss') AND

	      "L_SHIPDATE"<TO_DATE(' 1995-01-01 00:00:00', 'syyyy-mm-dd hh24:mi:
ss')))

   9 - access("PS_PARTKEY"="P_PARTKEY")
  10 - filter("P_NAME" LIKE 'forest%')
  13 - filter("L_PARTKEY"=:B1 AND "L_SUPPKEY"=:B2 AND "L_SHIPDATE">=TO_DATE('
	      1994-01-01 00:00:00', 'syyyy-mm-dd hh24:mi:ss') AND "L_SHIPDATE"<T
O_DATE('

	      1995-01-01 00:00:00', 'syyyy-mm-dd hh24:mi:ss'))


Statistics
----------------------------------------------------------
	 29  recursive calls
	 16  db block gets
	 34  consistent gets
	  0  physical reads
       3044  redo size
	429  bytes sent via SQL*Net to client
	921  bytes received via SQL*Net from client
	  1  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
	  0  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
```
