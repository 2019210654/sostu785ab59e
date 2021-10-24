```
     1	set autotrace on;
     2	set timing on;
     3	ALTER SESSION SET sql_trace=TRUE;
     4	ALTER SESSION SET TRACEFILE_IDENTIFIER = 'HuanianLi';
     5	-- TPC-H/TPC-R Pricing Summary Report Query (Q10)
     6	
     7	select
     8		c_custkey,
     9		c_name,
    10		sum(l_extendedprice * (1 - l_discount)) as revenue,
    11		c_acctbal,
    12		n_name,
    13		c_address,
    14		c_phone,
    15		c_comment
    16	from
    17		customer,
    18		orders,
    19		lineitem,
    20		nation
    21	where
    22		c_custkey = o_custkey
    23		and l_orderkey = o_orderkey
    24		and o_orderdate >= date '1993-10-01'
    25		and o_orderdate < date '1993-10-01' + interval '3' month
    26		and l_returnflag = 'R'
    27		and c_nationkey = n_nationkey
    28	group by
    29		c_custkey,
    30		c_name,
    31		c_acctbal,
    32		c_phone,
    33		n_name,
    34		c_address,
    35		c_comment
    36	order by
    37		revenue desc;
    38	--where rownum <= 20;
    39	ALTER SESSION SET sql_trace=FALSE;
    40	SELECT value FROM v$diag_info WHERE name = 'Default Trace File';
>>> stub/10.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jan 3 08:35:44 2021
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Last Successful login time: Sun Jan 03 2021 08:24:46 -05:00

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> SQL> SQL> 
Session altered.

Elapsed: 00:00:00.00
SQL> 
Session altered.

Elapsed: 00:00:00.01
SQL> SQL> SQL>   2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28   29   30   31  
 C_CUSTKEY C_NAME			REVENUE  C_ACCTBAL
---------- ------------------------- ---------- ----------
N_NAME			  C_ADDRESS
------------------------- ----------------------------------------
C_PHONE
---------------
C_COMMENT
--------------------------------------------------------------------------------
   1237537 Customer#001237537	     884989.666    7840.17
RUSSIA			  FNG6WgB1mopyyY,ajQTU qUPW5o
32-367-120-4327
nag carefully about the regular packages. carefully reg

...<snip>...

 C_CUSTKEY C_NAME			REVENUE  C_ACCTBAL
---------- ------------------------- ---------- ----------
N_NAME			  C_ADDRESS
------------------------- ----------------------------------------
C_PHONE
---------------
C_COMMENT
--------------------------------------------------------------------------------
   1413688 Customer#001413688	       838.9927    4484.91
ALGERIA 		  2qAiOaEmtlxBeAfN0ztULUvlZRDR
10-542-469-4534
its use blithely even deposits. foxes doubt. quickly pendin


381105 rows selected.

Elapsed: 00:00:48.32

Execution Plan
----------------------------------------------------------
Plan hash value: 3891426233

---------------------------------------------------------------------------------------------
| Id  | Operation		| Name	    | Rows  | Bytes |TempSpc| Cost (%CPU)| Time     |
---------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT	|	    |	446K|	 84M|	    |	433K  (1)| 00:00:17 |
|   1 |  SORT ORDER BY		|	    |	446K|	 84M|	 89M|	433K  (1)| 00:00:17 |
|*  2 |   HASH JOIN		|	    |	446K|	 84M|	    |	414K  (1)| 00:00:17 |
|   3 |    TABLE ACCESS FULL	| NATION    |	 25 |	725 |	    |	  3   (0)| 00:00:01 |
|*  4 |    HASH JOIN		|	    |	446K|	 72M|	 13M|	414K  (1)| 00:00:17 |
|   5 |     VIEW		| VW_GBC_16 |	446K|  8282K|	    |	392K  (1)| 00:00:16 |
|   6 |      HASH GROUP BY	|	    |	446K|	 15M|	 42M|	392K  (1)| 00:00:16 |
|*  7 |       HASH JOIN 	|	    |	847K|	 29M|	 17M|	386K  (1)| 00:00:16 |
|*  8 |        TABLE ACCESS FULL| ORDERS    |	580K|	 11M|	    | 66532   (1)| 00:00:03 |
|*  9 |        TABLE ACCESS FULL| LINEITEM  |	 14M|	240M|	    |	298K  (1)| 00:00:12 |
|  10 |     TABLE ACCESS FULL	| CUSTOMER  |  1500K|	216M|	    |  9384   (1)| 00:00:01 |
---------------------------------------------------------------------------------------------


Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("C_NATIONKEY"="N_NATIONKEY")
   4 - access("C_CUSTKEY"="ITEM_1")
   7 - access("L_ORDERKEY"="O_ORDERKEY")
   8 - filter("O_ORDERDATE"<TO_DATE(' 1994-01-01 00:00:00', 'syyyy-mm-dd
	      hh24:mi:ss') AND "O_ORDERDATE">=TO_DATE(' 1993-10-01 00:00:00', 's
yyyy-mm-dd

	      hh24:mi:ss'))
   9 - filter("L_RETURNFLAG"='R')

Note
-----
   - this is an adaptive plan


Statistics
----------------------------------------------------------
	  0  recursive calls
	  0  db block gets
    1371673  consistent gets
	  0  physical reads
	  0  redo size
   73036154  bytes sent via SQL*Net to client
     280772  bytes received via SQL*Net from client
      25408  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
     381105  rows processed

SQL> SQL> 
Session altered.

Elapsed: 00:00:00.00
SQL> 
VALUE
--------------------------------------------------------------------------------
/opt/oracle/diag/rdbms/orclcdb/ORCLCDB/trace/ORCLCDB_ora_22938_HuanianLi.trc

Elapsed: 00:00:00.02

Execution Plan
----------------------------------------------------------
Plan hash value: 1636480816

--------------------------------------------------------------------------------
| Id  | Operation	 | Name        | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------
|   0 | SELECT STATEMENT |	       |     1 |    52 |     0	 (0)| 00:00:01 |
|*  1 |  FIXED TABLE FULL| X$DIAG_INFO |     1 |    52 |     0	 (0)| 00:00:01 |
--------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   1 - filter("NAME"='Default Trace File' AND ("CON_ID"=0 OR
	      "CON_ID"=1) AND "INST_ID"=USERENV('INSTANCE'))


Statistics
----------------------------------------------------------
	  0  recursive calls
	  0  db block gets
	  0  consistent gets
	  0  physical reads
	  0  redo size
	621  bytes sent via SQL*Net to client
	425  bytes received via SQL*Net from client
	  2  SQL*Net roundtrips to/from client
	  0  sorts (memory)
	  0  sorts (disk)
	  1  rows processed

SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
```
