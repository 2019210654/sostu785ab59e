```bash
oracle@FOO:queries$ ./runsql.sh -v stub/08.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q8)
     4	
     5	select
     6		o_year,
     7		sum(case
     8			when nation = 'BRAZIL' then volume
     9			else 0
    10		end) / sum(volume) as mkt_share
    11	from
    12		(
    13			select
    14				extract(year from o_orderdate) as o_year,
    15				l_extendedprice * (1 - l_discount) as volume,
    16				n2.n_name as nation
    17			from
    18				part,
    19				supplier,
    20				lineitem,
    21				orders,
    22				customer,
    23				nation n1,
    24				nation n2,
    25				region
    26			where
    27				p_partkey = l_partkey
    28				and s_suppkey = l_suppkey
    29				and l_orderkey = o_orderkey
    30				and o_custkey = c_custkey
    31				and c_nationkey = n1.n_nationkey
    32				and n1.n_regionkey = r_regionkey
    33				and r_name = 'AMERICA'
    34				and s_nationkey = n2.n_nationkey
    35				and o_orderdate between date '1995-01-01' and date '1996-12-31'
    36				and p_type = 'ECONOMY ANODIZED STEEL'
    37		) --as all_nations
    38	group by
    39		o_year
    40	order by
    41		o_year;
    42	--where rownum <= -1;
>>> stub/08.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 2 23:45:18 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sat Jan 02 2021 23:45:15 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28   29   30   31   32   33   34   35   36   37  
no rows selected

Elapsed: 00:00:00.03

Execution Plan
----------------------------------------------------------
Plan hash value: 3723841851

--------------------------------------------------------------------------------
------

| Id  | Operation		  | Name     | Rows  | Bytes | Cost (%CPU)| Time
     |

--------------------------------------------------------------------------------
------

|   0 | SELECT STATEMENT	  |	     |	   1 |	 285 |	  17   (6)| 00:0
0:01 |

|   1 |  SORT GROUP BY		  |	     |	   1 |	 285 |	  17   (6)| 00:0
0:01 |

|*  2 |   HASH JOIN		  |	     |	   1 |	 285 |	  16   (0)| 00:0
0:01 |

|*  3 |    HASH JOIN		  |	     |	   1 |	 245 |	  14   (0)| 00:0
0:01 |

|*  4 |     HASH JOIN		  |	     |	   1 |	 205 |	  12   (0)| 00:0
0:01 |

|*  5 |      HASH JOIN		  |	     |	   1 |	 179 |	  10   (0)| 00:0
0:01 |

|*  6 |       HASH JOIN 	  |	     |	   1 |	 153 |	   8   (0)| 00:0
0:01 |

|*  7 |        HASH JOIN	  |	     |	   1 |	 118 |	   6   (0)| 00:0
0:01 |

|*  8 | 	HASH JOIN	  |	     |	   1 |	  92 |	   4   (0)| 00:0
0:01 |

|*  9 | 	 TABLE ACCESS FULL| PART     |	   1 |	  27 |	   2   (0)| 00:0
0:01 |

|  10 | 	 TABLE ACCESS FULL| LINEITEM |	   1 |	  65 |	   2   (0)| 00:0
0:01 |

|  11 | 	TABLE ACCESS FULL | SUPPLIER |	   1 |	  26 |	   2   (0)| 00:0
0:01 |

|* 12 |        TABLE ACCESS FULL  | ORDERS   |	   1 |	  35 |	   2   (0)| 00:0
0:01 |

|  13 |       TABLE ACCESS FULL   | CUSTOMER |	   1 |	  26 |	   2   (0)| 00:0
0:01 |

|  14 |      TABLE ACCESS FULL	  | NATION   |	   1 |	  26 |	   2   (0)| 00:0
0:01 |

|  15 |     TABLE ACCESS FULL	  | NATION   |	   1 |	  40 |	   2   (0)| 00:0
0:01 |

|* 16 |    TABLE ACCESS FULL	  | REGION   |	   1 |	  40 |	   2   (0)| 00:0
0:01 |

--------------------------------------------------------------------------------
------


Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("N1"."N_REGIONKEY"="R_REGIONKEY")
   3 - access("S_NATIONKEY"="N2"."N_NATIONKEY")
   4 - access("C_NATIONKEY"="N1"."N_NATIONKEY")
   5 - access("O_CUSTKEY"="C_CUSTKEY")
   6 - access("L_ORDERKEY"="O_ORDERKEY")
   7 - access("S_SUPPKEY"="L_SUPPKEY")
   8 - access("P_PARTKEY"="L_PARTKEY")
   9 - filter("P_TYPE"='ECONOMY ANODIZED STEEL')
  12 - filter("O_ORDERDATE">=TO_DATE(' 1995-01-01 00:00:00', 'syyyy-mm-dd
	      hh24:mi:ss') AND "O_ORDERDATE"<=TO_DATE(' 1996-12-31 00:00:00', 's
yyyy-mm-dd

	      hh24:mi:ss'))
  16 - filter("R_NAME"='AMERICA')


Statistics
----------------------------------------------------------
	 50  recursive calls
	 12  db block gets
	 34  consistent gets
	  0  physical reads
       2104  redo size
	429  bytes sent via SQL*Net to client
       1119  bytes received via SQL*Net from client
	  1  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
	  0  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
```
