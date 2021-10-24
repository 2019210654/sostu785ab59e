SELECT
	cu.*
FROM
	user_cons_columns cu,
	user_constraints  au
WHERE
	cu.constraint_name = au.constraint_name
	AND au.constraint_type = 'P'
	AND cu.table_name = 'REGION';
