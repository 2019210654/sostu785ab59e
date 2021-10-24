```
# Results of running 14.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q14)
     4	
     5	select
     6		100.00 * sum(case
     7			when p_type like 'PROMO%'
     8				then l_extendedprice * (1 - l_discount)
     9			else 0
    10		end) / sum(l_extendedprice * (1 - l_discount)) as promo_revenue
    11	from
    12		lineitem,
    13		part
    14	where
    15		l_partkey = p_partkey
    16		and l_shipdate >= date '1995-09-01'
    17		and l_shipdate < date '1995-09-01' + interval '1' month;
    18	--where rownum <= -1;
>>> dbgen/queries/stub/14.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jan 3 04:37:13 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sun Jan 03 2021 04:36:59 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13  
PROMO_REVENUE
-------------
   16.6475949

Elapsed: 00:00:11.07

Execution Plan
----------------------------------------------------------
Plan hash value: 3423467992

----------------------------------------------------------------------------------------
| Id  | Operation	    | Name     | Rows  | Bytes |TempSpc| Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT    |	       |     1 |    49 |       | 31171	 (1)| 00:00:02 |
|   1 |  SORT AGGREGATE     |	       |     1 |    49 |       |	    |          |
|*  2 |   HASH JOIN	    |	       | 73677 |  3525K|  2448K| 31171	 (1)| 00:00:02 |
|*  3 |    TABLE ACCESS FULL| LINEITEM | 73677 |  1582K|       | 29622	 (1)| 00:00:02 |
|   4 |    TABLE ACCESS FULL| PART     |   200K|  5273K|       |  1059	 (1)| 00:00:01 |
----------------------------------------------------------------------------------------


Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("L_PARTKEY"="P_PARTKEY")
   3 - filter("L_SHIPDATE">=TO_DATE(' 1995-09-01 00:00:00', 'syyyy-mm-dd
	      hh24:mi:ss') AND "L_SHIPDATE"<TO_DATE(' 1995-10-01 00:00:00', 'syy
yy-mm-dd

	      hh24:mi:ss'))

Note
-----
   - this is an adaptive plan


Statistics
----------------------------------------------------------
	  1  recursive calls
	  0  db block gets
    1134002  consistent gets
	  0  physical reads
	  0  redo size
	573  bytes sent via SQL*Net to client
	685  bytes received via SQL*Net from client
	  2  SQL*Net roundtrips to/from client
	  0  sorts (memory)
	  0  sorts (disk)
	  1  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
# 14.sql:20210103043713:20210103043725:1609666634:1609666646:12 #
```
