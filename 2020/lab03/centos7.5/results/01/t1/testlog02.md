```
# Results of running 02.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q2)
     4	
     5	select
     6		s_acctbal,
     7		s_name,
     8		n_name,
     9		p_partkey,
    10		p_mfgr,
    11		s_address,
    12		s_phone,
    13		s_comment
    14	from
    15		part,
    16		supplier,
    17		partsupp,
    18		nation,
    19		region
    20	where
    21		p_partkey = ps_partkey
    22		and s_suppkey = ps_suppkey
    23		and p_size = 15
    24		and p_type like '%BRASS'
    25		and s_nationkey = n_nationkey
    26		and n_regionkey = r_regionkey
    27		and r_name = 'EUROPE'
    28		and ps_supplycost = (
    29			select
    30				min(ps_supplycost)
    31			from
    32				partsupp,
    33				supplier,
    34				nation,
    35				region
    36			where
    37				p_partkey = ps_partkey
    38				and s_suppkey = ps_suppkey
    39				and s_nationkey = n_nationkey
    40				and n_regionkey = r_regionkey
    41				and r_name = 'EUROPE'
    42		)
    43	order by
    44		s_acctbal desc,
    45		n_name,
    46		s_name,
    47		p_partkey;
    48	--where rownum <= 100;
>>> dbgen/queries/stub/02.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jan 3 01:17:22 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sun Jan 03 2021 01:17:16 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28   29   30   31   32   33   34   35   36   37   38   39   40   41   42   43  
 S_ACCTBAL S_NAME		     N_NAME			P_PARTKEY
---------- ------------------------- ------------------------- ----------
P_MFGR			  S_ADDRESS
------------------------- ----------------------------------------
S_PHONE
---------------
S_COMMENT
--------------------------------------------------------------------------------
   9938.53 Supplier#000005359	     UNITED KINGDOM		   185358
Manufacturer#4		  QKuHYh,vZGiwu2FWEJoLDx04
33-429-790-6131
uriously regular requests hag

...<snip>...

 S_ACCTBAL S_NAME		     N_NAME			P_PARTKEY
---------- ------------------------- ------------------------- ----------
P_MFGR			  S_ADDRESS
------------------------- ----------------------------------------
S_PHONE
---------------
S_COMMENT
--------------------------------------------------------------------------------
es haggle blithe

   -986.14 Supplier#000003627	     FRANCE			   103626
Manufacturer#2		  77,1uiRw rXybJh
16-568-745-4062

 S_ACCTBAL S_NAME		     N_NAME			P_PARTKEY
---------- ------------------------- ------------------------- ----------
P_MFGR			  S_ADDRESS
------------------------- ----------------------------------------
S_PHONE
---------------
S_COMMENT
--------------------------------------------------------------------------------
closely blithely regular dolphins. fluffi


460 rows selected.

Elapsed: 00:00:00.43

Execution Plan
----------------------------------------------------------
Plan hash value: 3808617122

--------------------------------------------------------------------------------
-------

| Id  | Operation		   | Name     | Rows  | Bytes | Cost (%CPU)| Tim
e     |

--------------------------------------------------------------------------------
-------

|   0 | SELECT STATEMENT	   |	      |   155 | 32550 |  5816	(1)| 00:
00:01 |

|   1 |  SORT ORDER BY		   |	      |   155 | 32550 |  5816	(1)| 00:
00:01 |

|*  2 |   VIEW			   | VW_WIF_1 |   155 | 32550 |  5815	(1)| 00:
00:01 |

|   3 |    WINDOW SORT		   |	      |   155 | 44485 |  5815	(1)| 00:
00:01 |

|*  4 |     HASH JOIN		   |	      |   155 | 44485 |  5814	(1)| 00:
00:01 |

|   5 |      TABLE ACCESS FULL	   | NATION   |    25 |   800 |     3	(0)| 00:
00:01 |

|*  6 |      HASH JOIN		   |	      |   774 |   192K|  5810	(1)| 00:
00:01 |

|*  7 |       HASH JOIN 	   |	      |   774 | 85914 |  5742	(1)| 00:
00:01 |

|   8 |        MERGE JOIN CARTESIAN|	      |   195 | 16575 |  1062	(1)| 00:
00:01 |

|*  9 | 	TABLE ACCESS FULL  | REGION   |     1 |    29 |     3	(0)| 00:
00:01 |

|  10 | 	BUFFER SORT	   |	      |   195 | 10920 |  1059	(1)| 00:
00:01 |

|* 11 | 	 TABLE ACCESS FULL | PART     |   195 | 10920 |  1059	(1)| 00:
00:01 |

|  12 |        TABLE ACCESS FULL   | PARTSUPP |   800K|    19M|  4678	(1)| 00:
00:01 |

|  13 |       TABLE ACCESS FULL    | SUPPLIER | 10000 |  1406K|    68	(0)| 00:
00:01 |

--------------------------------------------------------------------------------
-------


Predicate Information (identified by operation id):
---------------------------------------------------

   2 - filter("VW_COL_9" IS NOT NULL)
   4 - access("N_REGIONKEY"="R_REGIONKEY" AND "S_NATIONKEY"="N_NATIONKEY")
   6 - access("S_SUPPKEY"="PS_SUPPKEY")
   7 - access("P_PARTKEY"="PS_PARTKEY")
   9 - filter("R_NAME"='EUROPE')
  11 - filter("P_SIZE"=15 AND "P_TYPE" LIKE '%BRASS')


Statistics
----------------------------------------------------------
	  5  recursive calls
	  0  db block gets
      20549  consistent gets
	  0  physical reads
	  0  redo size
      84979  bytes sent via SQL*Net to client
       1348  bytes received via SQL*Net from client
	 32  SQL*Net roundtrips to/from client
	  2  sorts (memory)
	  0  sorts (disk)
	460  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
# 02.sql:20210103011721:20210103011723:1609654642:1609654643:1 #
```
