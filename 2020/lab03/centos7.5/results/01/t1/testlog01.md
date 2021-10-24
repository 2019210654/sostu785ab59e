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

SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jan 3 01:17:16 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sun Jan 03 2021 01:13:03 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21  
L L    SUM_QTY SUM_BASE_PRICE SUM_DISC_PRICE SUM_CHARGE    AVG_QTY  AVG_PRICE
- - ---------- -------------- -------------- ---------- ---------- ----------
  AVG_DISC COUNT_ORDER
---------- -----------
A F   37734107	   5.6587E+10	  5.3758E+10 5.5909E+10 25.5220059 38273.1297
.049985296     1478493

N F	991417	   1487504710	  1413082168 1469649223 25.5164719 38284.4678
.050093427	 38854

N O   74476040	   1.1170E+11	  1.0612E+11 1.1037E+11 25.5022268  38249.118
.049996586     2920374


L L    SUM_QTY SUM_BASE_PRICE SUM_DISC_PRICE SUM_CHARGE    AVG_QTY  AVG_PRICE
- - ---------- -------------- -------------- ---------- ---------- ----------
  AVG_DISC COUNT_ORDER
---------- -----------
R F   37719753	   5.6568E+10	  5.3741E+10 5.5890E+10 25.5057936 38250.8546
.050009406     1478870


Elapsed: 00:00:04.35

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
	  0  recursive calls
	  0  db block gets
     108299  consistent gets
	  0  physical reads
	  0  redo size
       1776  bytes sent via SQL*Net to client
	880  bytes received via SQL*Net from client
	  2  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
	  4  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
# 01.sql:20210103011716:20210103011721:1609654637:1609654642:5 #
```
