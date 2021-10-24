```
# Results of running 01.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q1)
     4	
     5	select
     6		l_returnflag,
     7		l_linestatus,
     8		sum(l_quantity) as sum_qty,
     9		sum(l_extendedprice) as sum_base_price,
    10		sum(l_extendedprice * (1 - l_discount)) as sum_disc_price,
    11		sum(l_extendedprice * (1 - l_discount) * (1 + l_tax)) as sum_charge,
    12		avg(l_quantity) as avg_qty,
    13		avg(l_extendedprice) as avg_price,
    14		avg(l_discount) as avg_disc,
    15		count(*) as count_order
    16	from
    17		lineitem
    18	where
    19		l_shipdate <= date '1998-12-01' - interval '90' day (3)
    20	group by
    21		l_returnflag,
    22		l_linestatus
    23	order by
    24		l_returnflag,
    25		l_linestatus;
    26	--where rownum <= -1;
>>> dbgen/queries/stub/01.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jan 3 03:42:11 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sun Jan 03 2021 03:41:24 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21  
L L    SUM_QTY SUM_BASE_PRICE SUM_DISC_PRICE SUM_CHARGE    AVG_QTY  AVG_PRICE
- - ---------- -------------- -------------- ---------- ---------- ----------
  AVG_DISC COUNT_ORDER
---------- -----------
A F  377518399	   5.6607E+11	  5.3776E+11 5.5928E+11 25.5009751  38237.151
.050006575    14804077

N F    9851614	   1.4767E+10	  1.4029E+10 1.4590E+10 25.5224483 38257.8107
.049973368	385998

N O  743124873	   1.1143E+12	  1.0586E+12 1.1009E+12 25.4980759 38233.9029
.050000812    29144351


L L    SUM_QTY SUM_BASE_PRICE SUM_DISC_PRICE SUM_CHARGE    AVG_QTY  AVG_PRICE
- - ---------- -------------- -------------- ---------- ---------- ----------
  AVG_DISC COUNT_ORDER
---------- -----------
R F  377732830	   5.6643E+11	  5.3811E+11 5.5963E+11 25.5083848 38251.2193
.049996792    14808183


Elapsed: 00:00:40.67

Execution Plan
----------------------------------------------------------
Plan hash value: 119192358

-------------------------------------------------------------------------------
| Id  | Operation	   | Name     | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |	      |     5 |   135 | 29776	(1)| 00:00:02 |
|   1 |  SORT GROUP BY	   |	      |     5 |   135 | 29776	(1)| 00:00:02 |
|*  2 |   TABLE ACCESS FULL| LINEITEM |  5789K|   149M| 29618	(1)| 00:00:02 |
-------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   2 - filter("L_SHIPDATE"<=TO_DATE(' 1998-09-02 00:00:00',
	      'syyyy-mm-dd hh24:mi:ss'))


Statistics
----------------------------------------------------------
	 29  recursive calls
	  0  db block gets
    1096146  consistent gets
	  4  physical reads
	  0  redo size
       1786  bytes sent via SQL*Net to client
	880  bytes received via SQL*Net from client
	  2  SQL*Net roundtrips to/from client
	  6  sorts (memory)
	  0  sorts (disk)
	  4  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
# 01.sql:20210103034211:20210103034253:1609663331:1609663373:42 #
```
