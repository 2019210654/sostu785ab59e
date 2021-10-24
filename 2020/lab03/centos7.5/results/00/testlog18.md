```bash
oracle@FOO:queries$ ./runsql.sh -v stub/18.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q18)
     4	
     5	select
     6		c_name,
     7		c_custkey,
     8		o_orderkey,
     9		o_orderdate,
    10		o_totalprice,
    11		sum(l_quantity)
    12	from
    13		customer,
    14		orders,
    15		lineitem
    16	where
    17		o_orderkey in (
    18			select
    19				l_orderkey
    20			from
    21				lineitem
    22			group by
    23				l_orderkey having
    24					sum(l_quantity) > 300
    25		)
    26		and c_custkey = o_custkey
    27		and o_orderkey = l_orderkey
    28	group by
    29		c_name,
    30		c_custkey,
    31		o_orderkey,
    32		o_orderdate,
    33		o_totalprice
    34	order by
    35		o_totalprice desc,
    36		o_orderdate;
    37	--where rownum <= 100;
>>> stub/18.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 2 23:45:50 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sat Jan 02 2021 23:45:47 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28   29   30   31   32  
no rows selected

Elapsed: 00:00:00.04

Execution Plan
----------------------------------------------------------
Plan hash value: 4249980518

--------------------------------------------------------------------------------
--------

| Id  | Operation		   | Name      | Rows  | Bytes | Cost (%CPU)| Ti
me     |

--------------------------------------------------------------------------------
--------

|   0 | SELECT STATEMENT	   |	       |     1 |    75 |    11	(28)| 00
:00:01 |

|   1 |  SORT GROUP BY		   |	       |     1 |    75 |    11	(28)| 00
:00:01 |

|   2 |   VIEW			   | VM_NWVW_2 |     1 |    75 |     9	(12)| 00
:00:01 |

|*  3 |    FILTER		   |	       |       |       |	    |
       |

|   4 |     HASH GROUP BY	   |	       |     1 |   163 |     9	(12)| 00
:00:01 |

|*  5 |      HASH JOIN		   |	       |     1 |   163 |     8	 (0)| 00
:00:01 |

|   6 |       MERGE JOIN CARTESIAN |	       |     1 |   103 |     6	 (0)| 00
:00:01 |

|   7 |        MERGE JOIN CARTESIAN|	       |     1 |    65 |     4	 (0)| 00
:00:01 |

|   8 | 	TABLE ACCESS FULL  | LINEITEM  |     1 |    26 |     2	 (0)| 00
:00:01 |

|   9 | 	BUFFER SORT	   |	       |     1 |    39 |     2	 (0)| 00
:00:01 |

|  10 | 	 TABLE ACCESS FULL | CUSTOMER  |     1 |    39 |     2	 (0)| 00
:00:01 |

|  11 |        BUFFER SORT	   |	       |     1 |    38 |     4	 (0)| 00
:00:01 |

|  12 | 	TABLE ACCESS FULL  | LINEITEM  |     1 |    38 |     2	 (0)| 00
:00:01 |

|  13 |       TABLE ACCESS FULL    | ORDERS    |     1 |    60 |     2	 (0)| 00
:00:01 |

--------------------------------------------------------------------------------
--------


Predicate Information (identified by operation id):
---------------------------------------------------

   3 - filter(SUM("L_QUANTITY")>300)
   5 - access("O_ORDERKEY"="L_ORDERKEY" AND "C_CUSTKEY"="O_CUSTKEY" AND
	      "O_ORDERKEY"="L_ORDERKEY")


Statistics
----------------------------------------------------------
	 38  recursive calls
	 32  db block gets
	 30  consistent gets
	  0  physical reads
       5748  redo size
	757  bytes sent via SQL*Net to client
	775  bytes received via SQL*Net from client
	  1  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
	  0  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
```
