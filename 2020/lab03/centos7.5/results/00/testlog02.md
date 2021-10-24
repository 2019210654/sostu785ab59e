```bash
oracle@FOO:queries$ ./runsql.sh -v stub/02.sql 
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
>>> stub/02.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 2 23:36:42 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sat Jan 02 2021 23:36:36 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28   29   30   31   32   33   34   35   36   37   38   39   40   41   42   43  
no rows selected

Elapsed: 00:00:00.05

Execution Plan
----------------------------------------------------------
Plan hash value: 3559856647

--------------------------------------------------------------------------------
-------

| Id  | Operation		   | Name     | Rows  | Bytes | Cost (%CPU)| Tim
e     |

--------------------------------------------------------------------------------
-------

|   0 | SELECT STATEMENT	   |	      |     1 |   210 |    12  (17)| 00:
00:01 |

|   1 |  SORT ORDER BY		   |	      |     1 |   210 |    12  (17)| 00:
00:01 |

|*  2 |   VIEW			   | VW_WIF_1 |     1 |   210 |    11  (10)| 00:
00:01 |

|   3 |    WINDOW SORT		   |	      |     1 |   368 |    11  (10)| 00:
00:01 |

|*  4 |     HASH JOIN		   |	      |     1 |   368 |    10	(0)| 00:
00:01 |

|   5 |      MERGE JOIN CARTESIAN  |	      |     1 |   317 |     8	(0)| 00:
00:01 |

|*  6 |       HASH JOIN 	   |	      |     1 |   250 |     6	(0)| 00:
00:01 |

|   7 |        MERGE JOIN CARTESIAN|	      |     1 |   197 |     4	(0)| 00:
00:01 |

|*  8 | 	TABLE ACCESS FULL  | REGION   |     1 |    40 |     2	(0)| 00:
00:01 |

|   9 | 	BUFFER SORT	   |	      |     1 |   157 |     2	(0)| 00:
00:01 |

|  10 | 	 TABLE ACCESS FULL | SUPPLIER |     1 |   157 |     2	(0)| 00:
00:01 |

|  11 |        TABLE ACCESS FULL   | NATION   |     1 |    53 |     2	(0)| 00:
00:01 |

|  12 |       BUFFER SORT	   |	      |     1 |    67 |     6	(0)| 00:
00:01 |

|* 13 |        TABLE ACCESS FULL   | PART     |     1 |    67 |     2	(0)| 00:
00:01 |

|  14 |      TABLE ACCESS FULL	   | PARTSUPP |     1 |    51 |     2	(0)| 00:
00:01 |

--------------------------------------------------------------------------------
-------


Predicate Information (identified by operation id):
---------------------------------------------------

   2 - filter("VW_COL_9" IS NOT NULL)
   4 - access("S_SUPPKEY"="PS_SUPPKEY" AND "P_PARTKEY"="PS_PARTKEY")
   6 - access("N_REGIONKEY"="R_REGIONKEY" AND "S_NATIONKEY"="N_NATIONKEY")
   8 - filter("R_NAME"='EUROPE')
  13 - filter("P_SIZE"=15 AND "P_TYPE" LIKE '%BRASS')


Statistics
----------------------------------------------------------
	 68  recursive calls
	 99  db block gets
	 53  consistent gets
	  0  physical reads
      19908  redo size
	895  bytes sent via SQL*Net to client
       1007  bytes received via SQL*Net from client
	  1  SQL*Net roundtrips to/from client
	  2  sorts (memory)
	  0  sorts (disk)
	  0  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
```
