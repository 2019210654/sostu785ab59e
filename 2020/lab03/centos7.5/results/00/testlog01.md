```bash
oracle@FOO:queries$ ./runsql.sh -v stub/01.sql
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
>>> stub/01.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 2 23:22:50 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sat Jan 02 2021 21:46:44 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21
no rows selected

Elapsed: 00:00:00.05

Execution Plan
----------------------------------------------------------
Plan hash value: 119192358

-------------------------------------------------------------------------------
| Id  | Operation	   | Name     | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |	      |     1 |    67 |     3  (34)| 00:00:01 |
|   1 |  SORT GROUP BY	   |	      |     1 |    67 |     3  (34)| 00:00:01 |
|*  2 |   TABLE ACCESS FULL| LINEITEM |     1 |    67 |     2	(0)| 00:00:01 |
-------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   2 - filter("L_SHIPDATE"<=TO_DATE(' 1998-09-02 00:00:00',
	      'syyyy-mm-dd hh24:mi:ss'))


Statistics
----------------------------------------------------------
	 44  recursive calls
	 54  db block gets
	 19  consistent gets
	  0  physical reads
      10292  redo size
       1078  bytes sent via SQL*Net to client
	869  bytes received via SQL*Net from client
	  1  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
	  0  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
```
