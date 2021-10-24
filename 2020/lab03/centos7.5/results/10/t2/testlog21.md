```
# Results of running 21.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q21)
     4	-- using default substitutions
     5	-- Status: VERIFIED
     6	
     7	-- XXX: To get 'Execution Plan, Predicate Information and Statistics', please
     8	--      enable the line in the following
     9	-- set autotrace on;
    10	
    11	select
    12		s_name,
    13		count(*) as numwait
    14	from
    15		supplier,
    16		lineitem l1,
    17		orders,
    18		nation
    19	where
    20		s_suppkey = l1.l_suppkey
    21		and o_orderkey = l1.l_orderkey
    22		and o_orderstatus = 'F'
    23		and l1.l_receiptdate > l1.l_commitdate
    24		and exists (
    25			select
    26				*
    27			from
    28				lineitem l2
    29			where
    30				l2.l_orderkey = l1.l_orderkey
    31				and l2.l_suppkey <> l1.l_suppkey
    32		)
    33		and not exists (
    34			select
    35				*
    36			from
    37				lineitem l3
    38			where
    39				l3.l_orderkey = l1.l_orderkey
    40				and l3.l_suppkey <> l1.l_suppkey
    41				and l3.l_receiptdate > l3.l_commitdate
    42		)
    43		and s_nationkey = n_nationkey
    44		and n_name = 'SAUDI ARABIA'
    45	group by
    46		s_name
    47	order by
    48		numwait desc,
    49		s_name;
    50	--where rownum <= 100;
>>> dbgen/queries/stub/21.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jan 3 04:39:08 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sun Jan 03 2021 04:38:51 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL> SQL> SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28   29   30   31   32   33   34   35   36   37   38   39  
S_NAME			     NUMWAIT
------------------------- ----------
Supplier#000062538		  24
Supplier#000032858		  22
Supplier#000063723		  21
Supplier#000089484		  21
Supplier#000007061		  20
Supplier#000034162		  20
Supplier#000086690		  20
Supplier#000097808		  20
Supplier#000004163		  19
Supplier#000016074		  19
Supplier#000019756		  19

...<snip>...

S_NAME			     NUMWAIT
------------------------- ----------
Supplier#000006598		   2
Supplier#000016485		   2
Supplier#000031729		   2
Supplier#000098641		   2
Supplier#000086152		   1

4009 rows selected.

Elapsed: 00:00:42.39

Execution Plan
----------------------------------------------------------
Plan hash value: 2369321377

--------------------------------------------------------------------------------------------------
| Id  | Operation		     | Name	 | Rows  | Bytes |TempSpc| Cost (%CPU)| Time	 |
--------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT	     |		 |   100 |  2600 |	 |   79128 (1)| 00:00:04 |
|   1 |  SORT ORDER BY		     |		 |   100 |  2600 |	 |   79128 (1)| 00:00:04 |
|   2 |   HASH GROUP BY 	     |		 |   100 |  2600 |	 |   79128 (1)| 00:00:04 |
|   3 |    VIEW 		     | VM_NWVW_2 |   100 |  2600 |	 |   79126 (1)| 00:00:04 |
|*  4 |     FILTER		     |		 |	 |	 |	 |            | 	 |
|   5 |      HASH GROUP BY	     |		 |   100 | 17000 |	 |   79126 (1)| 00:00:04 |
|*  6 |       HASH JOIN 	     |		 |   258K|    41M|  9696K|   79120 (1)| 00:00:04 |
|*  7 |        HASH JOIN	     |		 | 63634 |  8948K|    15M|   38221 (1)| 00:00:02 |
|*  8 | 	HASH JOIN	     |		 |   121K|    14M|	 |   29704 (1)| 00:00:02 |
|   9 | 	 TABLE ACCESS FULL   | SUPPLIER  | 10000 |   439K|	 |      68 (0)| 00:00:01 |
|  10 | 	 MERGE JOIN CARTESIAN|		 |  3042K|   229M|	 |   29628 (1)| 00:00:02 |
|* 11 | 	  TABLE ACCESS FULL  | NATION	 |     1 |    41 |	 |       3 (0)| 00:00:01 |
|  12 | 	  BUFFER SORT	     |		 |  3042K|   110M|	 |   29625 (1)| 00:00:02 |
|* 13 | 	   TABLE ACCESS FULL | LINEITEM  |  3042K|   110M|	 |   29625 (1)| 00:00:02 |
|* 14 | 	TABLE ACCESS FULL    | ORDERS	 |   729K|    13M|	 |    6626 (1)| 00:00:01 |
|  15 |        TABLE ACCESS FULL     | LINEITEM  |  6001K|   148M|	 |   29617 (1)| 00:00:02 |
--------------------------------------------------------------------------------------------------


Predicate Information (identified by operation id):
---------------------------------------------------

   4 - filter(SUM(CASE	WHEN "L3"."L_RECEIPTDATE">"L3"."L_COMMITDATE" THEN 1 ELS
E 0 END

	      )=0)
   6 - access("L3"."L_ORDERKEY"="L1"."L_ORDERKEY")
       filter("L3"."L_SUPPKEY"<>"L1"."L_SUPPKEY")
   7 - access("O_ORDERKEY"="L1"."L_ORDERKEY")
   8 - access("S_SUPPKEY"="L1"."L_SUPPKEY" AND "S_NATIONKEY"="N_NATIONKEY")
  11 - filter("N_NAME"='SAUDI ARABIA')
  13 - filter("L1"."L_RECEIPTDATE">"L1"."L_COMMITDATE")
  14 - filter("O_ORDERSTATUS"='F')

Note
-----
   - this is an adaptive plan


Statistics
----------------------------------------------------------
	  1  recursive calls
	  0  db block gets
    2435554  consistent gets
	  0  physical reads
	  0  redo size
     176008  bytes sent via SQL*Net to client
       3934  bytes received via SQL*Net from client
	269  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
       4009  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
# 21.sql:20210103043908:20210103043951:1609666749:1609666792:43 #
```
