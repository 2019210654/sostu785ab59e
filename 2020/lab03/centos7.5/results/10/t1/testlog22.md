```
# Results of running 22.sql
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
>>> dbgen/queries/stub/22.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jan 3 03:49:37 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sun Jan 03 2021 03:48:55 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28   29   30   31   32   33   34   35   36   37   38   39   40  
CNTRYCOD    NUMCUST TOTACCTBAL
-------- ---------- ----------
13	       9025 67592468.3
17	       9067 68084663.3
18	       9210 69312783.6
23	       8984 67607771.3
29	       9199 69015438.3
30	       9343   70118838
31	       9086 68144525.4

7 rows selected.

Elapsed: 00:00:03.76

Execution Plan
----------------------------------------------------------
Plan hash value: 2066112646

--------------------------------------------------------------------------------
--

| Id  | Operation	      | Name	 | Rows  | Bytes | Cost (%CPU)| Time
 |

--------------------------------------------------------------------------------
--

|   0 | SELECT STATEMENT      | 	 |     1 |    32 |  8551   (1)| 00:00:01
 |

|   1 |  SORT GROUP BY	      | 	 |     1 |    32 |  8551   (1)| 00:00:01
 |

|*  2 |   HASH JOIN ANTI      | 	 |     5 |   160 |  7577   (1)| 00:00:01
 |

|*  3 |    TABLE ACCESS FULL  | CUSTOMER |   510 | 13770 |   958   (1)| 00:00:01
 |

|   4 |     SORT AGGREGATE    | 	 |     1 |    22 |	      |
 |

|*  5 |      TABLE ACCESS FULL| CUSTOMER |  9264 |   199K|   973   (2)| 00:00:01
 |

|   6 |    TABLE ACCESS FULL  | ORDERS	 |  1500K|  7324K|  6615   (1)| 00:00:01
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
	  5  recursive calls
	  0  db block gets
     309918  consistent gets
	  0  physical reads
	  0  redo size
	879  bytes sent via SQL*Net to client
       1101  bytes received via SQL*Net from client
	  2  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
	  7  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
# 22.sql:20210103034937:20210103034941:1609663777:1609663782:5 #
```
