```bash
oracle@FOO:queries$ ./runsql.sh -v stub/21.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q21)
     4	-- using default substitutions
     5	-- Status: VERIFIED
     6	
     7	-- XXX: To get 'Execution Plan, Predicate Information and Statistics', please
     8	--      enable the line in the following
     9	-- set autotrace on;
    10	
    11	select
    12		s_name,
    13		count(*) as numwait
    14	from
    15		supplier,
    16		lineitem l1,
    17		orders,
    18		nation
    19	where
    20		s_suppkey = l1.l_suppkey
    21		and o_orderkey = l1.l_orderkey
    22		and o_orderstatus = 'F'
    23		and l1.l_receiptdate > l1.l_commitdate
    24		and exists (
    25			select
    26				*
    27			from
    28				lineitem l2
    29			where
    30				l2.l_orderkey = l1.l_orderkey
    31				and l2.l_suppkey <> l1.l_suppkey
    32		)
    33		and not exists (
    34			select
    35				*
    36			from
    37				lineitem l3
    38			where
    39				l3.l_orderkey = l1.l_orderkey
    40				and l3.l_suppkey <> l1.l_suppkey
    41				and l3.l_receiptdate > l3.l_commitdate
    42		)
    43		and s_nationkey = n_nationkey
    44		and n_name = 'SAUDI ARABIA'
    45	group by
    46		s_name
    47	order by
    48		numwait desc,
    49		s_name;
    50	--where rownum <= 100;
>>> stub/21.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 2 23:45:59 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sat Jan 02 2021 23:45:56 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL> SQL> SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28   29   30   31   32   33   34   35   36   37   38   39  
no rows selected

Elapsed: 00:00:00.04

Execution Plan
----------------------------------------------------------
Plan hash value: 992567398

--------------------------------------------------------------------------------
----------

| Id  | Operation		     | Name	 | Rows  | Bytes | Cost (%CPU)|
Time	 |

--------------------------------------------------------------------------------
----------

|   0 | SELECT STATEMENT	     |		 |     1 |    27 |    13  (24)|
00:00:01 |

|   1 |  SORT ORDER BY		     |		 |     1 |    27 |    13  (24)|
00:00:01 |

|   2 |   HASH GROUP BY 	     |		 |     1 |    27 |    13  (24)|
00:00:01 |

|   3 |    VIEW 		     | VM_NWVW_2 |     1 |    27 |    11  (10)|
00:00:01 |

|*  4 |     FILTER		     |		 |	 |	 |	      |
	 |

|   5 |      HASH GROUP BY	     |		 |     1 |   245 |    11  (10)|
00:00:01 |

|*  6 |       HASH JOIN 	     |		 |     1 |   245 |    10   (0)|
00:00:01 |

|*  7 |        HASH JOIN	     |		 |     1 |   193 |     8   (0)|
00:00:01 |

|   8 | 	MERGE JOIN CARTESIAN |		 |     1 |   137 |     6   (0)|
00:00:01 |

|   9 | 	 MERGE JOIN CARTESIAN|		 |     1 |   109 |     4   (0)|
00:00:01 |

|  10 | 	  TABLE ACCESS FULL  | LINEITEM  |     1 |    44 |     2   (0)|
00:00:01 |

|  11 | 	  BUFFER SORT	     |		 |     1 |    65 |     2   (0)|
00:00:01 |

|  12 | 	   TABLE ACCESS FULL | SUPPLIER  |     1 |    65 |     2   (0)|
00:00:01 |

|  13 | 	 BUFFER SORT	     |		 |     1 |    28 |     4   (0)|
00:00:01 |

|* 14 | 	  TABLE ACCESS FULL  | ORDERS	 |     1 |    28 |     2   (0)|
00:00:01 |

|* 15 | 	TABLE ACCESS FULL    | LINEITEM  |     1 |    56 |     2   (0)|
00:00:01 |

|* 16 |        TABLE ACCESS FULL     | NATION	 |     1 |    52 |     2   (0)|
00:00:01 |

--------------------------------------------------------------------------------
----------


Predicate Information (identified by operation id):
---------------------------------------------------

   4 - filter(SUM(CASE	WHEN "L3"."L_RECEIPTDATE">"L3"."L_COMMITDATE" THEN 1 ELS
E

	      0 END )=0)
   6 - access("S_NATIONKEY"="N_NATIONKEY")
   7 - access("S_SUPPKEY"="L1"."L_SUPPKEY" AND "O_ORDERKEY"="L1"."L_ORDERKEY" AN
D

	      "L3"."L_ORDERKEY"="L1"."L_ORDERKEY")
       filter("L3"."L_SUPPKEY"<>"L1"."L_SUPPKEY")
  14 - filter("O_ORDERSTATUS"='F')
  15 - filter("L1"."L_RECEIPTDATE">"L1"."L_COMMITDATE")
  16 - filter("N_NAME"='SAUDI ARABIA')


Statistics
----------------------------------------------------------
	 22  recursive calls
	  7  db block gets
	 21  consistent gets
	  0  physical reads
       1072  redo size
	427  bytes sent via SQL*Net to client
	986  bytes received via SQL*Net from client
	  1  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
	  0  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
```
