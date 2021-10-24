```
# Results of running 05.sql
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
>>> dbgen/queries/stub/05.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jan 3 03:43:39 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sun Jan 03 2021 03:43:21 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24  
N_NAME			     REVENUE
------------------------- ----------
INDIA			   536862588
CHINA			   535350830
VIETNAM 		   532269389
JAPAN			   526766837
INDONESIA		   523176852

Elapsed: 00:00:23.30

Execution Plan
----------------------------------------------------------
Plan hash value: 3390147343

--------------------------------------------------------------------------------
------------------

| Id  | Operation		     | Name	 | Rows  | Bytes |TempSpc| Cost
(%CPU)| Time	 |

--------------------------------------------------------------------------------
------------------

|   0 | SELECT STATEMENT	     |		 |    25 |  2300 |	 | 42964
   (1)| 00:00:02 |

|   1 |  SORT ORDER BY		     |		 |    25 |  2300 |	 | 42964
   (1)| 00:00:02 |

|   2 |   HASH GROUP BY 	     |		 |    25 |  2300 |	 | 42964
   (1)| 00:00:02 |

|*  3 |    HASH JOIN		     |		 |  7410 |   665K|  2936K| 42962
   (1)| 00:00:02 |

|   4 |     TABLE ACCESS FULL	     | CUSTOMER  |   150K|  1171K|	 |   957
   (1)| 00:00:01 |

|*  5 |     HASH JOIN		     |		 |   185K|    14M|  6912K| 41020
   (1)| 00:00:02 |

|*  6 |      TABLE ACCESS FULL	     | ORDERS	 |   228K|  4235K|	 |  6621
   (1)| 00:00:01 |

|*  7 |      HASH JOIN		     |		 |  1200K|    74M|	 | 29689
   (1)| 00:00:02 |

|   8 |       VIEW		     | VW_GBF_46 |  2000 | 92000 |	 |    75
   (2)| 00:00:01 |

|   9 |        HASH GROUP BY	     |		 |  2000 |   132K|	 |    75
   (2)| 00:00:01 |

|* 10 | 	HASH JOIN	     |		 |  2000 |   132K|	 |    74
   (0)| 00:00:01 |

|  11 | 	 TABLE ACCESS FULL   | NATION	 |    25 |   800 |	 |     3
   (0)| 00:00:01 |

|  12 | 	 MERGE JOIN CARTESIAN|		 | 10000 |   351K|	 |    71
   (0)| 00:00:01 |

|* 13 | 	  TABLE ACCESS FULL  | REGION	 |     1 |    29 |	 |     3
   (0)| 00:00:01 |

|  14 | 	  BUFFER SORT	     |		 | 10000 | 70000 |	 |    68
   (0)| 00:00:01 |

|  15 | 	   TABLE ACCESS FULL | SUPPLIER  | 10000 | 70000 |	 |    68
   (0)| 00:00:01 |

|  16 |       TABLE ACCESS FULL      | LINEITEM  |  6001K|   108M|	 | 29597
   (1)| 00:00:02 |

--------------------------------------------------------------------------------
------------------


Predicate Information (identified by operation id):
---------------------------------------------------

   3 - access("C_CUSTKEY"="O_CUSTKEY" AND "C_NATIONKEY"="ITEM_1")
   5 - access("L_ORDERKEY"="O_ORDERKEY")
   6 - filter("O_ORDERDATE"<TO_DATE(' 1995-01-01 00:00:00', 'syyyy-mm-dd hh24:mi
:ss') AND

	      "O_ORDERDATE">=TO_DATE(' 1994-01-01 00:00:00', 'syyyy-mm-dd hh24:m
i:ss'))

   7 - access("L_SUPPKEY"="ITEM_2")
  10 - access("N_REGIONKEY"="R_REGIONKEY" AND "S_NATIONKEY"="N_NATIONKEY")
  13 - filter("R_NAME"='ASIA')


Statistics
----------------------------------------------------------
	 34  recursive calls
	  0  db block gets
    1373841  consistent gets
	  1  physical reads
	  0  redo size
	863  bytes sent via SQL*Net to client
	835  bytes received via SQL*Net from client
	  2  SQL*Net roundtrips to/from client
	  3  sorts (memory)
	  0  sorts (disk)
	  5  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
# 05.sql:20210103034339:20210103034403:1609663419:1609663444:25 #
```
