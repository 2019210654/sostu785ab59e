```bash
oracle@FOO:queries$ ./runsql.sh -v stub/15.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q15)
     4	
     5	create view revenue0 (supplier_no, total_revenue) as
     6		select
     7			l_suppkey,
     8			sum(l_extendedprice * (1 - l_discount))
     9		from
    10			lineitem
    11		where
    12			l_shipdate >= date '1996-01-01'
    13			and l_shipdate < date '1996-01-01' + interval '3' month
    14		group by
    15			l_suppkey;
    16	
    17	
    18	select
    19		s_suppkey,
    20		s_name,
    21		s_address,
    22		s_phone,
    23		total_revenue
    24	from
    25		supplier,
    26		revenue0
    27	where
    28		s_suppkey = supplier_no
    29		and total_revenue = (
    30			select
    31				max(total_revenue)
    32			from
    33				revenue0
    34		)
    35	order by
    36		s_suppkey;
    37	
    38	drop view revenue0;
    39	--where rownum <= -1;
>>> stub/15.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 2 23:45:40 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sat Jan 02 2021 23:45:37 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11  
View created.

Elapsed: 00:00:00.05
SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19  
no rows selected

Elapsed: 00:00:00.02

Execution Plan
----------------------------------------------------------
Plan hash value: 3293412063

--------------------------------------------------------------------------------
---

| Id  | Operation	       | Name	  | Rows  | Bytes | Cost (%CPU)| Time
  |

--------------------------------------------------------------------------------
---

|   0 | SELECT STATEMENT       |	  |	1 |   118 |	6  (34)| 00:00:0
1 |

|   1 |  SORT ORDER BY	       |	  |	1 |   118 |	6  (34)| 00:00:0
1 |

|*  2 |   HASH JOIN	       |	  |	1 |   118 |	5  (20)| 00:00:0
1 |

|   3 |    TABLE ACCESS FULL   | SUPPLIER |	1 |    79 |	2   (0)| 00:00:0
1 |

|*  4 |    VIEW 	       | REVENUE0 |	1 |    39 |	3  (34)| 00:00:0
1 |

|   5 |     WINDOW BUFFER      |	  |	1 |    48 |	3  (34)| 00:00:0
1 |

|   6 |      HASH GROUP BY     |	  |	1 |    48 |	3  (34)| 00:00:0
1 |

|*  7 |       TABLE ACCESS FULL| LINEITEM |	1 |    48 |	2   (0)| 00:00:0
1 |

--------------------------------------------------------------------------------
---


Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("S_SUPPKEY"="SUPPLIER_NO")
   4 - filter("TOTAL_REVENUE"="ITEM_1")
   7 - filter("L_SHIPDATE">=TO_DATE(' 1996-01-01 00:00:00', 'syyyy-mm-dd
	      hh24:mi:ss') AND "L_SHIPDATE"<TO_DATE(' 1996-04-01 00:00:00', 'syy
yy-mm-dd

	      hh24:mi:ss'))


Statistics
----------------------------------------------------------
	 26  recursive calls
	  0  db block gets
	 15  consistent gets
	  0  physical reads
	  0  redo size
	668  bytes sent via SQL*Net to client
	568  bytes received via SQL*Net from client
	  1  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
	  0  rows processed

SQL> SQL> 
View dropped.

Elapsed: 00:00:00.03
SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
```
