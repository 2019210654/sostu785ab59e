```bash
oracle@FOO:queries$ ./runsql.sh -v stub/10.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q10)
     4	
     5	select
     6		c_custkey,
     7		c_name,
     8		sum(l_extendedprice * (1 - l_discount)) as revenue,
     9		c_acctbal,
    10		n_name,
    11		c_address,
    12		c_phone,
    13		c_comment
    14	from
    15		customer,
    16		orders,
    17		lineitem,
    18		nation
    19	where
    20		c_custkey = o_custkey
    21		and l_orderkey = o_orderkey
    22		and o_orderdate >= date '1993-10-01'
    23		and o_orderdate < date '1993-10-01' + interval '3' month
    24		and l_returnflag = 'R'
    25		and c_nationkey = n_nationkey
    26	group by
    27		c_custkey,
    28		c_name,
    29		c_acctbal,
    30		c_phone,
    31		n_name,
    32		c_address,
    33		c_comment
    34	order by
    35		revenue desc;
    36	--where rownum <= 20;
>>> stub/10.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 2 23:45:25 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sat Jan 02 2021 23:45:22 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28   29   30   31  
no rows selected

Elapsed: 00:00:00.06

Execution Plan
----------------------------------------------------------
Plan hash value: 3921133451

--------------------------------------------------------------------------------
-----

| Id  | Operation		 | Name     | Rows  | Bytes | Cost (%CPU)| Time
    |

--------------------------------------------------------------------------------
-----

|   0 | SELECT STATEMENT	 |	    |	  1 |	269 |	 10  (20)| 00:00
:01 |

|   1 |  SORT ORDER BY		 |	    |	  1 |	269 |	 10  (20)| 00:00
:01 |

|   2 |   HASH GROUP BY 	 |	    |	  1 |	269 |	 10  (20)| 00:00
:01 |

|*  3 |    HASH JOIN		 |	    |	  1 |	269 |	  8   (0)| 00:00
:01 |

|*  4 |     HASH JOIN		 |	    |	  1 |	229 |	  6   (0)| 00:00
:01 |

|   5 |      MERGE JOIN CARTESIAN|	    |	  1 |	194 |	  4   (0)| 00:00
:01 |

|   6 |       TABLE ACCESS FULL  | CUSTOMER |	  1 |	152 |	  2   (0)| 00:00
:01 |

|   7 |       BUFFER SORT	 |	    |	  1 |	 42 |	  2   (0)| 00:00
:01 |

|*  8 |        TABLE ACCESS FULL | LINEITEM |	  1 |	 42 |	  2   (0)| 00:00
:01 |

|*  9 |      TABLE ACCESS FULL	 | ORDERS   |	  1 |	 35 |	  2   (0)| 00:00
:01 |

|  10 |     TABLE ACCESS FULL	 | NATION   |	  1 |	 40 |	  2   (0)| 00:00
:01 |

--------------------------------------------------------------------------------
-----


Predicate Information (identified by operation id):
---------------------------------------------------

   3 - access("C_NATIONKEY"="N_NATIONKEY")
   4 - access("C_CUSTKEY"="O_CUSTKEY" AND "L_ORDERKEY"="O_ORDERKEY")
   8 - filter("L_RETURNFLAG"='R')
   9 - filter("O_ORDERDATE">=TO_DATE(' 1993-10-01 00:00:00', 'syyyy-mm-dd
	      hh24:mi:ss') AND "O_ORDERDATE"<TO_DATE(' 1994-01-01 00:00:00', 'sy
yyy-mm-dd

	      hh24:mi:ss'))


Statistics
----------------------------------------------------------
	 38  recursive calls
	 38  db block gets
	 24  consistent gets
	  0  physical reads
       7048  redo size
	896  bytes sent via SQL*Net to client
	853  bytes received via SQL*Net from client
	  1  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
	  0  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
```
