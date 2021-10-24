```bash
oracle@FOO:queries$ ./runsql.sh -v stub/05.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q5)
     4	
     5	select
     6		n_name,
     7		sum(l_extendedprice * (1 - l_discount)) as revenue
     8	from
     9		customer,
    10		orders,
    11		lineitem,
    12		supplier,
    13		nation,
    14		region
    15	where
    16		c_custkey = o_custkey
    17		and l_orderkey = o_orderkey
    18		and l_suppkey = s_suppkey
    19		and c_nationkey = s_nationkey
    20		and s_nationkey = n_nationkey
    21		and n_regionkey = r_regionkey
    22		and r_name = 'ASIA'
    23		and o_orderdate >= date '1994-01-01'
    24		and o_orderdate < date '1994-01-01' + interval '1' year
    25	group by
    26		n_name
    27	order by
    28		revenue desc;
    29	--where rownum <= -1;
>>> stub/05.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 2 23:45:09 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sat Jan 02 2021 23:45:06 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24  
no rows selected

Elapsed: 00:00:00.19

Execution Plan
----------------------------------------------------------
Plan hash value: 2867023339

--------------------------------------------------------------------------------
-----

| Id  | Operation		 | Name     | Rows  | Bytes | Cost (%CPU)| Time
    |

--------------------------------------------------------------------------------
-----

|   0 | SELECT STATEMENT	 |	    |	  1 |	232 |	 14  (15)| 00:00
:01 |

|   1 |  SORT ORDER BY		 |	    |	  1 |	232 |	 14  (15)| 00:00
:01 |

|   2 |   HASH GROUP BY 	 |	    |	  1 |	232 |	 14  (15)| 00:00
:01 |

|*  3 |    HASH JOIN		 |	    |	  1 |	232 |	 12   (0)| 00:00
:01 |

|*  4 |     HASH JOIN		 |	    |	  1 |	192 |	 10   (0)| 00:00
:01 |

|*  5 |      HASH JOIN		 |	    |	  1 |	139 |	  8   (0)| 00:00
:01 |

|*  6 |       HASH JOIN 	 |	    |	  1 |	113 |	  6   (0)| 00:00
:01 |

|*  7 |        HASH JOIN	 |	    |	  1 |	 61 |	  4   (0)| 00:00
:01 |

|   8 | 	TABLE ACCESS FULL| CUSTOMER |	  1 |	 26 |	  2   (0)| 00:00
:01 |

|*  9 | 	TABLE ACCESS FULL| ORDERS   |	  1 |	 35 |	  2   (0)| 00:00
:01 |

|  10 |        TABLE ACCESS FULL | LINEITEM |	  1 |	 52 |	  2   (0)| 00:00
:01 |

|  11 |       TABLE ACCESS FULL  | SUPPLIER |	  1 |	 26 |	  2   (0)| 00:00
:01 |

|  12 |      TABLE ACCESS FULL	 | NATION   |	  1 |	 53 |	  2   (0)| 00:00
:01 |

|* 13 |     TABLE ACCESS FULL	 | REGION   |	  1 |	 40 |	  2   (0)| 00:00
:01 |

--------------------------------------------------------------------------------
-----


Predicate Information (identified by operation id):
---------------------------------------------------

   3 - access("N_REGIONKEY"="R_REGIONKEY")
   4 - access("S_NATIONKEY"="N_NATIONKEY")
   5 - access("L_SUPPKEY"="S_SUPPKEY" AND "C_NATIONKEY"="S_NATIONKEY")
   6 - access("L_ORDERKEY"="O_ORDERKEY")
   7 - access("C_CUSTKEY"="O_CUSTKEY")
   9 - filter("O_ORDERDATE">=TO_DATE(' 1994-01-01 00:00:00', 'syyyy-mm-dd
	      hh24:mi:ss') AND "O_ORDERDATE"<TO_DATE(' 1995-01-01 00:00:00', 'sy
yyy-mm-dd

	      hh24:mi:ss'))
  13 - filter("R_NAME"='ASIA')


Statistics
----------------------------------------------------------
	 97  recursive calls
	 43  db block gets
	 81  consistent gets
	  0  physical reads
       7496  redo size
	427  bytes sent via SQL*Net to client
	824  bytes received via SQL*Net from client
	  1  SQL*Net roundtrips to/from client
	  4  sorts (memory)
	  0  sorts (disk)
	  0  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
```
