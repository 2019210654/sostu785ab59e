```
# Results of running 07.sql
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
>>> dbgen/queries/stub/07.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jan 3 03:44:16 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sun Jan 03 2021 03:44:04 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28   29   30   31   32   33   34   35   36   37   38   39  
SUPP_NATION		  CUST_NATION			L_YEAR	  REVENUE
------------------------- ------------------------- ---------- ----------
FRANCE			  GERMANY			  1995	521960142
FRANCE			  GERMANY			  1996	524796110
GERMANY 		  FRANCE			  1995	542199700
GERMANY 		  FRANCE			  1996	533640926

Elapsed: 00:00:20.65

Execution Plan
----------------------------------------------------------
Plan hash value: 381073592

--------------------------------------------------------------------------------
------------

| Id  | Operation		| Name	   | Rows  | Bytes |TempSpc| Cost (%CPU)
| Time	   |

--------------------------------------------------------------------------------
------------

|   0 | SELECT STATEMENT	|	   |  1464 |   158K|	   | 40511   (1)
| 00:00:02 |

|   1 |  SORT GROUP BY		|	   |  1464 |   158K|	   | 40511   (1)
| 00:00:02 |

|*  2 |   HASH JOIN		|	   |  5642 |   611K|  2936K| 40510   (1)
| 00:00:02 |

|   3 |    TABLE ACCESS FULL	| CUSTOMER |   150K|  1171K|	   |   957   (1)
| 00:00:01 |

|*  4 |    HASH JOIN		|	   |   141K|	13M|	13M| 38642   (1)
| 00:00:02 |

|*  5 |     HASH JOIN		|	   |   139K|	12M|	   | 29703   (1)
| 00:00:02 |

|*  6 |      HASH JOIN		|	   |   799 | 51935 |	   |	75   (0)
| 00:00:01 |

|   7 |       NESTED LOOPS	|	   |	 2 |   116 |	   |	 7   (0)
| 00:00:01 |

|*  8 |        TABLE ACCESS FULL| NATION   |	 2 |	58 |	   |	 3   (0)
| 00:00:01 |

|*  9 |        TABLE ACCESS FULL| NATION   |	 1 |	29 |	   |	 2   (0)
| 00:00:01 |

|  10 |       TABLE ACCESS FULL | SUPPLIER | 10000 | 70000 |	   |	68   (0)
| 00:00:01 |

|* 11 |      TABLE ACCESS FULL	| LINEITEM |  1739K|	44M|	   | 29623   (1)
| 00:00:02 |

|  12 |     TABLE ACCESS FULL	| ORDERS   |  1500K|	15M|	   |  6615   (1)
| 00:00:01 |

--------------------------------------------------------------------------------
------------


Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("C_CUSTKEY"="O_CUSTKEY" AND "C_NATIONKEY"="N2"."N_NATIONKEY")
   4 - access("O_ORDERKEY"="L_ORDERKEY")
   5 - access("S_SUPPKEY"="L_SUPPKEY")
   6 - access("S_NATIONKEY"="N1"."N_NATIONKEY")
   8 - filter("N1"."N_NAME"='FRANCE' OR "N1"."N_NAME"='GERMANY')
   9 - filter(("N1"."N_NAME"='FRANCE' AND "N2"."N_NAME"='GERMANY' OR
	      "N1"."N_NAME"='GERMANY' AND "N2"."N_NAME"='FRANCE') AND ("N2"."N_N
AME"='FRANCE' OR

	      "N2"."N_NAME"='GERMANY'))
  11 - filter("L_SHIPDATE">=TO_DATE(' 1995-01-01 00:00:00', 'syyyy-mm-dd
	      hh24:mi:ss') AND "L_SHIPDATE"<=TO_DATE(' 1996-12-31 00:00:00', 'sy
yyy-mm-dd

	      hh24:mi:ss'))


Statistics
----------------------------------------------------------
	 13  recursive calls
	  0  db block gets
    1373819  consistent gets
	  0  physical reads
	  0  redo size
       1053  bytes sent via SQL*Net to client
       1149  bytes received via SQL*Net from client
	  2  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
	  4  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
# 07.sql:20210103034416:20210103034437:1609663456:1609663477:21 #
```
