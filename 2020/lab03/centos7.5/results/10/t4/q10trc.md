```
#
# oracle@FOO:queries$ A=/opt/oracle/diag/rdbms/orclcdb/ORCLCDB/trace/ORCLCDB_ora_22938_HuanianLi.trc
# oracle@FOO:queries$ tkprof $A /var/tmp/foo.out
#

TKPROF: Release 19.0.0.0.0 - Development on Sun Jan 3 08:46:21 2021

Copyright (c) 1982, 2019, Oracle and/or its affiliates.  All rights reserved.

Trace file: /opt/oracle/diag/rdbms/orclcdb/ORCLCDB/trace/ORCLCDB_ora_22938_HuanianLi.trc
Sort options: default

********************************************************************************
count    = number of times OCI procedure was executed
cpu      = cpu time in seconds executing 
elapsed  = elapsed time in seconds executing
disk     = number of physical reads of buffers from disk
query    = number of buffers gotten for consistent read
current  = number of buffers gotten in current mode (usually for update)
rows     = number of rows processed by the fetch or execute call
********************************************************************************

select
	c_custkey,
	c_name,
	sum(l_extendedprice * (1 - l_discount)) as revenue,
	c_acctbal,
	n_name,
	c_address,
	c_phone,
	c_comment
from
	customer,
	orders,
	lineitem,
	nation
where
	c_custkey = o_custkey
	and l_orderkey = o_orderkey
	and o_orderdate >= date '1993-10-01'
	and o_orderdate < date '1993-10-01' + interval '3' month
	and l_returnflag = 'R'
	and c_nationkey = n_nationkey
group by
	c_custkey,
	c_name,
	c_acctbal,
	c_phone,
	n_name,
	c_address,
	c_comment
order by
	revenue desc

call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch    25408     22.01      22.17          0    1371673          0      381105
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total    25410     22.01      22.17          0    1371673          0      381105

Misses in library cache during parse: 0
Optimizer mode: ALL_ROWS
Parsing user id: 106  
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
    381105     381105     381105  SORT ORDER BY (cr=1371673 pr=0 pw=0 time=22042231 us starts=1 cost=433322 size=88831013 card=446387)
    381105     381105     381105   HASH JOIN  (cr=1371673 pr=0 pw=0 time=21444077 us starts=1 cost=414005 size=88831013 card=446387)
        25         25         25    TABLE ACCESS FULL NATION (cr=6 pr=0 pw=0 time=304 us starts=1 cost=3 size=725 card=25)
    381105     381105     381105    HASH JOIN  (cr=1371667 pr=0 pw=0 time=21319237 us starts=1 cost=414001 size=75885790 card=446387)
    381105     381105     381105     NESTED LOOPS  (cr=1337328 pr=0 pw=0 time=20546239 us starts=1 cost=414001 size=75885790 card=446387)
    381105     381105     381105      NESTED LOOPS  (cr=1337328 pr=0 pw=0 time=20517697 us starts=1)
    381105     381105     381105       STATISTICS COLLECTOR  (cr=1337328 pr=0 pw=0 time=20485445 us starts=1)
    381105     381105     381105        VIEW  VW_GBC_16 (cr=1337328 pr=0 pw=0 time=20448073 us starts=1 cost=392394 size=8481353 card=446387)
    381105     381105     381105         HASH GROUP BY (cr=1337328 pr=0 pw=0 time=20402887 us starts=1 cost=392394 size=16516319 card=446387)
   1147084    1147084    1147084          HASH JOIN  (cr=1337328 pr=0 pw=0 time=19827471 us starts=1 cost=386716 size=31346807 card=847211)
    573157     573157     573157           NESTED LOOPS  (cr=241238 pr=0 pw=0 time=3107683 us starts=1 cost=386716 size=31346807 card=847211)
    573157     573157     573157            NESTED LOOPS  (cr=241238 pr=0 pw=0 time=3055461 us starts=1)
    573157     573157     573157             STATISTICS COLLECTOR  (cr=241238 pr=0 pw=0 time=3007461 us starts=1)
    573157     573157     573157              TABLE ACCESS FULL ORDERS (cr=241238 pr=0 pw=0 time=2952420 us starts=1 cost=66532 size=11600780 card=580039)
         0          0          0             INDEX RANGE SCAN SYS_C007862 (cr=0 pr=0 pw=0 time=0 us starts=0)(object id 74550)
         0          0          0            TABLE ACCESS BY INDEX ROWID LINEITEM (cr=0 pr=0 pw=0 time=0 us starts=0 cost=298927 size=17 card=1)
  14808183   14808183   14808183           TABLE ACCESS FULL LINEITEM (cr=1096090 pr=0 pw=0 time=15403941 us starts=1 cost=298927 size=251739111 card=14808183)
         0          0          0       INDEX UNIQUE SCAN SYS_C007860 (cr=0 pr=0 pw=0 time=0 us starts=0)(object id 74549)
         0          0          0      TABLE ACCESS BY INDEX ROWID CUSTOMER (cr=0 pr=0 pw=0 time=0 us starts=0 cost=9384 size=151 card=1)
   1500000    1500000    1500000     TABLE ACCESS FULL CUSTOMER (cr=34339 pr=0 pw=0 time=513274 us starts=1 cost=9384 size=226500000 card=1500000)

********************************************************************************

SQL ID: g72kdvcacxvtf Plan Hash: 2637181423

DELETE FROM PLAN_TABLE 
WHERE
 STATEMENT_ID=:1


call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        2      0.00       0.00          0          0          0           0
Execute      2      0.00       0.00          0          3         26          21
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.00       0.00          0          3         26          21

Misses in library cache during parse: 0
Optimizer mode: ALL_ROWS
Parsing user id: 106  
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
         0          0          0  DELETE  PLAN_TABLE$ (cr=0 pr=0 pw=0 time=38 us starts=1)
         0          0          0   TABLE ACCESS FULL PLAN_TABLE$ (cr=0 pr=0 pw=0 time=21 us starts=1 cost=2 size=17 card=1)

********************************************************************************

SQL ID: 23s96rf87635s Plan Hash: 1347681019

select count(*) 
from
 sys.col_group_usage$  where obj# = :1 and cols = :2 and trunc(sysdate) = 
  trunc(timestamp) and bitand(flags, :3) = :3


call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      3      0.00       0.00          0          0          0           0
Fetch        3      0.00       0.00          0          6          0           3
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        7      0.00       0.00          0          6          0           3

Misses in library cache during parse: 0
Optimizer mode: CHOOSE
Parsing user id: SYS   (recursive depth: 1)
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
         1          1          1  SORT AGGREGATE (cr=2 pr=0 pw=0 time=148 us starts=1)
         1          1          1   TABLE ACCESS BY INDEX ROWID COL_GROUP_USAGE$ (cr=2 pr=0 pw=0 time=123 us starts=1 cost=1 size=22 card=1)
         1          1          1    INDEX UNIQUE SCAN PK_COL_GROUP_USAGE$ (cr=1 pr=0 pw=0 time=54 us starts=1 cost=0 size=0 card=1)(object id 674)

********************************************************************************

EXPLAIN PLAN SET STATEMENT_ID='PLUS30148' FOR select
	c_custkey,
	c_name,
	sum(l_extendedprice * (1 - l_discount)) as revenue,
	c_acctbal,
	n_name,
	c_address,
	c_phone,
	c_comment
from
	customer,
	orders,
	lineitem,
	nation
where
	c_custkey = o_custkey
	and l_orderkey = o_orderkey
	and o_orderdate >= date '1993-10-01'
	and o_orderdate < date '1993-10-01' + interval '3' month
	and l_returnflag = 'R'
	and c_nationkey = n_nationkey
group by
	c_custkey,
	c_name,
	c_acctbal,
	c_phone,
	n_name,
	c_address,
	c_comment
order by
	revenue desc

call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.04       0.04          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        2      0.04       0.04          0          0          0           0

Misses in library cache during parse: 1
Optimizer mode: ALL_ROWS
Parsing user id: 106  
********************************************************************************

SQL ID: 99qa3zyarxvms Plan Hash: 0

insert into plan_table (statement_id, timestamp, operation, options,
  object_node, object_owner, object_name, object_instance, object_type,
  search_columns, id, parent_id, position, other,optimizer, cost, cardinality,
   bytes, other_tag, partition_start, partition_stop, partition_id, 
  distribution, cpu_cost, io_cost, temp_space, access_predicates, 
  filter_predicates, projection, time, qblock_name, object_alias, plan_id, 
  depth, remarks, other_xml ) 
values
(:1,:2,:3,:4,:5,:6,:7,:8,:9,:10,:11,:12,:13,:14,:15,:16,:17,:18,:19,:20,:21,
  :22,:23,:24,:25,:26,:27,:28,:29,:30,:31,:32,:33,:34,:35,:36)


call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute     21      0.00       0.00          0          6         56          21
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total       22      0.00       0.00          0          6         56          21

Misses in library cache during parse: 0
Misses in library cache during execute: 1
Optimizer mode: ALL_ROWS
Parsing user id: 106     (recursive depth: 1)
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
         0          0          0  LOAD TABLE CONVENTIONAL  PLAN_TABLE (cr=1 pr=0 pw=0 time=937 us starts=1)

********************************************************************************

SQL ID: 15knr3nbjkrcw Plan Hash: 2501920895

SELECT ORA_PLAN_ID_SEQ$.NEXTVAL 
FROM
 DUAL


call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        1      0.00       0.00          0          0          1           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        3      0.00       0.00          0          0          1           1

Misses in library cache during parse: 0
Optimizer mode: CHOOSE
Parsing user id: SYS   (recursive depth: 1)
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
         1          1          1  SEQUENCE  ORA_PLAN_ID_SEQ$ (cr=91 pr=0 pw=0 time=18410 us starts=1)
         1          1          1   FAST DUAL  (cr=0 pr=0 pw=0 time=3 us starts=1 cost=2 size=0 card=1)

********************************************************************************

SQL ID: cn6hhn36a4rrs Plan Hash: 3845132125

select con#,obj#,rcon#,enabled,nvl(defer,0),spare2,spare3,refact 
from
 cdef$ where robj#=:1


call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        1      0.00       0.00          0          1          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        3      0.00       0.00          0          1          0           0

Misses in library cache during parse: 1
Misses in library cache during execute: 1
Optimizer mode: CHOOSE
Parsing user id: SYS   (recursive depth: 3)
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
         0          0          0  TABLE ACCESS BY INDEX ROWID BATCHED CDEF$ (cr=1 pr=0 pw=0 time=34 us starts=1 cost=2 size=90 card=3)
         0          0          0   INDEX RANGE SCAN I_CDEF3 (cr=1 pr=0 pw=0 time=33 us starts=1 cost=1 size=0 card=3)(object id 55)

********************************************************************************

SQL ID: gx4mv66pvj3xz Plan Hash: 2570921597

select con#,type#,condlength,intcols,robj#,rcon#,match#,refact,nvl(enabled,0),
  rowid,cols,nvl(defer,0),mtime,nvl(spare1,0),spare2,spare3 
from
 cdef$ where obj#=:1


call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        9      0.00       0.00          0         11          0           8
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total       11      0.00       0.00          0         11          0           8

Misses in library cache during parse: 1
Misses in library cache during execute: 1
Optimizer mode: CHOOSE
Parsing user id: SYS   (recursive depth: 3)
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
         8          8          8  TABLE ACCESS CLUSTER CDEF$ (cr=11 pr=0 pw=0 time=62 us starts=1 cost=2 size=196 card=4)
         1          1          1   INDEX UNIQUE SCAN I_COBJ# (cr=2 pr=0 pw=0 time=44 us starts=1 cost=1 size=0 card=1)(object id 30)

********************************************************************************

SQL ID: 0sbbcuruzd66f Plan Hash: 2239883476

select /*+ rule */ bucket_cnt, row_cnt, cache_cnt, null_cnt, timestamp#, 
  sample_size, minimum, maximum, distcnt, lowval, hival, density, col#, 
  spare1, spare2, avgcln, minimum_enc, maximum_enc 
from
 hist_head$ where obj#=:1 and intcol#=:2


call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute     13      0.00       0.00          0          0          0           0
Fetch       13      0.00       0.00          0         39          0          13
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total       27      0.00       0.00          0         39          0          13

Misses in library cache during parse: 1
Misses in library cache during execute: 1
Optimizer mode: RULE
Parsing user id: SYS   (recursive depth: 3)
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
         1          1          1  TABLE ACCESS BY INDEX ROWID HIST_HEAD$ (cr=3 pr=0 pw=0 time=47 us starts=1)
         1          1          1   INDEX RANGE SCAN I_HH_OBJ#_INTCOL# (cr=2 pr=0 pw=0 time=31 us starts=1)(object id 70)

********************************************************************************

SQL ID: 2sxqgx5hx76qr Plan Hash: 3312420081

select /*+ rule */ bucket, endpoint, col#, epvalue, epvalue_raw, 
  ep_repeat_count, endpoint_enc 
from
 histgrm$ where obj#=:1 and intcol#=:2 and row#=:3 order by bucket


call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        1      0.00       0.00          0          3          0          11
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        3      0.00       0.00          0          3          0          11

Misses in library cache during parse: 1
Misses in library cache during execute: 1
Optimizer mode: RULE
Parsing user id: SYS   (recursive depth: 4)
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
        11         11         11  SORT ORDER BY (cr=3 pr=0 pw=0 time=67 us starts=1 cost=0 size=0 card=0)
        11         11         11   TABLE ACCESS CLUSTER HISTGRM$ (cr=3 pr=0 pw=0 time=53 us starts=1)
         1          1          1    INDEX UNIQUE SCAN I_OBJ#_INTCOL# (cr=2 pr=0 pw=0 time=21 us starts=1)(object id 65)

********************************************************************************

SQL ID: 53saa2zkr6wc3 Plan Hash: 3038981986

select intcol#,nvl(pos#,0),col#,nvl(spare1,0) 
from
 ccol$ where con#=:1


call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      8      0.00       0.00          0          0          0           0
Fetch       16      0.00       0.00          0         32          0           8
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total       25      0.00       0.00          0         32          0           8

Misses in library cache during parse: 1
Misses in library cache during execute: 1
Optimizer mode: CHOOSE
Parsing user id: SYS   (recursive depth: 3)
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
         1          1          1  TABLE ACCESS BY INDEX ROWID BATCHED CCOL$ (cr=4 pr=0 pw=0 time=57 us starts=1 cost=3 size=15 card=1)
         1          1          1   INDEX RANGE SCAN I_CCOL1 (cr=3 pr=0 pw=0 time=59 us starts=1 cost=2 size=0 card=1)(object id 57)

********************************************************************************

SQL ID: 6h3cwmunz5z8q Plan Hash: 2968095032

select col#, grantee#, privilege#,max(mod(nvl(option$,0),2)), 
  max(bitand(nvl(option$,0), 8) /8), max(bitand(nvl(option$,0), 16) /16), 
  max(bitand(nvl(option$,0),64) /64), max(bitand(nvl(option$,0), 128) /128) 
from
 objauth$ where obj#=:1 and col# is not null group by privilege#, col#, 
  grantee# order by col#, grantee#


call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        1      0.00       0.00          0          2          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        3      0.00       0.00          0          2          0           0

Misses in library cache during parse: 1
Misses in library cache during execute: 1
Optimizer mode: CHOOSE
Parsing user id: SYS   (recursive depth: 3)
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
         0          0          0  SORT GROUP BY (cr=2 pr=0 pw=0 time=65 us starts=1 cost=4 size=16 card=1)
         0          0          0   TABLE ACCESS BY INDEX ROWID BATCHED OBJAUTH$ (cr=2 pr=0 pw=0 time=27 us starts=1 cost=3 size=16 card=1)
         0          0          0    INDEX RANGE SCAN I_OBJAUTH1 (cr=2 pr=0 pw=0 time=27 us starts=1 cost=2 size=0 card=1)(object id 62)

********************************************************************************

SQL ID: a4n4ayr88dbhy Plan Hash: 2968095032

select grantee#,privilege#,nvl(col#,0),max(mod(nvl(option$,0),2)),
  max(bitand(nvl(option$,0), 8) /8), max(bitand(nvl(option$,0), 16) /16), 
  max(bitand(nvl(option$,0),64) /64), max(bitand(nvl(option$,0), 128) /128) 
from
 objauth$ where obj#=:1 group by grantee#,privilege#,nvl(col#,0) order by 
  grantee#


call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        1      0.00       0.00          0          2          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        3      0.00       0.00          0          2          0           0

Misses in library cache during parse: 1
Misses in library cache during execute: 1
Optimizer mode: CHOOSE
Parsing user id: SYS   (recursive depth: 3)
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
         0          0          0  SORT GROUP BY (cr=2 pr=0 pw=0 time=20 us starts=1 cost=4 size=16 card=1)
         0          0          0   TABLE ACCESS BY INDEX ROWID BATCHED OBJAUTH$ (cr=2 pr=0 pw=0 time=10 us starts=1 cost=3 size=16 card=1)
         0          0          0    INDEX RANGE SCAN I_OBJAUTH1 (cr=2 pr=0 pw=0 time=8 us starts=1 cost=2 size=0 card=1)(object id 62)

********************************************************************************

SQL ID: 4m7m0t6fjcs5x Plan Hash: 1935744642

update seq$ set increment$=:2,minvalue=:3,maxvalue=:4,cycle#=:5,order$=:6,
  cache=:7,highwater=:8,audit$=:9,flags=:10 
where
 obj#=:1


call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          1          2           1
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        2      0.00       0.00          0          1          2           1

Misses in library cache during parse: 1
Misses in library cache during execute: 1
Optimizer mode: CHOOSE
Parsing user id: SYS   (recursive depth: 2)
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
         0          0          0  UPDATE  SEQ$ (cr=1 pr=0 pw=0 time=359 us starts=1)
         1          1          1   INDEX UNIQUE SCAN I_SEQ1 (cr=1 pr=0 pw=0 time=13 us starts=1 cost=0 size=70 card=1)(object id 105)

********************************************************************************

SQL ID: 3s1hh8cvfan6w Plan Hash: 2137789089

SELECT PLAN_TABLE_OUTPUT 
FROM
 TABLE(DBMS_XPLAN.DISPLAY('PLAN_TABLE', :1))


call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        4      0.00       0.00          0          0          0          32
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        6      0.00       0.00          0          0          0          32

Misses in library cache during parse: 0
Optimizer mode: ALL_ROWS
Parsing user id: 106  
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
        32         32         32  COLLECTION ITERATOR PICKLER FETCH DISPLAY (cr=24 pr=4 pw=0 time=51893 us starts=1 cost=29 size=16336 card=8168)

********************************************************************************

SQL ID: f7b069b8zkhvu Plan Hash: 4250213283

SELECT to_number(value)
         FROM sys.v$parameter
         WHERE name = 
  '_qa_lrg_type'


call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      3      0.00       0.00          0          0          0           0
Fetch        3      0.01       0.01          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        7      0.01       0.01          0          0          0           0

Misses in library cache during parse: 0
Optimizer mode: ALL_ROWS
Parsing user id: SYS   (recursive depth: 2)
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
         0          0          0  HASH JOIN  (cr=0 pr=0 pw=0 time=4518 us starts=1 cost=1 size=55 card=1)
         1          1          1   FIXED TABLE FIXED INDEX X$KSPPI (ind:1) (cr=0 pr=0 pw=0 time=394 us starts=1 cost=0 size=38 card=1)
      5412       5412       5412   FIXED TABLE FULL X$KSPPCV (cr=0 pr=0 pw=0 time=2852 us starts=1 cost=1 size=92004 card=5412)

********************************************************************************

select /*+ opt_param('parallel_execution_enabled',
                                   'false') EXEC_FROM_DBMS_XPLAN */ * from PLAN_TABLE where 1=0

call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        2      0.00       0.00          0          0          0           0

Misses in library cache during parse: 0
Optimizer mode: ALL_ROWS
Parsing user id: 106     (recursive depth: 1)
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
         0          0          0  FILTER  (cr=0 pr=0 pw=0 time=4 us starts=1)
         0          0          0   TABLE ACCESS FULL PLAN_TABLE$ (cr=0 pr=0 pw=0 time=0 us starts=0 cost=2 size=237846 card=21)

********************************************************************************

SELECT /*+ opt_param('parallel_execution_enabled','false') */
                         /* EXEC_FROM_DBMS_XPLAN */ id, parent_id, partition_id, timestamp, optimizer, position, search_columns, depth, operation, options, object_name, object_owner, object_type, object_instance, cardinality, bytes, temp_space, cost, io_cost, cpu_cost, time, partition_start, partition_stop, object_node, other_tag, distribution, null projection, access_predicates, filter_predicates, other, qblock_name, object_alias, nvl(other_xml, remarks) other_xml, null sql_profile, null sql_plan_baseline, null, null, null, null, null, null, null,
                            null, null, null, null, null,
                            null, null, null, null from PLAN_TABLE where plan_id = (select max(plan_id)
                                        from PLAN_TABLE where id=0  and statement_id = :stmt_id)
                       order by id

call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch       22      0.00       0.00          4         10          0          21
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total       24      0.00       0.00          4         10          0          21

Misses in library cache during parse: 0
Optimizer mode: ALL_ROWS
Parsing user id: 106     (recursive depth: 2)
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
        21         21         21  SORT ORDER BY (cr=10 pr=4 pw=0 time=592 us starts=1 cost=5 size=9307 card=1)
        21         21         21   TABLE ACCESS FULL PLAN_TABLE$ (cr=6 pr=0 pw=0 time=625 us starts=1 cost=2 size=9307 card=1)
         1          1          1    SORT AGGREGATE (cr=3 pr=0 pw=0 time=82 us starts=1)
         1          1          1     TABLE ACCESS FULL PLAN_TABLE$ (cr=3 pr=0 pw=0 time=63 us starts=1 cost=2 size=43 card=1)

********************************************************************************

SQL ID: g3f3cw3zy5aat Plan Hash: 992138068

SELECT PLAN_TABLE_OUTPUT 
FROM
 TABLE(CAST(DBMS_XPLAN.PREPARE_RECORDS(:B1 , :B2 ) AS 
  SYS.DBMS_XPLAN_TYPE_TABLE))


call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        1      0.00       0.00          0          3          0          32
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        3      0.00       0.00          0          3          0          32

Misses in library cache during parse: 0
Optimizer mode: ALL_ROWS
Parsing user id: 106     (recursive depth: 1)
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
        32         32         32  COLLECTION ITERATOR PICKLER FETCH PREPARE_RECORDS (cr=24 pr=4 pw=0 time=44713 us starts=1 cost=29 size=16336 card=8168)

********************************************************************************

SELECT /*+ opt_param('parallel_execution_enabled', 'false') */ extractvalue(xmlval, '/*/info[@type = "sql_profile"]'), extractvalue(xmlval, '/*/info[@type = "sql_patch"]'), extractvalue(xmlval, '/*/info[@type = "baseline"]'), extractvalue(xmlval, '/*/info[@type = "outline"]'), extractvalue(xmlval, '/*/info[@type = "dynamic_sampling"]'), extractvalue(xmlval, '/*/info[@type = "dop"]'), extractvalue(xmlval, '/*/info[@type = "dop_reason"]'), extractvalue(xmlval, '/*/info[@type = "pdml_reason"]'), extractvalue(xmlval, '/*/info[@type = "idl_reason"]'), extractvalue(xmlval, '/*/info[@type = "queuing_reason"]'), extractvalue(xmlval, '/*/info[@type = "px_in_memory"]'), extractvalue(xmlval, '/*/info[@type = "px_in_memory_imc"]'), extractvalue(xmlval, '/*/info[@type = "row_shipping"]'), extractvalue(xmlval, '/*/info[@type = "index_size"]'), extractvalue(xmlval, '/*/info[@type = "result_checksum"]'), extractvalue(xmlval, '/*/info[@type = "cardinality_feedback"]'), extractvalue(xmlval, '/*/info[@type = "performance_feedback"]'), extractvalue(xmlval, '/*/info[@type = "rely_constraint"]'), extractvalue(xmlval, '/*/info[@type = "xml_suboptimal"]'), extractvalue(xmlval, '/*/info[@type = "adaptive_plan"]'), extractvalue(xmlval, '/*/spd/cu'), extractvalue(xmlval, '/*/info[@type = "gtt_session_st"]'), extractvalue(xmlval, 
            '/*/info[@type = "gather_stats_on_conventional_dml"]'), extractvalue(xmlval, 
            '/*/info[@type = "optimizer_use_stats_on_conventional_dml"]'), extractvalue(xmlval, '/*/info[@type = "slave_parse"]'), extractvalue(xmlval, '/*/info[@type = "baseline_repro_fail"]'), extractvalue(xmlval,'/*/info[@type = "plan_hash"]'), extractvalue(xmlval, '/*/info[@type = "cross_shard_query"]'), extractvalue(xmlval, '/*/info[@type = "shard_id"]'), extract(xmlval, '/*/hint_usage').getClobVal() from (select xmltype(:v_other_xml) xmlval from sys.dual)

call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        1      0.01       0.01          0          6          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        3      0.01       0.01          0          6          0           1

Misses in library cache during parse: 0
Optimizer mode: ALL_ROWS
Parsing user id: 106     (recursive depth: 2)
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
         1          1          1  FAST DUAL  (cr=0 pr=0 pw=0 time=2 us starts=1 cost=2 size=0 card=1)

********************************************************************************

SQL ID: cb21bacyh3c7d Plan Hash: 3452538079

select metadata 
from
 kopm$  where name='DB_FDO'


call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        1      0.00       0.00          0          2          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        3      0.00       0.00          0          2          0           1

Misses in library cache during parse: 0
Optimizer mode: CHOOSE
Parsing user id: SYS   (recursive depth: 3)
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
         1          1          1  TABLE ACCESS BY INDEX ROWID KOPM$ (cr=2 pr=0 pw=0 time=43 us starts=1 cost=1 size=108 card=1)
         1          1          1   INDEX UNIQUE SCAN I_KOPM1 (cr=1 pr=0 pw=0 time=19 us starts=1 cost=0 size=0 card=1)(object id 793)

********************************************************************************

SQL ID: gghk7k6vt9gzq Plan Hash: 1388734953

SELECT /*+ opt_param('parallel_execution_enabled', 'false') */ extract(xmlval,
   '/*/outline_data').getClobVal() 
from
 (select xmltype(:v_other_xml) xmlval from sys.dual)


call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        1      0.00       0.00          0          0          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        3      0.00       0.00          0          0          0           1

Misses in library cache during parse: 0
Optimizer mode: ALL_ROWS
Parsing user id: 106     (recursive depth: 2)
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
         1          1          1  FAST DUAL  (cr=0 pr=0 pw=0 time=2 us starts=1 cost=2 size=0 card=1)

********************************************************************************

SQL ID: fg4skgcja2cyj Plan Hash: 1186311642

SELECT EXTRACTVALUE(VALUE(D), '/row/@op'), EXTRACTVALUE(VALUE(D), '/row/@dis')
  , EXTRACTVALUE(VALUE(D), '/row/@par'), EXTRACTVALUE(VALUE(D), '/row/@prt'), 
  EXTRACTVALUE(VALUE(D), '/row/@dep'), EXTRACTVALUE(VALUE(D), '/row/@skp') 
FROM
 TABLE(XMLSEQUENCE(EXTRACT(XMLTYPE(:B1 ), '/*/display_map/row'))) D


call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          3          0           0
Fetch        1      0.01       0.01          0          0          0          20
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        3      0.01       0.01          0          3          0          20

Misses in library cache during parse: 0
Optimizer mode: ALL_ROWS
Parsing user id: 106     (recursive depth: 2)
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
        20         20         20  COLLECTION ITERATOR PICKLER FETCH XMLSEQUENCEFROMXMLTYPE (cr=3 pr=0 pw=0 time=2403 us starts=1 cost=29 size=16336 card=8168)

********************************************************************************

SQL ID: bh7jda5rbamvk Plan Hash: 0

ALTER SESSION SET sql_trace=FALSE


call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        2      0.00       0.00          0          0          0           0

Misses in library cache during parse: 0
Parsing user id: 106  



********************************************************************************

OVERALL TOTALS FOR ALL NON-RECURSIVE STATEMENTS

call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        6      0.04       0.04          0          0          0           0
Execute      6      0.00       0.00          0          3         26          21
Fetch    25412     22.01      22.17          0    1371673          0      381137
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total    25424     22.05      22.22          0    1371676         26      381158

Misses in library cache during parse: 1


OVERALL TOTALS FOR ALL RECURSIVE STATEMENTS

call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse       19      0.00       0.00          0          0          0           0
Execute     62      0.01       0.01          0         10         58          22
Fetch       76      0.04       0.04          4        117          1         120
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total      157      0.07       0.07          4        127         59         142

Misses in library cache during parse: 8
Misses in library cache during execute: 9

   12  user  SQL statements in session.
   12  internal SQL statements in session.
   24  SQL statements in session.
********************************************************************************
Trace file: /opt/oracle/diag/rdbms/orclcdb/ORCLCDB/trace/ORCLCDB_ora_22938_HuanianLi.trc
Trace file compatibility: 12.2.0.0
Sort options: default

       1  session in tracefile.
      12  user  SQL statements in trace file.
      12  internal SQL statements in trace file.
      24  SQL statements in trace file.
      24  unique SQL statements in trace file.
   25943  lines in trace file.
      48  elapsed seconds in trace file.

```
