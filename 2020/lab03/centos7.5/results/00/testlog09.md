```bash
oracle@FOO:queries$ ./runsql.sh -v stub/09.sql
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
>>> stub/09.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 2 23:45:21 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sat Jan 02 2021 23:45:18 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28   29   30   31   32  
no rows selected

Elapsed: 00:00:00.03

Execution Plan
----------------------------------------------------------
Plan hash value: 3702162141

--------------------------------------------------------------------------------
----

| Id  | Operation		| Name	   | Rows  | Bytes | Cost (%CPU)| Time
   |

--------------------------------------------------------------------------------
----

|   0 | SELECT STATEMENT	|	   |	 1 |   247 |	13   (8)| 00:00:
01 |

|   1 |  SORT GROUP BY		|	   |	 1 |   247 |	13   (8)| 00:00:
01 |

|*  2 |   HASH JOIN		|	   |	 1 |   247 |	12   (0)| 00:00:
01 |

|*  3 |    HASH JOIN		|	   |	 1 |   207 |	10   (0)| 00:00:
01 |

|*  4 |     HASH JOIN		|	   |	 1 |   185 |	 8   (0)| 00:00:
01 |

|*  5 |      HASH JOIN		|	   |	 1 |   146 |	 6   (0)| 00:00:
01 |

|*  6 |       HASH JOIN 	|	   |	 1 |   120 |	 4   (0)| 00:00:
01 |

|*  7 |        TABLE ACCESS FULL| PART	   |	 1 |	42 |	 2   (0)| 00:00:
01 |

|   8 |        TABLE ACCESS FULL| LINEITEM |	 1 |	78 |	 2   (0)| 00:00:
01 |

|   9 |       TABLE ACCESS FULL | SUPPLIER |	 1 |	26 |	 2   (0)| 00:00:
01 |

|  10 |      TABLE ACCESS FULL	| PARTSUPP |	 1 |	39 |	 2   (0)| 00:00:
01 |

|  11 |     TABLE ACCESS FULL	| ORDERS   |	 1 |	22 |	 2   (0)| 00:00:
01 |

|  12 |    TABLE ACCESS FULL	| NATION   |	 1 |	40 |	 2   (0)| 00:00:
01 |

--------------------------------------------------------------------------------
----


Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("S_NATIONKEY"="N_NATIONKEY")
   3 - access("O_ORDERKEY"="L_ORDERKEY")
   4 - access("PS_SUPPKEY"="L_SUPPKEY" AND "PS_PARTKEY"="L_PARTKEY")
   5 - access("S_SUPPKEY"="L_SUPPKEY")
   6 - access("P_PARTKEY"="L_PARTKEY")
   7 - filter("P_NAME" LIKE '%green%')


Statistics
----------------------------------------------------------
	 46  recursive calls
	 23  db block gets
	 30  consistent gets
	  0  physical reads
       3928  redo size
	506  bytes sent via SQL*Net to client
	933  bytes received via SQL*Net from client
	  1  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
	  0  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
```
