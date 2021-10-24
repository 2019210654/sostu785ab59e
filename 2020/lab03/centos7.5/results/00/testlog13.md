```bash
oracle@FOO:queries$ ./runsql.sh -v stub/13.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q13)
     4	
     5	select
     6		c_count,
     7		count(*) as custdist
     8	from
     9		(
    10			select
    11				c_custkey,
    12				--count(o_orderkey)
    13				count(o_orderkey) as c_count
    14			from
    15				customer left outer join orders on
    16					c_custkey = o_custkey
    17					and o_comment not like '%special%requests%'
    18			group by
    19				c_custkey
    20		) --as c_orders (c_custkey, c_count)
    21	group by
    22		c_count
    23	order by
    24		custdist desc,
    25		c_count desc;
    26	--where rownum <= -1;
>>> stub/13.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 2 23:45:34 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sat Jan 02 2021 23:45:31 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21  
no rows selected

Elapsed: 00:00:00.03

Execution Plan
----------------------------------------------------------
Plan hash value: 1750410255

--------------------------------------------------------------------------------
---

| Id  | Operation	       | Name	  | Rows  | Bytes | Cost (%CPU)| Time
  |

--------------------------------------------------------------------------------
---

|   0 | SELECT STATEMENT       |	  |	1 |    13 |	7  (43)| 00:00:0
1 |

|   1 |  SORT ORDER BY	       |	  |	1 |    13 |	7  (43)| 00:00:0
1 |

|   2 |   HASH GROUP BY        |	  |	1 |    13 |	7  (43)| 00:00:0
1 |

|   3 |    VIEW 	       |	  |	1 |    13 |	5  (20)| 00:00:0
1 |

|   4 |     HASH GROUP BY      |	  |	1 |    80 |	5  (20)| 00:00:0
1 |

|*  5 |      HASH JOIN OUTER   |	  |	1 |    80 |	4   (0)| 00:00:0
1 |

|   6 |       TABLE ACCESS FULL| CUSTOMER |	1 |    13 |	2   (0)| 00:00:0
1 |

|*  7 |       TABLE ACCESS FULL| ORDERS   |	1 |    67 |	2   (0)| 00:00:0
1 |

--------------------------------------------------------------------------------
---


Predicate Information (identified by operation id):
---------------------------------------------------

   5 - access("C_CUSTKEY"="O_CUSTKEY"(+))
   7 - filter("O_COMMENT"(+) NOT LIKE '%special%requests%')


Statistics
----------------------------------------------------------
	 14  recursive calls
	  8  db block gets
	  8  consistent gets
	  0  physical reads
       1112  redo size
	429  bytes sent via SQL*Net to client
	721  bytes received via SQL*Net from client
	  1  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
	  0  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
```
