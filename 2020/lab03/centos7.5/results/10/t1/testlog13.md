```
# Results of running 13.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q13)
     4	
     5	select
     6		c_count,
     7		count(*) as custdist
     8	from
     9		(
    10			select
    11				c_custkey,
    12				--count(o_orderkey)
    13				count(o_orderkey) as c_count
    14			from
    15				customer left outer join orders on
    16					c_custkey = o_custkey
    17					and o_comment not like '%special%requests%'
    18			group by
    19				c_custkey
    20		) --as c_orders (c_custkey, c_count)
    21	group by
    22		c_count
    23	order by
    24		custdist desc,
    25		c_count desc;
    26	--where rownum <= -1;
>>> dbgen/queries/stub/13.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jan 3 03:46:38 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sun Jan 03 2021 03:46:20 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21  
   C_COUNT   CUSTDIST
---------- ----------
	 0     500021
	10	66157
	 9	65243
	11	62072
	 8	58350
	12	55821
	13	49811
	 7	46847
	19	46641
	18	46259
	14	45226

   C_COUNT   CUSTDIST
---------- ----------
	17	45186
	20	45154
	16	43908
	15	43818
	21	42360
	22	37945
	 6	32771
	23	32679
	24	26658
	25	21098
	 5	19709

   C_COUNT   CUSTDIST
---------- ----------
	26	15895
	27	11695
	 4	 9922
	28	 8221
	29	 5599
	 3	 4063
	30	 3679
	31	 2327
	32	 1500
	 2	 1206
	33	  854

   C_COUNT   CUSTDIST
---------- ----------
	34	  506
	35	  248
	 1	  233
	36	  155
	37	   73
	38	   47
	39	   19
	40	   12
	42	    4
	41	    4
	44	    2

   C_COUNT   CUSTDIST
---------- ----------
	45	    1
	43	    1

46 rows selected.

Elapsed: 00:00:13.42

Execution Plan
----------------------------------------------------------
Plan hash value: 632526761

--------------------------------------------------------------------------------
--------------

| Id  | Operation		  | Name     | Rows  | Bytes |TempSpc| Cost (%CP
U)| Time     |

--------------------------------------------------------------------------------
--------------

|   0 | SELECT STATEMENT	  |	     |	 100K|	1278K|	     | 16250   (
1)| 00:00:01 |

|   1 |  SORT ORDER BY		  |	     |	 100K|	1278K|	     | 16250   (
1)| 00:00:01 |

|   2 |   HASH GROUP BY 	  |	     |	 100K|	1278K|	     | 16250   (
1)| 00:00:01 |

|   3 |    VIEW 		  |	     |	 100K|	1278K|	     | 16244   (
1)| 00:00:01 |

|   4 |     SORT GROUP BY NOSORT  |	     |	 100K|	2262K|	     | 16244   (
1)| 00:00:01 |

|   5 |      MERGE JOIN OUTER	  |	     |	 150K|	3369K|	     | 16244   (
1)| 00:00:01 |

|   6 |       SORT JOIN 	  |	     |	 150K|	 732K|	3544K|	1415   (
1)| 00:00:01 |

|   7 |        TABLE ACCESS FULL  | CUSTOMER |	 150K|	 732K|	     |	 956   (
1)| 00:00:01 |

|*  8 |       SORT JOIN 	  |	     |	 100K|	1770K|	5560K| 14829   (
1)| 00:00:01 |

|   9 |        VIEW		  | VW_GBC_6 |	 100K|	1770K|	     | 14254   (
1)| 00:00:01 |

|  10 | 	HASH GROUP BY	  |	     |	 100K|	5409K|	  87M| 14254   (
1)| 00:00:01 |

|* 11 | 	 TABLE ACCESS FULL| ORDERS   |	1425K|	  74M|	     |	6625   (
1)| 00:00:01 |

--------------------------------------------------------------------------------
--------------


Predicate Information (identified by operation id):
---------------------------------------------------

   8 - access("C_CUSTKEY"="ITEM_1"(+))
       filter("C_CUSTKEY"="ITEM_1"(+))
  11 - filter("O_COMMENT"(+) NOT LIKE '%special%requests%')


Statistics
----------------------------------------------------------
	 25  recursive calls
	  0  db block gets
     275647  consistent gets
	  3  physical reads
	  0  redo size
       1642  bytes sent via SQL*Net to client
	765  bytes received via SQL*Net from client
	  5  SQL*Net roundtrips to/from client
	 16  sorts (memory)
	  0  sorts (disk)
	 46  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
# 13.sql:20210103034638:20210103034652:1609663599:1609663613:14 #
```
