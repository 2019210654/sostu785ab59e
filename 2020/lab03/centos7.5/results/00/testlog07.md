```bash
oracle@FOO:queries$ ./runsql.sh -v stub/07.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q7)
     4	
     5	select
     6		supp_nation,
     7		cust_nation,
     8		l_year,
     9		sum(volume) as revenue
    10	from
    11		(
    12			select
    13				n1.n_name as supp_nation,
    14				n2.n_name as cust_nation,
    15				extract(year from l_shipdate) as l_year,
    16				l_extendedprice * (1 - l_discount) as volume
    17			from
    18				supplier,
    19				lineitem,
    20				orders,
    21				customer,
    22				nation n1,
    23				nation n2
    24			where
    25				s_suppkey = l_suppkey
    26				and o_orderkey = l_orderkey
    27				and c_custkey = o_custkey
    28				and s_nationkey = n1.n_nationkey
    29				and c_nationkey = n2.n_nationkey
    30				and (
    31					(n1.n_name = 'FRANCE' and n2.n_name = 'GERMANY')
    32					or (n1.n_name = 'GERMANY' and n2.n_name = 'FRANCE')
    33				)
    34				and l_shipdate between date '1995-01-01' and date '1996-12-31'
    35		) --as shipping
    36	group by
    37		supp_nation,
    38		cust_nation,
    39		l_year
    40	order by
    41		supp_nation,
    42		cust_nation,
    43		l_year;
    44	--where rownum <= -1;
>>> stub/07.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 2 23:45:15 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sat Jan 02 2021 23:45:12 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28   29   30   31   32   33   34   35   36   37   38   39  
no rows selected

Elapsed: 00:00:00.05

Execution Plan
----------------------------------------------------------
Plan hash value: 2350005642

--------------------------------------------------------------------------------
----

| Id  | Operation		| Name	   | Rows  | Bytes | Cost (%CPU)| Time
   |

--------------------------------------------------------------------------------
----

|   0 | SELECT STATEMENT	|	   |	 1 |   219 |	13   (8)| 00:00:
01 |

|   1 |  SORT GROUP BY		|	   |	 1 |   219 |	13   (8)| 00:00:
01 |

|*  2 |   HASH JOIN		|	   |	 1 |   219 |	12   (0)| 00:00:
01 |

|   3 |    NESTED LOOPS 	|	   |	 1 |   193 |	10   (0)| 00:00:
01 |

|*  4 |     HASH JOIN		|	   |	 1 |   153 |	 8   (0)| 00:00:
01 |

|*  5 |      HASH JOIN		|	   |	 1 |   113 |	 6   (0)| 00:00:
01 |

|*  6 |       HASH JOIN 	|	   |	 1 |	87 |	 4   (0)| 00:00:
01 |

|   7 |        TABLE ACCESS FULL| SUPPLIER |	 1 |	26 |	 2   (0)| 00:00:
01 |

|*  8 |        TABLE ACCESS FULL| LINEITEM |	 1 |	61 |	 2   (0)| 00:00:
01 |

|   9 |       TABLE ACCESS FULL | ORDERS   |	 1 |	26 |	 2   (0)| 00:00:
01 |

|* 10 |      TABLE ACCESS FULL	| NATION   |	 1 |	40 |	 2   (0)| 00:00:
01 |

|* 11 |     TABLE ACCESS FULL	| NATION   |	 1 |	40 |	 2   (0)| 00:00:
01 |

|  12 |    TABLE ACCESS FULL	| CUSTOMER |	 1 |	26 |	 2   (0)| 00:00:
01 |

--------------------------------------------------------------------------------
----


Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("C_CUSTKEY"="O_CUSTKEY" AND "C_NATIONKEY"="N2"."N_NATIONKEY")
   4 - access("S_NATIONKEY"="N1"."N_NATIONKEY")
   5 - access("O_ORDERKEY"="L_ORDERKEY")
   6 - access("S_SUPPKEY"="L_SUPPKEY")
   8 - filter("L_SHIPDATE">=TO_DATE(' 1995-01-01 00:00:00', 'syyyy-mm-dd
	      hh24:mi:ss') AND "L_SHIPDATE"<=TO_DATE(' 1996-12-31 00:00:00', 'sy
yyy-mm-dd

	      hh24:mi:ss'))
  10 - filter("N1"."N_NAME"='FRANCE' OR "N1"."N_NAME"='GERMANY')
  11 - filter(("N1"."N_NAME"='FRANCE' AND "N2"."N_NAME"='GERMANY' OR
	      "N1"."N_NAME"='GERMANY' AND "N2"."N_NAME"='FRANCE') AND
	      ("N2"."N_NAME"='FRANCE' OR "N2"."N_NAME"='GERMANY'))


Statistics
----------------------------------------------------------
	 26  recursive calls
	  7  db block gets
	 22  consistent gets
	  0  physical reads
       1088  redo size
	589  bytes sent via SQL*Net to client
       1138  bytes received via SQL*Net from client
	  1  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
	  0  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
```
