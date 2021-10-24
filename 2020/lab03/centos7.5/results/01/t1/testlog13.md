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

SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jan 3 01:17:56 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sun Jan 03 2021 01:17:53 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21  
   C_COUNT   CUSTDIST
---------- ----------
	 0	50005
	 9	 6641
	10	 6532
	11	 6014
	 8	 5937
	12	 5639
	13	 5024
	19	 4793
	 7	 4687
	17	 4587
	18	 4529

   C_COUNT   CUSTDIST
---------- ----------
	20	 4516
	15	 4505
	14	 4446
	16	 4273
	21	 4190
	22	 3623
	 6	 3265
	23	 3225
	24	 2742
	25	 2086
	 5	 1948

   C_COUNT   CUSTDIST
---------- ----------
	26	 1612
	27	 1179
	 4	 1007
	28	  893
	29	  593
	 3	  415
	30	  376
	31	  226
	32	  148
	 2	  134
	33	   75

   C_COUNT   CUSTDIST
---------- ----------
	34	   50
	35	   37
	 1	   17
	36	   14
	38	    5
	37	    5
	40	    4
	41	    2
	39	    1

42 rows selected.

Elapsed: 00:00:01.41

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
	  0  recursive calls
	  0  db block gets
      27606  consistent gets
	  0  physical reads
	  0  redo size
       1443  bytes sent via SQL*Net to client
	754  bytes received via SQL*Net from client
	  4  SQL*Net roundtrips to/from client
	  3  sorts (memory)
	  0  sorts (disk)
	 42  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
# 13.sql:20210103011756:20210103011758:1609654676:1609654678:2 #
```
