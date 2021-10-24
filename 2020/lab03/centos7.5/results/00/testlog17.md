```bash
oracle@FOO:queries$ ./runsql.sh -v stub/17.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q17)
     4	
     5	select
     6		sum(l_extendedprice) / 7.0 as avg_yearly
     7	from
     8		lineitem,
     9		part
    10	where
    11		p_partkey = l_partkey
    12		and p_brand = 'Brand#23'
    13		and p_container = 'MED BOX'
    14		and l_quantity < (
    15			select
    16				0.2 * avg(l_quantity)
    17			from
    18				lineitem
    19			where
    20				l_partkey = p_partkey
    21		);
    22	--where rownum <= -1;
>>> stub/17.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 2 23:45:46 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sat Jan 02 2021 23:45:44 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17  
AVG_YEARLY
----------


Elapsed: 00:00:00.03

Execution Plan
----------------------------------------------------------
Plan hash value: 3341365018

--------------------------------------------------------------------------------
--

| Id  | Operation	      | Name	 | Rows  | Bytes | Cost (%CPU)| Time
 |

--------------------------------------------------------------------------------
--

|   0 | SELECT STATEMENT      | 	 |     1 |    13 |     5  (20)| 00:00:01
 |

|   1 |  SORT AGGREGATE       | 	 |     1 |    13 |	      |
 |

|   2 |   VIEW		      | VW_WIF_1 |     1 |    13 |     5  (20)| 00:00:01
 |

|   3 |    WINDOW SORT	      | 	 |     1 |    76 |     5  (20)| 00:00:01
 |

|*  4 |     HASH JOIN	      | 	 |     1 |    76 |     4   (0)| 00:00:01
 |

|*  5 |      TABLE ACCESS FULL| PART	 |     1 |    37 |     2   (0)| 00:00:01
 |

|   6 |      TABLE ACCESS FULL| LINEITEM |     1 |    39 |     2   (0)| 00:00:01
 |

--------------------------------------------------------------------------------
--


Predicate Information (identified by operation id):
---------------------------------------------------

   4 - access("P_PARTKEY"="L_PARTKEY")
   5 - filter("P_CONTAINER"='MED BOX' AND "P_BRAND"='Brand#23')


Statistics
----------------------------------------------------------
	 29  recursive calls
	 17  db block gets
	 16  consistent gets
	  0  physical reads
       3024  redo size
	550  bytes sent via SQL*Net to client
	633  bytes received via SQL*Net from client
	  2  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
	  1  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
```
