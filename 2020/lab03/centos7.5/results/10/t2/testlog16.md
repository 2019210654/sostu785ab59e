```
# Results of running 16.sql
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
>>> dbgen/queries/stub/16.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jan 3 04:37:41 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sun Jan 03 2021 04:37:26 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28   29   30  
P_BRAND    P_TYPE			 P_SIZE SUPPLIER_CNT
---------- ------------------------- ---------- ------------
Brand#44   STANDARD PLATED TIN		      9 	 120
Brand#12   STANDARD POLISHED COPPER	     14 	 100
Brand#11   LARGE BRUSHED STEEL		     36 	  96
Brand#23   PROMO BURNISHED STEEL	     14 	  96
Brand#34   MEDIUM BRUSHED STEEL 	     23 	  96
Brand#53   PROMO BURNISHED BRASS	     36 	  96
Brand#54   STANDARD BRUSHED COPPER	     19 	  96
Brand#32   LARGE POLISHED COPPER	     14 	  95
Brand#43   LARGE PLATED COPPER		     19 	  95
Brand#11   SMALL BRUSHED STEEL		      9 	  92
Brand#11   STANDARD BRUSHED TIN 	     23 	  92

...<snip>...

P_BRAND    P_TYPE			 P_SIZE SUPPLIER_CNT
---------- ------------------------- ---------- ------------
Brand#51   ECONOMY BURNISHED NICKEL	     36 	   8
Brand#52   SMALL BRUSHED TIN		     36 	   8
Brand#53   MEDIUM PLATED STEEL		     23 	   8
Brand#54   SMALL PLATED BRASS		      3 	   8
Brand#54   STANDARD ANODIZED COPPER	     36 	   8
Brand#42   ECONOMY ANODIZED NICKEL	     14 	   4
Brand#44   MEDIUM PLATED TIN		      3 	   4
Brand#52   STANDARD BRUSHED TIN 	      3 	   4
Brand#54   ECONOMY PLATED BRASS 	     14 	   4
Brand#55   STANDARD BURNISHED BRASS	     14 	   4

27840 rows selected.

Elapsed: 00:00:04.62

Execution Plan
----------------------------------------------------------
Plan hash value: 2746820306

----------------------------------------------------------------------------------------------
| Id  | Operation		 | Name      | Rows  | Bytes |TempSpc| Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT	 |	     | 15000 |	 717K|	     |	8759   (1)| 00:00:01 |
|   1 |  SORT ORDER BY		 |	     | 15000 |	 717K|	     |	8759   (1)| 00:00:01 |
|   2 |   HASH GROUP BY 	 |	     | 15000 |	 717K|	     |	8759   (1)| 00:00:01 |
|   3 |    VIEW 		 | VM_NWVW_1 |	 111K|	5317K|	     |	8753   (1)| 00:00:01 |
|   4 |     HASH GROUP BY	 |	     |	 111K|	  12M|	  13M|	8753   (1)| 00:00:01 |
|*  5 |      HASH JOIN RIGHT ANTI|	     |	 111K|	  12M|	     |	5809   (1)| 00:00:01 |
|*  6 |       TABLE ACCESS FULL  | SUPPLIER  |	 500 | 34000 |	     |	  68   (0)| 00:00:01 |
|*  7 |       HASH JOIN 	 |	     |	 116K|	5711K|	     |	5741   (1)| 00:00:01 |
|*  8 |        TABLE ACCESS FULL | PART      | 29531 |	1182K|	     |	1061   (1)| 00:00:01 |
|   9 |        TABLE ACCESS FULL | PARTSUPP  |	 800K|	7031K|	     |	4677   (1)| 00:00:01 |
----------------------------------------------------------------------------------------------


Predicate Information (identified by operation id):
---------------------------------------------------

   5 - access("PS_SUPPKEY"="S_SUPPKEY")
   6 - filter("S_COMMENT" LIKE '%Customer%Complaints%')
   7 - access("P_PARTKEY"="PS_PARTKEY")
   8 - filter(("P_SIZE"=3 OR "P_SIZE"=9 OR "P_SIZE"=14 OR "P_SIZE"=19 OR "P_SIZE
"=23

	      OR "P_SIZE"=36 OR "P_SIZE"=45 OR "P_SIZE"=49) AND "P_TYPE" NOT LIK
E 'MEDIUM

	      POLISHED%' AND "P_BRAND"<>'Brand#45')


Statistics
----------------------------------------------------------
	  9  recursive calls
	  0  db block gets
     205960  consistent gets
	  0  physical reads
	  0  redo size
    1037527  bytes sent via SQL*Net to client
      21229  bytes received via SQL*Net from client
       1857  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
      27840  rows processed

SQL> SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
# 16.sql:20210103043741:20210103043746:1609666661:1609666666:5 #
```
