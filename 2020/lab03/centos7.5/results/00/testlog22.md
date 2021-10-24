```bash
oracle@FOO:queries$ ./runsql.sh -v stub/22.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q22)
     4	
     5	select
     6		cntrycode,
     7		count(*) as numcust,
     8		sum(c_acctbal) as totacctbal
     9	from
    10		(
    11			select
    12				--substring(c_phone from 1 for 2) as cntrycode,
    13				substr(c_phone, 1, 2) as cntrycode,
    14				c_acctbal
    15			from
    16				customer
    17			where
    18				--substring(c_phone from 1 for 2) in
    19				substr(c_phone, 1, 2) in
    20					('13', '31', '23', '29', '30', '18', '17')
    21				and c_acctbal > (
    22					select
    23						avg(c_acctbal)
    24					from
    25						customer
    26					where
    27						c_acctbal > 0.00
    28						--and substring(c_phone from 1 for 2) in
    29						and substr(c_phone, 1, 2) in
    30							('13', '31', '23', '29', '30', '18', '17')
    31				)
    32				and not exists (
    33					select
    34						*
    35					from
    36						orders
    37					where
    38						o_custkey = c_custkey
    39				)
    40		) --as custsale
    41	group by
    42		cntrycode
    43	order by
    44		cntrycode;
    45	--where rownum <= -1;
>>> stub/22.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 2 23:46:02 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sat Jan 02 2021 23:45:59 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28   29   30   31   32   33   34   35   36   37   38   39   40  
no rows selected

Elapsed: 00:00:00.03

Execution Plan
----------------------------------------------------------
Plan hash value: 2066112646

--------------------------------------------------------------------------------
--

| Id  | Operation	      | Name	 | Rows  | Bytes | Cost (%CPU)| Time
 |

--------------------------------------------------------------------------------
--

|   0 | SELECT STATEMENT      | 	 |     1 |    56 |     7  (15)| 00:00:01
 |

|   1 |  SORT GROUP BY	      | 	 |     1 |    56 |     7  (15)| 00:00:01
 |

|*  2 |   HASH JOIN ANTI      | 	 |     1 |    56 |     4   (0)| 00:00:01
 |

|*  3 |    TABLE ACCESS FULL  | CUSTOMER |     1 |    43 |     2   (0)| 00:00:01
 |

|   4 |     SORT AGGREGATE    | 	 |     1 |    30 |	      |
 |

|*  5 |      TABLE ACCESS FULL| CUSTOMER |     1 |    30 |     2   (0)| 00:00:01
 |

|   6 |    TABLE ACCESS FULL  | ORDERS	 |     1 |    13 |     2   (0)| 00:00:01
 |

--------------------------------------------------------------------------------
--


Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("O_CUSTKEY"="C_CUSTKEY")
   3 - filter((SUBSTR("C_PHONE",1,2)='13' OR SUBSTR("C_PHONE",1,2)='31'
	      OR SUBSTR("C_PHONE",1,2)='23' OR SUBSTR("C_PHONE",1,2)='29' OR
	      SUBSTR("C_PHONE",1,2)='30' OR SUBSTR("C_PHONE",1,2)='18' OR
	      SUBSTR("C_PHONE",1,2)='17') AND "C_ACCTBAL"> (SELECT
	      SUM("C_ACCTBAL")/COUNT("C_ACCTBAL") FROM "CUSTOMER" "CUSTOMER" WHE
RE

	      "C_ACCTBAL">0.00 AND (SUBSTR("C_PHONE",1,2)='13' OR
	      SUBSTR("C_PHONE",1,2)='31' OR SUBSTR("C_PHONE",1,2)='23' OR
	      SUBSTR("C_PHONE",1,2)='29' OR SUBSTR("C_PHONE",1,2)='30' OR
	      SUBSTR("C_PHONE",1,2)='18' OR SUBSTR("C_PHONE",1,2)='17')))
   5 - filter("C_ACCTBAL">0.00 AND (SUBSTR("C_PHONE",1,2)='13' OR
	      SUBSTR("C_PHONE",1,2)='31' OR SUBSTR("C_PHONE",1,2)='23' OR
	      SUBSTR("C_PHONE",1,2)='29' OR SUBSTR("C_PHONE",1,2)='30' OR
	      SUBSTR("C_PHONE",1,2)='18' OR SUBSTR("C_PHONE",1,2)='17'))


Statistics
----------------------------------------------------------
	 15  recursive calls
	  7  db block gets
	 11  consistent gets
	  0  physical reads
       1020  redo size
	510  bytes sent via SQL*Net to client
       1090  bytes received via SQL*Net from client
	  1  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
	  0  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
```
