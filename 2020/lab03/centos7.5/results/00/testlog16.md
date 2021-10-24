```bash
oracle@FOO:queries$ ./runsql.sh -v stub/16.sql
     1	set autotrace on;
     2	set timing on;
     3	-- TPC-H/TPC-R Pricing Summary Report Query (Q16)
     4	
     5	select
     6		p_brand,
     7		p_type,
     8		p_size,
     9		count(distinct ps_suppkey) as supplier_cnt
    10	from
    11		partsupp,
    12		part
    13	where
    14		p_partkey = ps_partkey
    15		and p_brand <> 'Brand#45'
    16		and p_type not like 'MEDIUM POLISHED%'
    17		and p_size in (49, 14, 23, 45, 19, 3, 36, 9)
    18		and ps_suppkey not in (
    19			select
    20				s_suppkey
    21			from
    22				supplier
    23			where
    24				s_comment like '%Customer%Complaints%'
    25		)
    26	group by
    27		p_brand,
    28		p_type,
    29		p_size
    30	order by
    31		supplier_cnt desc,
    32		p_brand,
    33		p_type,
    34		p_size;
    35	--where rownum <= -1;
>>> stub/16.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 2 23:45:43 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sat Jan 02 2021 23:45:40 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28   29   30  
no rows selected

Elapsed: 00:00:00.03

Execution Plan
----------------------------------------------------------
Plan hash value: 258501917

--------------------------------------------------------------------------------
-----

| Id  | Operation		| Name	    | Rows  | Bytes | Cost (%CPU)| Time
    |

--------------------------------------------------------------------------------
-----

|   0 | SELECT STATEMENT	|	    |	  1 |	 52 |	  9  (34)| 00:00
:01 |

|   1 |  SORT ORDER BY		|	    |	  1 |	 52 |	  9  (34)| 00:00
:01 |

|   2 |   HASH GROUP BY 	|	    |	  1 |	 52 |	  9  (34)| 00:00
:01 |

|   3 |    VIEW 		| VM_NWVW_1 |	  1 |	 52 |	  7  (15)| 00:00
:01 |

|   4 |     HASH GROUP BY	|	    |	  1 |	143 |	  7  (15)| 00:00
:01 |

|*  5 |      HASH JOIN ANTI	|	    |	  1 |	143 |	  6   (0)| 00:00
:01 |

|*  6 |       HASH JOIN 	|	    |	  1 |	 78 |	  4   (0)| 00:00
:01 |

|*  7 |        TABLE ACCESS FULL| PART	    |	  1 |	 52 |	  2   (0)| 00:00
:01 |

|   8 |        TABLE ACCESS FULL| PARTSUPP  |	  1 |	 26 |	  2   (0)| 00:00
:01 |

|*  9 |       TABLE ACCESS FULL | SUPPLIER  |	  1 |	 65 |	  2   (0)| 00:00
:01 |

--------------------------------------------------------------------------------
-----


Predicate Information (identified by operation id):
---------------------------------------------------

   5 - access("PS_SUPPKEY"="S_SUPPKEY")
   6 - access("P_PARTKEY"="PS_PARTKEY")
   7 - filter("P_TYPE" NOT LIKE 'MEDIUM POLISHED%' AND ("P_SIZE"=3 OR
	      "P_SIZE"=9 OR "P_SIZE"=14 OR "P_SIZE"=19 OR "P_SIZE"=23 OR "P_SIZE
"=36 OR

	      "P_SIZE"=45 OR "P_SIZE"=49) AND "P_BRAND"<>'Brand#45')
   9 - filter("S_COMMENT" LIKE '%Customer%Complaints%')


Statistics
----------------------------------------------------------
	 27  recursive calls
	 13  db block gets
	 15  consistent gets
	  0  physical reads
       1956  redo size
	585  bytes sent via SQL*Net to client
	813  bytes received via SQL*Net from client
	  1  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
	  0  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
```
