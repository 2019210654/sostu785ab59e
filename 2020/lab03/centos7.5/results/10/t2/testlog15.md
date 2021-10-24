```
# Results of running 15.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q15)
     4	
     5	create view revenue0 (supplier_no, total_revenue) as
     6		select
     7			l_suppkey,
     8			sum(l_extendedprice * (1 - l_discount))
     9		from
    10			lineitem
    11		where
    12			l_shipdate >= date '1996-01-01'
    13			and l_shipdate < date '1996-01-01' + interval '3' month
    14		group by
    15			l_suppkey;
    16	
    17	
    18	select
    19		s_suppkey,
    20		s_name,
    21		s_address,
    22		s_phone,
    23		total_revenue
    24	from
    25		supplier,
    26		revenue0
    27	where
    28		s_suppkey = supplier_no
    29		and total_revenue = (
    30			select
    31				max(total_revenue)
    32			from
    33				revenue0
    34		)
    35	order by
    36		s_suppkey;
    37	
    38	drop view revenue0;
    39	--where rownum <= -1;
>>> dbgen/queries/stub/15.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jan 3 04:37:25 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sun Jan 03 2021 04:37:13 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11  
View created.

Elapsed: 00:00:00.02
SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19  
 S_SUPPKEY S_NAME		     S_ADDRESS
---------- ------------------------- ----------------------------------------
S_PHONE 	TOTAL_REVENUE
--------------- -------------
     69998 Supplier#000069998	     ,ZT4VX2ygq9dLsG298SbYYSVUqeH,jhLSRVxNxGv
16-386-278-9829    2194132.82


Elapsed: 00:00:14.47

Execution Plan
----------------------------------------------------------
Plan hash value: 2450371371

-----------------------------------------------------------------------------------
| Id  | Operation	       | Name	  | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------------
|   0 | SELECT STATEMENT       |	  | 10000 |   996K| 29697   (1)| 00:00:02 |
|   1 |  MERGE JOIN	       |	  | 10000 |   996K| 29697   (1)| 00:00:02 |
|   2 |   SORT JOIN	       |	  | 10000 |   292K| 29627   (1)| 00:00:02 |
|*  3 |    VIEW 	       | REVENUE0 | 10000 |   292K| 29627   (1)| 00:00:02 |
|   4 |     WINDOW BUFFER      |	  | 10000 |   205K| 29627   (1)| 00:00:02 |
|   5 |      HASH GROUP BY     |	  | 10000 |   205K| 29627   (1)| 00:00:02 |
|*  6 |       TABLE ACCESS FULL| LINEITEM |   218K|  4484K| 29622   (1)| 00:00:02 |
|*  7 |   SORT JOIN	       |	  | 10000 |   703K|    69   (2)| 00:00:01 |
|   8 |    TABLE ACCESS FULL   | SUPPLIER | 10000 |   703K|    68   (0)| 00:00:01 |
-----------------------------------------------------------------------------------


Predicate Information (identified by operation id):
---------------------------------------------------

   3 - filter("TOTAL_REVENUE"="ITEM_1")
   6 - filter("L_SHIPDATE">=TO_DATE(' 1996-01-01 00:00:00', 'syyyy-mm-dd
	      hh24:mi:ss') AND "L_SHIPDATE"<TO_DATE(' 1996-04-01 00:00:00', 'syy
yy-mm-dd

	      hh24:mi:ss'))
   7 - access("S_SUPPKEY"="SUPPLIER_NO")
       filter("S_SUPPKEY"="SUPPLIER_NO")


Statistics
----------------------------------------------------------
	 15  recursive calls
	  0  db block gets
    1098224  consistent gets
	  0  physical reads
	  0  redo size
	959  bytes sent via SQL*Net to client
	579  bytes received via SQL*Net from client
	  2  SQL*Net roundtrips to/from client
	  3  sorts (memory)
	  0  sorts (disk)
	  1  rows processed

SQL> SQL> 
View dropped.

Elapsed: 00:00:00.01
SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
# 15.sql:20210103043725:20210103043740:1609666646:1609666661:15 #
```
