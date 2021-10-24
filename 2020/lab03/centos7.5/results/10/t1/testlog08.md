```
# Results of running 08.sql
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
>>> dbgen/queries/stub/08.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jan 3 03:44:37 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sun Jan 03 2021 03:44:16 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28   29   30   31   32   33   34   35   36   37  
    O_YEAR  MKT_SHARE
---------- ----------
      1995 .038820143
      1996 .039489687

Elapsed: 00:00:17.53

Execution Plan
----------------------------------------------------------
Plan hash value: 1554052670

--------------------------------------------------------------------------------
--------------

| Id  | Operation		  | Name     | Rows  | Bytes |TempSpc| Cost (%CP
U)| Time     |

--------------------------------------------------------------------------------
--------------

|   0 | SELECT STATEMENT	  |	     |	 732 |	 106K|	     | 39130   (
1)| 00:00:02 |

|   1 |  SORT GROUP BY		  |	     |	 732 |	 106K|	     | 39130   (
1)| 00:00:02 |

|*  2 |   HASH JOIN		  |	     |	2662 |	 387K|	     | 39129   (
1)| 00:00:02 |

|   3 |    TABLE ACCESS FULL	  | NATION   |	  25 |	 725 |	     |	   3   (
0)| 00:00:01 |

|*  4 |    HASH JOIN		  |	     |	2662 |	 311K|	     | 39126   (
1)| 00:00:02 |

|   5 |     TABLE ACCESS FULL	  | SUPPLIER | 10000 | 70000 |	     |	  68   (
0)| 00:00:01 |

|*  6 |     HASH JOIN		  |	     |	2662 |	 293K|	     | 39058   (
1)| 00:00:02 |

|*  7 |      TABLE ACCESS FULL	  | REGION   |	   1 |	  29 |	     |	   3   (
0)| 00:00:01 |

|*  8 |      HASH JOIN		  |	     | 13309 |	1091K|	     | 39055   (
1)| 00:00:02 |

|   9 |       TABLE ACCESS FULL   | NATION   |	  25 |	 150 |	     |	   3   (
0)| 00:00:01 |

|* 10 |       HASH JOIN 	  |	     | 13309 |	1013K|	     | 39052   (
1)| 00:00:02 |

|* 11 |        HASH JOIN	  |	     | 13309 |	 909K|	2656K| 38095   (
1)| 00:00:02 |

|* 12 | 	HASH JOIN	  |	     | 43115 |	2147K|	     | 30673   (
1)| 00:00:02 |

|* 13 | 	 TABLE ACCESS FULL| PART     |	1451 | 39177 |	     |	1059   (
1)| 00:00:01 |

|  14 | 	 TABLE ACCESS FULL| LINEITEM |	6001K|	 137M|	     | 29597   (
1)| 00:00:02 |

|* 15 | 	TABLE ACCESS FULL | ORDERS   |	 456K|	8471K|	     |	6621   (
1)| 00:00:01 |

|  16 |        TABLE ACCESS FULL  | CUSTOMER |	 150K|	1171K|	     |	 957   (
1)| 00:00:01 |

--------------------------------------------------------------------------------
--------------


Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("S_NATIONKEY"="N2"."N_NATIONKEY")
   4 - access("S_SUPPKEY"="L_SUPPKEY")
   6 - access("N1"."N_REGIONKEY"="R_REGIONKEY")
   7 - filter("R_NAME"='AMERICA')
   8 - access("C_NATIONKEY"="N1"."N_NATIONKEY")
  10 - access("O_CUSTKEY"="C_CUSTKEY")
  11 - access("L_ORDERKEY"="O_ORDERKEY")
  12 - access("P_PARTKEY"="L_PARTKEY")
  13 - filter("P_TYPE"='ECONOMY ANODIZED STEEL')
  15 - filter("O_ORDERDATE">=TO_DATE(' 1995-01-01 00:00:00', 'syyyy-mm-dd
	      hh24:mi:ss') AND "O_ORDERDATE"<=TO_DATE(' 1996-12-31 00:00:00', 's
yyyy-mm-dd

	      hh24:mi:ss'))


Statistics
----------------------------------------------------------
	 38  recursive calls
	  0  db block gets
    1411741  consistent gets
	  0  physical reads
	  0  redo size
	727  bytes sent via SQL*Net to client
       1130  bytes received via SQL*Net from client
	  2  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
	  2  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
# 08.sql:20210103034437:20210103034455:1609663477:1609663496:19 #
```
