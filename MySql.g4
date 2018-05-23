grammar MySql;
import MySqlTokens;

@header {
	import java.util.*;
}

@parser::members {
	Set<String> types = new HashSet<String>() {{
		add("FROM");
		add("SELECT");
		add("UPDATE");
		add("JOIN");
		add("CROSS");
	}};
	boolean isKeyword() { return types.contains(getCurrentToken().getText().toUpperCase()); };
}

stat:
	(
			data_definition_statements
		|
			data_manipulation_statements
		|
			transactional_and_locking_statements
		|
			replication_statements
		|
			prepared_statements
		|
			compound_statements
		|
			database_administration_statements
		|
			utility_statements
	)
	(SEMI)?
	(NEWLINE)?
;

data_definition_statements:
		alter_clause
	|
		create_clause
	|
		drop_clause
	|
		rename_clause
	|
		truncate_clause
;

data_manipulation_statements:
		call_clause
	|
		delete_clause
	|
		do_clause
	|
		handler_clause
	|
		insert_clause
	|
		load_data_infile_clause
	|
		load_xml_clause
	|
		replace_clause
	|
		select_clause
	|
		update_clause
;

transactional_and_locking_statements:
		start_transaction_clause
	|
		commit_clause
	|
		rollback_clause
	|
		savepoint_clause
	|
		rollback_to_savepoint_clause
	|
		release_savepoint_clause
	|
		lock_tables_clause
	|
		unlock_tables_clause
	|
		set_transaction_clause
;

replication_statements:
		replication_master_statements
	|
		replication_slave_statements
;

prepared_statements:
		prepare_clause
	|
		execute_clause
	|
		deallocate_prepare_clause
;


compound_statements:
		begin_clause
	|
		begin_end_statement
	|
//		label_statements // these are actually handled in the begin, loop, repeat, and while statements
//	|
		declare_clause
	|
//		variable_statements // handled by declare
//	|
		control_flow_statements
	|
		cursor_statements
	|
		condition_handling_statements
;

begin_end_statement:
	(label_declaration)? BEGIN
				statement_list
	END (label)?
;

declare_clause:
	DECLARE variable_name (COMMA variable_name)* data_type (DEFAULT default_value)?
;

default_value:
	ID | USER_VAR
;

database_administration_statements:
		account_management_statements
	|
		table_maintenance_statements
	|
		plugin_and_udf_statements
	|
		set_clause
	|
		show_clause
	|
		other_administration_statements
;

utility_statements:
		explain_clause // also covers describe
	|
		help_clause
	|
		use_clause
;

reserved_keywords:
		CURSOR_NAME
	|
		COLUMN_NAME
	|
		TABLE_NAME
	|
		SCHEMA_NAME
	|
		CATALOG_NAME
	|
		CONSTRAINT_NAME
	|
		CONSTRAINT_SCHEMA
	|
		CONSTRAINT_CATALOG
	|
		MYSQL_ERRNO
	|
		MESSAGE_TEXT
	|
		RETURNED_SQLSTATE
	|
		SUBCLASS_INFORMATION
	|
		CLASS_INFORMATION
	|
		ROW_COUNT
	|
		SQLEXCEPTION
	|
		SQLWARNING
	|
		SQLSTATE
	|
		USER_RESOURCES
	|
		DES_KEY_FILE
	|
		USE_FRM
	|
		NO_WRITE_TO_BINLOG
	|
		MAX_QUERIES_PER_HOUR
	|
		MAX_UPDATES_PER_HOUR
	|
		MAX_CONNECTIONS_PER_HOUR
	|
		MAX_USER_CONNECTIONS
	|
		DEFAULT_AUTH
	|
		PLUGIN_DIR
	|
		SQL_AFTER_MTS_GAPS
	|
		SQL_BEFORE_GTIDS
	|
		SQL_AFTER_GTIDS
	|
		IO_THREAD
	|
		SQL_THREAD
	|
		MASTER_BIND
	|
		MASTER_HOST
	|
		MASTER_USER
	|
		MASTER_PASSWORD
	|
		MASTER_PORT
	|
		MASTER_CONNECT_RETRY
	|
		MASTER_RETRY_COUNT
	|
		MASTER_DELAY
	|
		MASTER_HEARTBEAT_PERIOD
	|
		MASTER_LOG_FILE
	|
		MASTER_LOG_POS
	|
		MASTER_AUTO_POSITION
	|
		RELAY_LOG_FILE
	|
		RELAY_LOG_POS
	|
		MASTER_SSL_CAPATH
	|
		MASTER_SSL_CA
	|
		MASTER_SSL_CERT
	|
		MASTER_SSL_CRLPATH
	|
		MASTER_SSL_KEY
	|
		MASTER_SSL_CIPHER
	|
		MASTER_SSL_VERIFY_SERVER_CERT
	|
		IGNORE_SERVER_IDS
	|
		MASTER_SSL_CRL
	|
		MASTER_SSL
	|
		ALGORITHM
	|
		AUTO_INCREMENT
	|
		AUTOEXTEND_SIZE
	|
		AVG_ROW_LENGTH
	|
		COLUMN_FORMAT
	|
		COMMENT
	|
		COMPLETION
	|
		DELAY_KEY_WRITE
	|
		DIRECTORY
	|
		EXTENT_SIZE
	|
		LOGFILE
	|
		KEY_BLOCK_SIZE
	|
		MAXVALUE
	|
		MAX_SIZE
	|
		MAX_ROWS
	|
		MIN_ROWS
	|
		PACK_KEYS
	|
		REDUNDANT
	|
		ROW_FORMAT
	|
		SERIALIZABLE
	|
		STATS_AUTO_RECALC
	|
		STATS_PERSISTENT
	|
		STATS_SAMPLE_PAGES
	|
		UNCOMMITTED
	|
		UNDEFINED
	|
		UNDO_BUFFER_SIZE
	|
		REDO_BUFFER_SIZE
	|
		DUPLICATE
	|
		DELAYED
	|
		DELETE
	|
		INFILE
	|
		INITIAL_SIZE
	|
		INNODB
	|
		INSERT_METHOD
	|
		DESCRIBE
	|
		EXPLAIN
	|
		EXTENDED
	|
		GENERAL
	|
		NONBLOCKING
	|
		ONLINE
	|
		OFFLINE
	|
		BLOCK
	|
		CONCURRENT
	|
		CONTAINS
	|
		CONTEXT
	|
		CONSTRAINT
	|
		SWITCHES
	|
		BINLOG
	|
		CHANGED
	|
		EVENTS
	|
		EVENT
	|
		FAULTS
	|
		PARSER
	|
		PRESERVE
	|
		PURGE
	|
		SCHEDULE
	|
		SOURCE
	|
		SWAPS
	|
		TRIGGERS
	|
		TRIGGER
	|
		UNDOFILE
	|
		UPGRADE
	|
		VARBINARY
	|
		VARCHAR
	|
		WARNINGS
	|
		MUTEX
	|
		ERRORS
	|
		ERROR
	|
		ROLLBACK
	|
		PLUGINS
	|
		PLUGIN
	|
		PRIVILEGES
	|
		ROUTINE
	|
		BEGIN
	|
		TRANSACTION
	|
		ISOLATION
	|
		CHAIN
	|
		CONSISTENT
	|
		SAVEPOINT
	|
		SNAPSHOT
	|
		SLAVE
	|
		STATUS
	|
		GRANTS
	|
		GRANT
	|
	//	SELECT
	//|
		PROCESSLIST
	|
		PROCESS
	|
		REFERENCES
	|
		REPLICATION
	|
		ROLLUP
	|
		HAVING
	|
		WHERE
	|
		EXISTS
	|
		DISTINCTROW
	|
		HIGH_PRIORITY
	|
		FALSE
	|
		BETWEEN
	|
		DROP
	|
		GREATEST
	|
		ISNULL
	|
		REGEXP
	|
		RESET
	|
		REQUIRE
	|
		PROCEDURE
	|
		INTO
	|
		OUTFILE
	|
		EXCHANGE
	|
		CHANGE
	|
		COLUMNS
	|
		COLUMN
	|
		FIELDS
	|
		ESCAPED
	|
		ESCAPE
	|
		ANALYZE
	|
		COALESCE
	|
		COLLATE
	|
		CONNECTION
	|
		INNER
	|
		OUTER
	|
		TEMPTABLE
	|
		TABLESPACE
	|
		TABLES
	|
		TABLE
	|
		JOIN
	|
		CROSS
	|
		ORDER
	|
		MERGE
	|
		NODEGROUP
	|
		GROUP
	|
		IGNORE
	|
		PARTIAL
	|
		REORGANIZE
	|
		SUBPARTITIONS
	|
		SUBPARTITION
	|
		PARTITIONING
	|
		PARTITIONS
	|
		PARTITION
	|
		SCHEMA
	|
		SIMPLE
	|
		STRAIGHT_JOIN
	|
		SQL_SMALL_RESULT
	|
		SQL_BIG_RESULT
	|
		SQL_BUFFER_RESULT
	|
		SQL_CACHE
	|
		SQL_NO_CACHE
	|
		SQL_CALC_FOUND_ROWS
	|
		LIMIT
	|
		ITERATE
	|
		OFFSET
	|
		GLOBAL
	|
		QUICK
	|
		SERVER
	|
		SESSION
	|
		TEMPORARY
	|
		RESTRICT
	|
		PREPARE
	|
		CASCADED
	|
		CASCADE
	|
		VARIABLES
	|
		CASE
	|
		EACH
	|
		WHEN
	|
		THAN
	|
		THEN
	|
		ELSEIF
	|
		ELSE
	|
		ENDS
	|
		END
	|
		IFNULL
	|
		NULLIF
	|
		ASCII
	|
		BIT_LENGTH
	|
		CHARACTER_LENGTH
	|
		CHARACTER_SET
	|
		CHAR
	|
		CLIENT
	|
		CONCAT_WS
	|
		CONCAT
	|
		CONTINUE
	|
		ELT
	|
		EXIT
	|
		EXPORT_SET
	|
		EXPORT
	|
		FIELD
	|
		FIND_IN_SET
	|
		FORMAT
	|
		LN
	|
		LOG2
	|
		LOG10
	|
		LOG
	|
		INSERT
	|
		INSTR
	|
		LCASE
	|
		LEFT
	|
		LINESTRING
	|
		RELOAD
	|
		LEAVES
	|
		LEAVE
	|
		LOAD_FILE
	|
		LOAD
	|
		LOCATE
	|
		LOOP
	|
		LOWER
	|
		LPAD
	|
		LTRIM
	|
		MAKE_SET
	|
		MID
	|
		MULTIPOINT
	|
		MULTILINESTRING
	|
		MULTIPOLYGON
	|
		GEOMETRYCOLLECTION
	|
		OCTET_LENGTH
	|
		OCT
	|
		ORD
	|
		POLYGON
	|
		POSITION
	|
		QUOTE
	|
		REPEATABLE
	|
		REPEAT
	|
		REPLACE
	|
		REVERSE
	|
		RIGHT
	|
		RPAD
	|
		RTRIM
	|
		SOUNDEX
	|
		SOUNDS
	|
		SPACE
	|
		STRCMP
	|
		SUBSTRING_INDEX
	|
		SUBSTRING
	|
		SUBSTR
	|
		TRIM
	|
		BOTH
	|
		LEADING
	|
		TRAILING
	|
		UCASE
	|
		UNHEX
	|
		UPPER
	|
		WEIGHT_STRING
	|
		LEVEL
	|
		ABS
	|
		ACOS
	|
		ASIN
	|
		ATAN2
	|
		ATAN
	|
		CEILING
	|
		CEIL
	|
		CONV
	|
		COS
	|
		COT
	|
		CRC32
	|
		DEGREES
	|
		EXP
	|
		FLOOR
	|
		MOD
	|
		PI
	|
		POWER
	|
		POW
	|
		RADIANS
	|
		RAND
	|
		RANGE
	|
		ROUND
	|
		SIGN
	|
		SIN
	|
		SQRT
	|
		TAN
	|
		TRUNCATE
	|
		MATCH
	|
		AGAINST
	|
		NATURAL
	|
		LANGUAGE
	|
		MODE
	|
		QUERY
	|
		EXPANSION
	|
		BOOLEAN
	|
		BINARY
	|
		CAST
	|
		CONVERT
	|
		DISCARD
	|
		USING
	|
		BIT_COUNT
	|
		AES_DECRYPT
	|
		AES_ENCRYPT
	|
		UNCOMPRESSED_LENGTH
	|
		UNCOMPRESS
	|
		COMPRESSED
	|
		COMPRESS
	|
		DECODE
	|
		DES_DECRYPT
	|
		DES_ENCRYPT
	|
		ENCODE
	|
		ENCRYPT
	|
		MD5
	|
		OLD_PASSWORD
	|
		RANDOM_BYTES
	|
		SHA1
	|
		SHA2
	|
		SHA
	|
		VALIDATE_PASSWORD_STRENGTH
	|
		AREA
	|
		CENTROID
	|
		EXTERIORRING
	|
		NUMINTERIORRINGS
	|
		ST_AREA
	|
		ST_CENTROID
	|
		ST_EXTERIORRING
	|
		ST_INTERIORRINGN
	|
		ST_NUMINTERIORRINGS
	|
		CONVEXHULL
	|
		ST_BUFFER
	|
		ST_BUFFER_STRATEGY
	|
		ST_CONVEXHULL
	|
		ST_DIFFERENCE
	|
		ST_INTERSECTION
	|
		ST_SYMDIFFERENCE
	|
		GEOMETRYN
	|
		NUMGEOMETRIES
	|
		ST_GEOMETRYN
	|
		ST_NUMGEOMETRIES
	|
		ST_UNION
	|
		ST_ENVELOPE
	|
		ST_STARTPOINT
	|
		ST_ENDPOINT
	|
		ST_POINTN
	|
		ANY_VALUE
	|
		DEFAULT
	|
		DYNAMIC
	|
		INPLACE
	|
		GET_LOCK
	|
		INET_ATON
	|
		INET_NTOA
	|
		INET6_ATON
	|
		INET6_NTOA
	|
		IS_FREE_LOCK
	|
		IS_IPV4_COMPAT
	|
		IS_IPV4
	|
		IS_IPV4_MAPPED
	|
		IS_IPV6
	|
		IS_USED_LOCK
	|
		MASTER_POS_WAIT
	|
		NAME_CONST
	|
		RELEASE_ALL_LOCKS
	|
		RELEASE_LOCK
	|
		SLEEP
	|
		SLOW
	|
		UUID_SHORT
	|
		UUID
	|
		VALUES
	|
		EXTRACT_VALUE
	|
		UPDATE_XML
	|
		UPDATE
	|
		LOW_PRIORITY
	|
		ACTION
	|
		ADDDATE
	|
		ADDTIME
	|
		AFTER
	|
		CONVERT_TZ
	|
		CURDATE
	|
		CURRENT_DATE
	|
		CURRENT_TIMESTAMP
	|
		CURRENT_TIME
	|
		CURRENT_USER
	|
		CURRENT
	|
		CURTIME
	|
		DATEDIFF
	|
		DATE_ADD
	|
		DATE_SUB
	|
		DATE_FORMAT
	|
		DAYNAME
	|
		DAYOFMONTH
	|
		DAYOFWEEK
	|
		DAYOFYEAR
	|
		DIAGNOSTICS
	|
		EVERY
	|
		EXTRACT
	|
		FIRST
	|
		FROM_DAYS
	|
		FROM_UNIXTIME
	|
		GET_FORMAT
	|
		LAST_DAY
	|
		LAST
	|
		LOCALTIMESTAMP
	|
		LOCALTIME
	|
		LOCAL
	|
		MAKEDATE
	|
		MAKETIME
	|
		MONTHNAME
	|
		NUMBER
	|
		PERIOD_ADD
	|
		PERIOD_DIFF
	|
		SEC_TO_TIME
	|
		SHUTDOWN
	|
		STR_TO_DATE
	|
		SUBDATE
	|
		SUBTIME
	|
		SUPER
	|
		SYSDATE
	|
		TIMEDIFF
	|
		TIMESTAMPADD
	|
		TIMESTAMPDIFF
	|
		TIME_FORMAT
	|
		TIME_TO_SEC
	|
		TO_DAYS
	|
		TO_SECONDS
	|
		UNIX_TIMESTAMP
	|
		USAGE
	|
		UTC_DATE
	|
		UTC_TIMESTAMP
	|
		UTC_TIME
	|
		WEEKDAY
	|
		WEEKOFYEAR
	|
		YEARWEEK
	|
		INTERVAL
	|
		SECOND_MICROSECOND
	|
		MINUTE_MICROSECOND
	|
		MINUTE_SECOND
	|
		HOUR_MICROSECOND
	|
		HOUR_SECOND
	|
		HOUR_MINUTE
	|
		DAY_MICROSECOND
	|
		DAY_SECOND
	|
		DAY_MINUTE
	|
		DAY_HOUR
	|
		YEAR_MONTH
	|
		HOUR
	|
		MINUTE
	|
		MICROSECOND
	|
		SECOND
	|
		DAY
	|
		WEEK
	|
		MONTH
	|
		QUARTER
	|
		YEAR
	|
		AVG
	|
		COUNT
	|
		BIT_AND
	|
		BIT_OR
	|
		BIT_XOR
	|
		GROUP_CONCAT
	|
		STDDEV_POP
	|
		STDDEV_SAMP
	|
		STDDEV
	|
		SUM
	|
		VAR_POP
	|
		VAR_SAMP
	|
		VARIANCE
	|
		DISTINCT
	|
		VERSION
	|
		STARTING
	|
		STARTS
	|
		TERMINATED
	|
		OPTIONALLY
	|
		OPTIONS
	|
		OPTION
	|
		PROXY
	|
		ENCLOSED
	|
		LINES
	|
		ROWS
	|
		ZEROFILL
	|
		ALL
	|
		ALTER
	|
		AND
	|
		ANY
	|
		ASC
	|
		BEFORE
	|
		BIGINT
	|
		BIN
	|
		BTREE
	|
		BUFFER
	|
		BY
	|
		COMMIT
	|
		CONDITION
	|
		DATETIME
	|
		DATE
	|
		DEALLOCATE
	|
		DECLARE
	|
		DESC
	|
		DIVIDE
	|
		CACHE
	|
		CALL
	|
		CHARACTER
	|
		CHECKSUM
	|
		CHECK
	|
		CIPHER
	|
		CLOSE
	|
		CODE
	|
		COLLATION
	|
		COMMITTED
	|
		COPY
	|
		CREATE
	|
		CURSOR
	|
		DATABASES
	|
		DATABASE
	|
		DATAFILE
	|
		DATA
	|
		DECIMAL
	|
		DEFINER
	|
		DISABLE
	|
		DOUBLE
	|
		ENABLE
	|
		ENGINES
	|
		ENGINE
	|
		EXCLUSIVE
	|
		EXECUTE
	|
		EXPIRE
	|
		FAST
	|
		FETCH
	|
		FILE
	|
		FIXED
	|
		FLOAT
	|
		FLUSH
	|
		FOREIGN
	|
		FOUND
	|
		FULL
	|
		FUNCTION
	|
		FORCE
	|
		FOR
	|
//		FROM
//	|
		FULLTEXT
	|
		GEOMETRY
	|
		HANDLER
	|
		HASH
	|
		HELP
	|
		HEX
	|
		HOSTS
	|
		HOST
	|
		IDENTIFIED
	|
		IMPORT
	|
		INDEX
	|
		UNINSTALL
	|
		INSTALL
	|
		INVOKER
	|
		ISSUER
	|
		KEYS
	|
		KEY
	|
		KILL
	|
		LEAST
	|
		LENGTH
	|
		LESS
	|
		LIKE
	|
		LINEAR
	|
		UNLOCK
	|
		LOCK
	|
		LOGS
	|
		LONGBLOB
	|
		LONGTEXT
	|
		MASTER
	|
		MAX
	|
		MEDIUMBLOB
	|
		MEDIUMINT
	|
		MEDIUMTEXT
	|
		MEDIUM
	|
		MEMORY
	|
		MODIFIES
	|
		MODIFY
	|
		MIN
	|
		NOT
	|
		NOW
	|
		NULL
	|
		NUMERIC
	|
		OPEN
	|
		OPTIMIZE
	|
		ONLY
	|
		OWNER
	|
		PAGE
	|
		PASSWORD
	|
		POINT
	|
		PORT
	|
		PRIMARY
	|
		PROFILES
	|
		PROFILE
	|
		RELEASE
	|
		READS
	|
		READ
	|
		REBUILD
	|
		RELAY
	|
		REMOVE
	|
		REPAIR
	|
		RESIGNAL
	|
		RETURNS
	|
		RETURN
	|
		REVOKE
	|
		ROW
	|
		SECURITY
	|
		SET
	|
		SHARED
	|
		SHOW
	|
		SIGNAL
	|
		SMALLINT
	|
		SOCKET
	|
		SPATIAL
	|
		START
	|
		STD
	|
		STOP
	|
		STORAGE
	|
		SUBJECT
	|
		TIMESTAMP
	|
		TIME
	|
		TINYBLOB
	|
		TINYINT
	|
		TINYTEXT
	|
		TEXT
	|
		TRUE
	|
		UNDO
	|
		UNKNOWN
	|
		UNION
	|
		UNIQUE
	|
		UNSIGNED
	|
		UNTIL
	|
		USER
	|
		USE
	|
		WHILE
	|
		WITH
	|
		WORK
	|
		WRAPPER
	|
		WRITE
	|
		NDBCLUSTER
	|
		NDB
	|
		NEXT
	|
		NONE
	|
		PREV
	|
		XOR
	|
		INT_STRING
	|
		OR
	|
		VERTBAR
	|
		VALUE
	|
		VIEW
	|
		SONAME
	|
		RENAME
	|
		NAME
	|
		WAIT
	|
		CPU
	|
		DISK
	|
		ENUM
	|
		LIST
	|
		REAL
	|
		IPC
	|
		ADD
	|
		BLOB
	|
		BIT
	|
		GET_STRING
	|
		SQL
	|
		INOUT
	|
		OUT
	|
		X509
	|
		SSL
	|
		XML
	|
		AS
	|
		AT
	|
		DO
	|
		IN
	|
		IF
	|
		IO
	|
		IS
	|
		TO
	|
		OJ
	|
		ON
	|
		NO
;

execute_clause:
	EXECUTE statement_name (USING variable_name (COMMA variable_name)*)?
;

prepare_clause:
	PREPARE statement_name preparable_statement
;

deallocate_prepare_clause:
	(DEALLOCATE | DROP ) PREPARE statement_name
;

preparable_statement:
	USER_VAR
;

statement_name:
	ID | USER_VAR
;

condition_handling_statements:
		declare_condition_clause
	|
		declare_handler_clause
	|
		get_diagnostics_clause
	|
		resignal_clause
	|
		signal_clause
;

declare_condition_clause:
	DECLARE expression CONDITION FOR condition_value
;

declare_handler_clause:
	DECLARE handler_action HANDLER
		FOR condition_value (COMMA condition_value)*
		stat
;

get_diagnostics_clause:
	GET (CURRENT)? DIAGNOSTICS
	(
			statement_information_item (COMMA statement_information_item)*
		|
			CONDITION condition_number
				condition_information_item (COMMA condition_information_item)*
	)
;

resignal_clause:
	RESIGNAL (condition_value)?
		(SET signal_information_item (COMMA signal_information_item)*)?
;

signal_clause:
	SIGNAL condition_value
		(SET signal_information_item (COMMA signal_information_item)*)?
;

signal_information_item:
	condition_information_item_name EQ simple_value_specification
;

simple_value_specification:
	expression
;

statement_information_item:
	target EQ statement_information_item_name
;

condition_information_item:
	target EQ condition_information_item_name
;

statement_information_item_name:
		NUMBER
	|
		ROW_COUNT
;


condition_information_item_name:
		CLASS_ORIGIN
	|
		SUBCLASS_ORIGIN
	|
		RETURNED_SQLSTATE
	|
		MESSAGE_TEXT
	|
		MYSQL_ERRNO
	|
		CONSTRAINT_CATALOG
	|
		CONSTRAINT_SCHEMA
	|
		CONSTRAINT_NAME
	|
		CATALOG_NAME
	|
		SCHEMA_NAME
	|
		TABLE_NAME
	|
		COLUMN_NAME
	|
		CURSOR_NAME
;

target:
	ID | USER_VAR
;

condition_number:
	INT
;

condition_value:
		INT
	|
		condition_name
	|
		SQLSTATE (VALUE)? sqlstate_value
	|
		SQLWARNING
	|
		NOT FOUND
	|
		SQLEXCEPTION
;


condition_name:
	ID
;

handler_action:
		CONTINUE
	|
		EXIT
	|
		UNDO
;

sqlstate_value:
	USER_VAR
;

other_administration_statements:
		binlog_clause
	|
		cache_index_clause
	|
		flush_clause
	|
		kill_clause
	|
		load_index_into_cache_clause
	|
		reset_clause
;

binlog_clause:
	BINLOG USER_VAR
;

cache_index_clause:
	CACHE INDEX
		table_index_list (COMMA table_index_list)*
		(PARTITION LPAREN (ALL | partition_list) RPAREN)?
		IN key_cache_name
;

flush_clause:
	FLUSH
		(
				TABLES WITH READ LOCK
			|
				(NO_WRITE_TO_BINLOG | LOCAL)?
				flush_option (COMMA flush_option)*
			|
				TABLES table_name (COMMA table_name)* (WITH READ LOCK)? (FOR EXPORT)?
		)
;

kill_clause:
	KILL (CONNECTION | QUERY)? INT
;

load_index_into_cache_clause:
	LOAD INDEX INTO CACHE
		table_index_list (COMMA table_index_list)*
;

reset_clause:
	RESET reset_option (COMMA reset_option)*
;

reset_option:
		MASTER
	|
		QUERY CACHE
	|
		SLAVE
;

flush_option:
		DES_KEY_FILE
	|
		HOSTS
	|
		(log_type)? LOGS
	|
		PRIVILEGES
	|
		QUERY CACHE
	|
		STATUS
	|
		TABLES
	|
		USER_RESOURCES
;

log_type:
		BINARY
	|
		ENGINE
	|
		ERROR
	|
		GENERAL
	|
		RELAY
	|
		SLOW
;

cursor_statements:
		cursor_close_clause
	|
		cursor_declare_clause
	|
		cursor_fetch_clause
	|
		cursor_open_clause
;

cursor_close_clause:
	CLOSE cursor_name
;

cursor_declare_clause:
	DECLARE cursor_name CURSOR FOR select_clause
;

cursor_fetch_clause:
	FETCH ((NEXT)? FROM)? cursor_name INTO variable_name (COMMA variable_name)*
;

cursor_open_clause:
	OPEN cursor_name
;

cursor_name:
	ID
;

partition_list:
	partition_name (COMMA partition_name)*
;

key_cache_name:
	ID
;

table_index_list:
	table_name (INDEX | KEY)? LPAREN index_name (COMMA index_name)* RPAREN
	(IGNORE LEAVES)? (PARTITION LPAREN (ALL | partition_list) RPAREN)?

;

plugin_and_udf_statements:
//		create_function_clause // defined in create_clause
//	|
//		drop_function_clause // defined in drop_clause
//	|
		install_plugin_clause
	|
		uninstall_plugin_clause
;

install_plugin_clause:
	INSTALL PLUGIN plugin_name SONAME USER_VAR
;

uninstall_plugin_clause:
	UNINSTALL PLUGIN plugin_name
;

plugin_name:
	ID
;

table_maintenance_statements:
		analyze_table_clause
	|
		check_table_clause
	|
		checksum_table_clause
	|
		optimize_table_clause
	|
		repair_table_clause
;

analyze_table_clause:
	ANALYZE (NO_WRITE_TO_BINLOG | LOCAL)? TABLE table_name (COMMA table_name)*
;

check_table_clause:
	CHECK TABLE table_name (COMMA table_name)* check_table_option
;

checksum_table_clause:
	CHECKSUM TABLE table_name (COMMA table_name)* (QUICK | EXTENDED)?
;

optimize_table_clause:
	OPTIMIZE (NO_WRITE_TO_BINLOG | LOCAL)? TABLE table_name (COMMA table_name)*
;

repair_table_clause:
	REPAIR (NO_WRITE_TO_BINLOG | LOCAL)? TABLE table_name (COMMA table_name)*
	(QUICK)? (EXTENDED)? (USE_FRM)?
;

check_table_option:
		FOR UPGRADE
	|
		QUICK
	|
		FAST
	|
		MEDIUM
	|
		EXTENDED
	|
		CHANGED
;

account_management_statements:
		alter_user_clause
	|
		create_user_clause
	|
		drop_user_clause
	|
		grant_clause
	|
		rename_user_clause
	|
		revoke_clause
	|
		set_password_clause
;

revoke_clause:
	REVOKE
		(
				priv_type (LPAREN column_name (COMMA column_name)* RPAREN)? (COMMA priv_type (LPAREN column_name (COMMA column_name)* RPAREN)?)*
				ON (object_type)? priv_level
				FROM username (COMMA username)*
			|
				ALL PRIVILEGES COMMA GRANT OPTION
					FROM username (COMMA username)*
			|
				PROXY ON username
					FROM username (COMMA username)*
		)
;

grant_clause:
	GRANT
		(
				priv_type (LPAREN column_name (COMMA column_name)*)? (COMMA priv_type (LPAREN column_name (COMMA column_name)*)?)*
				ON (object_type)? priv_level
				TO user_specification (COMMA user_specification)*
				(REQUIRE (NONE | ssl_option ((AND)? ssl_option)*)+)?
				(WITH (GRANT OPTION | resource_option)+)?
			|
				PROXY ON user_specification
				TO user_specification (COMMA user_specification)*
				(WITH GRANT OPTION)?
		)
;

resource_option:
		MAX_QUERIES_PER_HOUR INT
	|
		MAX_UPDATES_PER_HOUR INT
	|
		MAX_CONNECTIONS_PER_HOUR INT
	|
		MAX_USER_CONNECTIONS INT
;

ssl_option:
		SSL
	|
		X509
	|
		CIPHER USER_VAR
	|
		ISSUER USER_VAR
	|
		SUBJECT USER_VAR
;

priv_level:
		ASTERISK DOT ASTERISK
	|
		ASTERISK
	|
		database_name DOT ASTERISK
	|
		database_name DOT table_name
	|
		table_name
	|
		database_name DOT routine_name
;

routine_name:
	ID
;

object_type:
		TABLE
	|
		FUNCTION
	|
		PROCEDURE
;

priv_type:
		ALL (PRIVILEGES)?
	|
		ALTER ROUTINE
	|
		ALTER
	|
		CREATE ROUTINE
	|
		CREATE TABLESPACE
	|
		CREATE TEMPORARY TABLES
	|
		CREATE USER
	|
		CREATE VIEW
	|
		CREATE
	|
		DELETE
	|
		DROP
	|
		EVENT
	|
		EXECUTE
	|
		FILE
	|
		GRANT OPTION
	|
		INDEX
	|
		INSERT
	|
		LOCK TABLES
	|
		PROCESS
	|
		PROXY
	|
		REFERENCES
	|
		RELOAD
	|
		REPLICATION CLIENT
	|
		REPLICATION SLAVE
	|
		SELECT
	|
		SHOW DATABASES
	|
		SHOW VIEW
	|
		SHUTDOWN
	|
		SUPER
	|
		TRIGGER
	|
		UPDATE
	|
		USAGE
;

alter_user_clause:
	ALTER USER user_specification (COMMA alter_user_specification)*
;

alter_user_specification:
	username PASSWORD EXPIRE
;

create_user_clause:
	CREATE USER user_specification (COMMA user_specification)*
;

user_specification:
	username (user_identified_option)?
;

user_identified_option:
		IDENTIFIED BY PASSWORD USER_VAR
	|
		IDENTIFIED BY USER_VAR
	|
		IDENTIFIED WITH ID (AS USER_VAR)?
;

drop_user_clause:
	DROP USER username (COMMA username)*
;

rename_user_clause:
	RENAME USER old_user TO new_user (COMMA old_user TO new_user)
;

old_user:
	username
;

new_user:
	username
;

set_password_clause:
	SET PASSWORD (FOR username)? EQ password_option
;

password_option:
		PASSWORD LPAREN USER_VAR RPAREN
	|
		OLD_PASSWORD LPAREN USER_VAR RPAREN
	|
		USER_VAR
;

replication_slave_statements:
		change_master_clause
	|
		master_pos_wait_clause
	|
		reset_slave_clause
	|
//		set_global_sql_slave_skip_counter_clause // should be covered by set_clause
//	|
		start_slave_clause
	|
		stop_slave_clause
;

stop_slave_clause:
	STOP SLAVE (thread_types)?
;

start_slave_clause:
	START SLAVE (thread_types)? (until_option)? (connection_option)*
;

connection_option:
		USER EQ USER_VAR
	|
		PASSWORD EQ USER_VAR
	|
		DEFAULT_AUTH EQ USER_VAR
	|
		PLUGIN_DIR EQ USER_VAR
;

until_option:
	UNTIL
		(
				(SQL_BEFORE_GTIDS | SQL_AFTER_GTIDS) EQ gtid_set
			|
				MASTER_LOG_FILE EQ filename COMMA MASTER_LOG_POS EQ INT
			|
				RELAY_LOG_FILE EQ filename COMMA RELAY_LOG_POS EQ INT
			|
				SQL_AFTER_MTS_GAPS
		)

;

gtid_set:
		uuid_set (COMMA uuid_set)*
	|
		blank_quotes
;

uuid_set:
	UUID COLON uuid_interval (COLON uuid_interval)? (UUID COLON uuid_interval (COLON uuid_interval)?)*
;

uuid_interval:
	INT (MINUS INT)?
;

thread_types:
		IO_THREAD
	|
		SQL_THREAD
;

//set_global_sql_slave_skipe_counter_clause:
//	SET GLOBAL sql_slave_skip_counter EQ INT
//;

reset_slave_clause:
	RESET SLAVE (ALL)?
;

master_pos_wait_clause:
	SELECT MASTER_POS_WAIT LPAREN filename COMMA INT (COMMA INT)? RPAREN
;

change_master_clause:
	CHANGE MASTER TO master_option (COMMA master_option)*
;


master_option:
		MASTER_BIND EQ USER_VAR
	|
		MASTER_HOST EQ USER_VAR
	|
		MASTER_USER EQ USER_VAR
	|
		MASTER_PASSWORD EQ USER_VAR
	|
		MASTER_PORT EQ INT
	|
		MASTER_CONNECT_RETRY EQ interval
	|
		MASTER_RETRY_COUNT EQ INT
	|
		MASTER_DELAY EQ interval
	|
		MASTER_HEARTBEAT_PERIOD EQ interval
	|
		MASTER_LOG_FILE EQ filename
	|
		MASTER_LOG_POS EQ INT
	|
		MASTER_AUTO_POSITION EQ INT //('0'|'1')
	|
		RELAY_LOG_FILE EQ filename
	|
		RELAY_LOG_POS EQ INT
	|
		MASTER_SSL EQ INT //('0'|'1')
	|
		MASTER_SSL_CA EQ USER_VAR
	|
		MASTER_SSL_CAPATH EQ USER_VAR
	|
		MASTER_SSL_CERT EQ filename
	|
		MASTER_SSL_CRL EQ filename
	|
		MASTER_SSL_CRLPATH EQ USER_VAR
	|
		MASTER_SSL_KEY EQ filename
	|
		MASTER_SSL_CIPHER EQ USER_VAR
	|
		MASTER_SSL_VERIFY_SERVER_CERT EQ INT //('0'|'1')
	|
		IGNORE_SERVER_IDS EQ LPAREN server_id_list
;

server_id_list:
	server_id (COMMA server_id)*
;

server_id:
	INT
;

set_transaction_clause:
	SET (GLOBAL | SESSION)? TRANSACTION
		transaction_characteristic (COMMA transaction_characteristic)*
;

unlock_tables_clause:
	UNLOCK TABLES
;

lock_tables_clause:
	LOCK TABLES
		table_name (table_alias)? lock_type (COMMA table_name (table_alias)? lock_type)*
;

lock_type:
		READ (LOCAL)?
	|
		(LOW_PRIORITY)? WRITE
;

release_savepoint_clause:
	RELEASE SAVEPOINT savepoint
;

rollback_to_savepoint_clause:
	ROLLBACK (WORK)? TO (SAVEPOINT)? savepoint
;

savepoint_clause:
	SAVEPOINT savepoint
;

savepoint:
	ID
;

start_transaction_clause:
	START TRANSACTION (WITH CONSISTENT SNAPSHOT)?
;

load_xml_clause:
	LOAD XML (LOW_PRIORITY | CONCURRENT)? INFILE filename
		(REPLACE | IGNORE)?
		INTO TABLE (database_name DOT)? table_name
		(CHARACTER SET charset_name)?
		(ROWS IDENTIFIED BY xml_tagname)?
		(IGNORE INT (LINES | ROWS))?
		(LPAREN (USER_VAR | ID) (COMMA (USER_VAR | ID)) RPAREN)?
		(SET column_name EQ expression (COMMA column_name EQ expression)*)?
;

xml_tagname:
	USER_VAR
;

load_data_infile_clause:
	LOAD DATA (LOW_PRIORITY | CONCURRENT)? (LOCAL)? INFILE filename
		(REPLACE | IGNORE)?
		INTO TABLE table_name
		(CHARACTER SET charset_name)?
		((FIELDS | COLUMNS)
			(TERMINATED BY USER_VAR)?
			((OPTIONALLY)? ENCLOSED BY USER_VAR)?
			(ESCAPED BY USER_VAR)?
		)?
		(LINES
			(STARTING BY USER_VAR)?
			(TERMINATED BY USER_VAR)?
		)?
		(IGNORE INT LINES)?
		(LPAREN (column_name | USER_VAR) (COMMA (column_name | USER_VAR))* RPAREN)?
		(SET column_name EQ expression (COMMA column_name EQ expression)*)?
;

handler_clause:
	HANDLER table_name
		(
				OPEN ((AS)? handler_alias)?
			|
				READ index_name (EQ | LET | GET | LTH | GTH) LPAREN column_name (COMMA column_name)* RPAREN
					(where_clause)? (limit_clause)?
			|
				READ index_name (FIRST | NEXT | PREV | LAST)
					(where_clause)? (limit_clause)?
			|
				READ (FIRST | NEXT)
					(where_clause)? (limit_clause)?
		)
;

handler_alias:
	ID | USER_VAR
;

do_clause:
	DO expression (COMMA expression)*
;


replication_master_statements:
		purge_binary_logs_clause
	|
		reset_master_clause
;

reset_master_clause:
	RESET MASTER
;

purge_binary_logs_clause:
	PURGE (BINARY | MASTER) LOGS (TO log_name | BEFORE datetime_expr)
;

log_name:
	USER_VAR
;

datetime_expr:
	timestamp
;

create_clause:
	CREATE
		(
				(DATABASE | SCHEMA) (IF NOT EXISTS)? database_name (create_specification)* //create database and schema
			|
				(DEFINER EQ (CURRENT_USER | user_name))? // create event
				EVENT (IF NOT EXISTS)? event_name
				ON SCHEDULE schedule
				(ON COMPLETION (NOT)? PRESERVE)?
				(ENABLE | DISABLE ON SLAVE | DISABLE)?
				(COMMENT comment)?
				DO stat
			|
				(DEFINER EQ (CURRENT_USER | user_name))? // create function
				FUNCTION function_name LPAREN function_parameter (COMMA function_parameter)*
				RETURNS data_type
				(function_characteristic)* stat
			|
				(DEFINER EQ (CURRENT_USER | user_name))? // create procedure
				PROCEDURE procedure_name LPAREN procedure_parameter (COMMA procedure_parameter)* RPAREN
				(function_characteristic)* stat
			|
				(ONLINE | OFFLINE)? (UNIQUE | FULLTEXT | SPATIAL)? INDEX index_name // create index
					(index_type)?ON table_name index_column_names_parens
					(index_option)?
					(index_algorithm_option | lock_option)*
			|
				LOGFILE GROUP logfile_group // create logfile group
					ADD UNDOFILE undo_file
					(INITIAL_SIZE (EQ)? INT)?
					(UNDO_BUFFER_SIZE (EQ)? INT)?
					(REDO_BUFFER_SIZE (EQ)? INT)?
					(NODEGROUP (EQ)? INT)?
					(WAIT)?
					(COMMENT (EQ)? comment)?
					ENGINE (EQ)? engine_name
			|
				SERVER server_name // create server
					FOREIGN DATA WRAPPER wrapper_name
					OPTIONS server_option (COMMA server_option)*
			|
				(TEMPORARY)? TABLE (IF NOT EXISTS)? table_name
					LPAREN create_table_definition (COMMA create_table_definition)* RPAREN
					(table_options)?
					(partition_options)?
			|
				(TEMPORARY)? TABLE (IF NOT EXISTS)? table_name
					LPAREN create_table_definition (COMMA create_table_definition)* RPAREN
					(table_options)?
					(partition_options)?
					(IGNORE | REPLACE)? (AS)? select_clause
			|
				(TEMPORARY)? TABLE (IF NOT EXISTS)? table_name (LIKE old_table_name | LPAREN LIKE old_table_name RPAREN) // create table like
			|
				TABLESPACE tablespace_name // create tablespace
					ADD DATAFILE filename
					USE LOGFILE GROUP logfile_group
					(EXTENT_SIZE (EQ)? size)?
					(INITIAL_SIZE (EQ)? INT)?
					(AUTOEXTEND_SIZE (EQ)? INT)?
					(MAX_SIZE (EQ)? INT)?
					(NODEGROUP (EQ)? INT)?
					(WAIT)?
					(COMMENT (EQ)? comment)?
					ENGINE (EQ)? engine_name
			|
				(DEFINER EQ (CURRENT_USER | user_name))? // create trigger
				TRIGGER trigger_name
				trigger_time trigger_event
				ON table_name FOR EACH ROW
				trigger_body
			|
				(OR REPLACE)? // create view
				(ALGORITHM EQ (UNDEFINED | MERGE | TEMPTABLE))?
				(DEFINER EQ (CURRENT_USER | user_name))?
				(SQL SECURITY (DEFINER | INVOKER))?
				VIEW view_name (LPAREN column_name (COMMA column_name)* RPAREN)?
				AS select_clause
				(WITH (CASCADED | LOCAL)? CHECK OPTION)?
		)
;

wrapper_name:
	ID | USER_VAR
;

old_table_name:
	table_name
;

trigger_body:
	stat
;

trigger_time:
	BEFORE | AFTER
;

trigger_event:
	INSERT | UPDATE | DELETE
;

undo_file:
	USER_VAR
;

lock_option:
	ALGORITHM (EQ)? (DEFAULT | NONE | SHARED | EXCLUSIVE)
;

partition_options:
	PARTITION BY
		(
				(LINEAR)? HASH LPAREN expression RPAREN
			|
				(LINEAR)? KEY (ALGORITHM EQ INT)? LPAREN column_name (COMMA column_name)* RPAREN
			|
				RANGE ( LPAREN expression RPAREN | COLUMNS LPAREN column_name (COMMA column_name)* RPAREN )
			|
				LIST ( LPAREN expression RPAREN | COLUMNS LPAREN column_name (COMMA column_name)* RPAREN )
		)
		(PARTITIONS INT)?
		(SUBPARTITION BY
			(
					(LINEAR)? HASH LPAREN expression RPAREN
				|
					(LINEAR)? KEY (ALGORITHM EQ INT)? LPAREN column_name (COMMA column_name)* RPAREN
			)
		(SUBPARTITIONS INT)?
		)?
		(LPAREN subpartition_definition (COMMA subpartition_definition)* RPAREN)?

;

create_table_definition:
		column_name column_definition
	|
		(CONSTRAINT (index_symbol)?)? PRIMARY KEY (index_type)? index_column_names_parens (index_option)*
	|
		(INDEX|KEY) (index_name)? (index_type)? index_column_names_parens (index_option)*
	|
		(CONSTRAINT (index_symbol)?)? UNIQUE (INDEX | KEY)? (index_name)? (index_type)? index_column_names_parens (index_option)?
	|
		(FULLTEXT | SPATIAL) (INDEX | KEY)? (index_name)? index_column_names_parens (index_option)?
	|
		(CONSTRAINT (index_symbol)?)? FOREIGN KEY (index_name)? index_column_names_parens reference_definition
	|
		CHECK LPAREN expression RPAREN

;

index_column_names_parens:
	LPAREN index_column_names RPAREN
;

index_column_names:
	column_name (COMMA column_name)*
;

procedure_parameter:
	(IN | OUT | INOUT)? function_parameter
;

function_parameter:
	ID data_type
;

create_specification:
		(DEFAULT)? CHARACTER_SET (EQ)? charset_name
	|
		(DEFAULT)? COLLATE (EQ)? collation_name
;

alter_clause:
	ALTER
		(
				(DATABASE | SCHEMA) database_name (alter_database_specification | UPGRADE DATA DIRECTORY NAME) // alter database and schema
			|
				(DEFINER EQ user_name)? EVENT event_name // alter event
					(ON SCHEDULE schedule)?
					(ON COMPLETION (NOT)? PRESERVE)?
					(RENAME TO new_event_name)?
					(ENABLE | DISABLE ON SLAVE | DISABLE)?
					(COMMENT USER_VAR)?
					(DO event_body)?
			|
				LOGFILE GROUP logfile_group ADD UNDOFILE filename // alter logfile
					(INITIAL_SIZE (EQ)? size)?
					(WAIT)?
					ENGINE (EQ)? engine_name
			|
				FUNCTION function_name (function_characteristic)* // alter function
			|
				PROCEDURE procedure_name (procedure_characteristic)* // alter procedure
			|
				SERVER server_name OPTIONS LPAREN server_option (COMMA server_option)* RPAREN // alter server
			|
				(ONLINE | OFFLINE)? (IGNORE)? TABLE table_name (alter_specification (COMMA alter_specification)*)? (partition_options)? // alter table
			|
				TABLESPACE tablespace_name (ADD | DROP) filename (INITIAL_SIZE (EQ)? size)? (WAIT)? ENGINE (EQ)? engine_name
			|
				(ALGORITHM EQ (UNDEFINED | MERGE | TEMPTABLE))? // alter view
				(DEFINER EQ (CURRENT_USER | user_name))?
				(SQL SECURITY (DEFINER | INVOKER))?
				VIEW view_name (LPAREN column_list RPAREN)?
				AS select_clause
				(WITH (CASCADED | LOCAL)? CHECK OPTION)?
		)
;

user_name:
	ID
;

alter_specification:
		table_options
	|
		ADD (COLUMN)? column_name column_definition (FIRST | AFTER column_name)?
	|
		ADD (COLUMN)? LPAREN column_name column_definition (COMMA column_name column_definition)* RPAREN
	|
		ADD (INDEX | KEY) (index_name)? ((index_name)? (index_type)? LPAREN index_column_name (COMMA index_column_name)* RPAREN (index_option)?)+
	|
		ADD (CONSTRAINT index_symbol)? PRIMARY KEY ((index_type)? LPAREN index_column_name (COMMA index_column_name)* RPAREN (index_option)?)+
	|
		ADD (CONSTRAINT index_symbol)? UNIQUE (INDEX|KEY)? (index_name)? ((index_type)? LPAREN index_column_name (COMMA index_column_name)* RPAREN (index_options)?)+
	|
		ADD FULLTEXT (INDEX | KEY)? (index_name)? (LPAREN index_column_name (COMMA index_column_name)* RPAREN (index_options)?)+
	|
		ADD SPATIAL (INDEX | KEY)? (index_name)? (LPAREN index_column_name (COMMA index_column_name)* LPAREN (index_options)?)+
	|
		ADD (CONSTRAINT index_symbol)? FOREIGN KEY (index_name)? LPAREN index_column_name (COMMA index_column_name)* RPAREN reference_definition
	|
		ALGORITHM (EQ)? (DEFAULT | INPLACE | COPY)
	|
		ALTER (COLUMN)? column_name (SET DEFAULT literals | DROP DEFAULT)
	|
		CHANGE (COLUMN)? old_column_name new_column_name column_definition (FIRST | AFTER column_name)?
	|
		LOCK (EQ)? (DEFAULT | NONE | SHARED | EXCLUSIVE)
	|
		MODIFY (COLUMN)? column_name column_definition (FIRST | AFTER column_name)?
	|
		DROP (COLUMN)? column_name
	|
		DROP PRIMARY KEY
	|
		DROP (INDEX | KEY) index_name
	|
		DROP FOREIGN KEY foreign_key_symbol
	|
		DISABLE KEYS
	|
		ENABLE KEYS
	|
		RENAME (TO | AS) new_table_name
	|
		ORDER BY column_name (COMMA column_name)*
	|
		CONVERT TO CHARACTER SET charset_name (COLLATE collation_name)?
	|
		(DEFAULT)? CHARACTER SET (EQ)? charset_name (COLLATE (EQ)? collation_name)?
	|
		DISCARD TABLESPACE
	|
		IMPORT TABLESPACE
	|
		FORCE
	|
		ADD PARTITION LPAREN partition_definition RPAREN
	|
		DROP PARTITION partition_names
	|
		TRUNCATE PARTITION (ALL | partition_names)
	|
		COALESCE PARTITION partition_number
	|
		REORGANIZE PARTITION partition_names INTO LPAREN partition_definition (COMMA partition_definition)* RPAREN
	|
		EXCHANGE PARTITION partition_name WITH TABLE table_name
	|
		ANALYZE PARTITION (ALL | partition_names)
	|
		CHECK PARTITION (ALL | partition_names)
	|
		OPTIMIZE PARTITION (ALL | partition_names)
	|
		REBUILD PARTITION (ALL | partition_names)
	|
		REPAIR PARTITION (ALL | partition_names)
	|
		REMOVE PARTITIONING
;

partition_number:
	INT
;

partition_definition:
	PARTITION partition_name
		(VALUES ((LESS THAN LPAREN expression | value_list RPAREN) | MAXVALUE) | IN LPAREN value_list RPAREN)?
		((STORAGE)? ENGINE (EQ)? engine_name)?
		(COMMENT (EQ)? comment)?
		(DATA DIRECTORY data_directory_path)?
		(INDEX DIRECTORY index_directory_path)?
		(MAX_ROWS (EQ)? max_rows)?
		(MIN_ROWS (EQ)? min_rows)?
		(TABLESPACE (EQ)? tablespace_name)?
		(NODEGROUP (EQ)? node_group_id)?
		(LPAREN subpartition_definition (COMMA subpartition_definition)* RPAREN)?
;

value_list:
	INT (COMMA INT)*
;

subpartition_definition:
	SUBPARTITION subpartition_name
		((STORAGE)? ENGINE (EQ)? engine_name)?
		(COMMENT (EQ)? comment)?
		(DATA DIRECTORY (EQ)? data_directory_path)?
		(INDEX DIRECTORY (EQ)? index_directory_path)?
                (MAX_ROWS (EQ)? max_rows)?
                (MIN_ROWS (EQ)? min_rows)?
		(TABLESPACE (EQ)? tablespace_name)?
		(NODEGROUP (EQ)? node_group_id)?
;

subpartition_name:
	ID
;

node_group_id:
	ID
;

tablespace_name:
	ID
;

new_table_name:
	table_name
;

foreign_key_symbol:
	ID
;

old_column_name:
	column_name
;

new_column_name:
	column_name
;

index_column_name:
	column_name
;

index_symbol:
	ID
;

index_option:
		KEY_BLOCK_SIZE (EQ)? INT
	|
		index_type
	|
		WITH PARSER parser_name
	|
		COMMENT comment
;

parser_name:
	ID
;

index_type:
	USING (BTREE | HASH)
;

column_definition:
	data_type (NOT NULL | NULL)? (DEFAULT expression)?
		(AUTO_INCREMENT)?
		(UNIQUE (KEY)? | (PRIMARY)? KEY)?
		(COMMENT comment)?
		(COLUMN_FORMAT (FIXED | DYNAMIC | DEFAULT))?
		(STORAGE (DISK|MEMORY|DEFAULT))?
		(reference_definition)?

;

reference_definition:
	REFERENCES table_name LPAREN column_name (COMMA column_name)* RPAREN
		(MATCH (FULL | PARTIAL | SIMPLE))?
		(ON DELETE reference_option)?
		(ON UPDATE reference_option)?
;

reference_option:
		RESTRICT
	|
		CASCADE
	|
		SET NULL
	|
		NO ACTION
;

data_type:
		BIT (LPAREN INT RPAREN)?
	|
		TINYINT (LPAREN INT RPAREN)? (UNSIGNED)? (ZEROFILL)?
	|
		SMALLINT (LPAREN INT RPAREN)? (UNSIGNED)? (ZEROFILL)?
	|
		MEDIUMINT (LPAREN INT RPAREN)? (UNSIGNED)? (ZEROFILL)?
	|
		INT_STRING (LPAREN INT RPAREN)? (UNSIGNED)? (ZEROFILL)?
	|
		INTEGER (LPAREN INT RPAREN)? (UNSIGNED)? (ZEROFILL)?
	|
		BIGINT (LPAREN INT RPAREN)? (UNSIGNED)? (ZEROFILL)?
	|
		REAL (LPAREN INT (COMMA INT)? RPAREN)? (UNSIGNED)? (ZEROFILL)?
	|
		DOUBLE (LPAREN INT (COMMA INT)? RPAREN)? (UNSIGNED)? (ZEROFILL)?
	|
		FLOAT (LPAREN INT (COMMA INT)? RPAREN)? (UNSIGNED)? (ZEROFILL)?
	|
		DECIMAL (LPAREN INT (COMMA INT)? RPAREN)? (UNSIGNED)? (ZEROFILL)?
	|
		NUMERIC (LPAREN INT (COMMA INT)? RPAREN)? (UNSIGNED)? (ZEROFILL)?
	|
		DATE
	|
		TIME (LPAREN INT RPAREN)? // TIME(fsp) fsp = fractional seconds precision
	|
		TIMESTAMP (LPAREN INT RPAREN)?
	|
		DATETIME (LPAREN INT RPAREN)?
	|
		YEAR
	|
		CHAR (LPAREN INT RPAREN)? (BINARY)? (CHARACTER SET charset_name)? (COLLATE collation_name)?
	|
		VARCHAR (LPAREN INT RPAREN)? (BINARY)? (CHARACTER SET charset_name)? (COLLATE collation_name)?
	|
		BINARY (LPAREN INT RPAREN)?
	|
		VARBINARY LPAREN INT RPAREN
	|
		TINYBLOB
	|
		BLOB
	|
		MEDIUMBLOB
	|
		LONGBLOB
	|
		TINYTEXT (BINARY)? (CHARACTER SET charset_name)? (COLLATE collation_name)?
	|
		TEXT (BINARY)? (CHARACTER SET charset_name)? (COLLATE collation_name)?
	|
		MEDIUMTEXT (BINARY)? (CHARACTER SET charset_name)? (COLLATE collation_name)?
	|
		LONGTEXT (BINARY)? (CHARACTER SET charset_name)? (COLLATE collation_name)?
	|
		ENUM LPAREN expression (COMMA expression)* RPAREN (CHARACTER SET charset_name)? (COLLATE collation_name)?
	|
		SET LPAREN expression (COMMA expression)* RPAREN (CHARACTER SET charset_name)? (COLLATE collation_name)?
	|
		spatial_type
;

spatial_type:
		GEOMETRY
	|
		POINT
	|
		LINESTRING
	|
		POLYGON
	|
		MULTIPOINT
	|
		MULTILINESTRING
	|
		MULTIPOLYGON
	|
		GEOMETRYCOLLECTION
;

table_options:
	table_option ((COMMA)? table_option)*
;

table_option:
		ENGINE (EQ)? engine_name
	|
		AUTO_INCREMENT (EQ)? INT
	|
		AVG_ROW_LENGTH (EQ)? INT
	|
		(DEFAULT)? CHARACTER SET (EQ)? charset_name
	|
		CHECKSUM (EQ)? INT //('0'|'1')
	|
		(DEFAULT)? COLLATE (EQ)? collation_name
	|
		COMMENT (EQ)? comment
	|
		CONNECTION (EQ)? connection_string
	|
		DATA DIRECTORY (EQ)? data_directory_path
	|
		DELAY_KEY_WRITE (EQ)? INT //('0'|'1')
	|
		INDEX DIRECTORY (EQ)? index_directory_path
	|
		INSERT_METHOD (EQ)? (NO | FIRST | LAST)
	|
		KEY_BLOCK_SIZE (EQ)? key_block_size
	|
		MAX_ROWS (EQ)? max_rows
	|
		MIN_ROWS (EQ)? min_rows
	|
		PACK_KEYS (EQ)? (INT | DEFAULT)// ('0'|'1'|DEFAULT)
	|
		PASSWORD (EQ)? table_password
	|
		ROW_FORMAT (EQ)? (DEFAULT | DYNAMIC | FIXED | COMPRESSED | REDUNDANT | FIXED)
	|
		STATS_AUTO_RECALC (EQ)? (INT | DEFAULT) //(DEFAULT|'0'|'1')
	|
		STATS_PERSISTENT (EQ)? (DEFAULT | INT) //(DEFAULT|'0'|'1')
	|
		STATS_SAMPLE_PAGES (EQ)? stats_sample_pages
	|
		TABLESPACE table_space_name (STORAGE (DISK | MEMORY | DEFAULT))?
	|
		UNION (EQ)? table_name LPAREN table_name (COMMA table_name)* RPAREN
;

stats_sample_pages:
	INT
;

table_password:
	USER_VAR
;

min_rows:
	INT
;

max_rows:
	INT
;

key_block_size:
	INT
;

index_directory_path:
	USER_VAR
;

data_directory_path:
	USER_VAR
;

comment:
	USER_VAR
;

connection_string:
	USER_VAR
;

server_option:
		HOST server_host
	|
		DATABASE server_database
	|
		USER server_user
	|
		PASSWORD server_password
	|
		SOCKET server_socket
	|
		OWNER server_owner
	|
		PORT server_port
;

server_host:
	USER_VAR
;

server_database:
	USER_VAR
;

server_user:
	USER_VAR
;

server_password:
	USER_VAR
;

server_socket:
	USER_VAR
;

server_owner:
	USER_VAR
;

server_port:
	INT
;

procedure_characteristic:
	function_characteristic
;

function_characteristic:
		COMMENT USER_VAR
	|
		LANGUAGE SQL
	|
		(CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA)
	|
		SQL SECURITY (DEFINER | INVOKER)
;

size:
	ID
;

filename:
	USER_VAR
;

logfile_group:
	ID | USER_VAR
;

event_body:
	stat
;

new_event_name:
	event_name
;
schedule:
                AT timestamp (PLUS INTERVAL interval)*
        |
                EVERY interval (STARTS timestamp (PLUS INTERVAL interval)*)? (ENDS timestamp (PLUS INTERVAL interval)*)?
;

interval:
	INT date_time_units
;

timestamp:
		USER_VAR
	 |
		date_time_functions
;

username:
	CURRENT_USER | ID
;

alter_database_specification:
	(DEFAULT)?
		(
				CHARACTER SET (EQ)? charset_name
			|
				COLLATE (EQ)? collation_name
		)
;

charset_name:
	USER_VAR | ID
;

use_clause:
	USE database_name
;

drop_clause:
	DROP
		(
				(DATABASE | SCHEMA) (IF EXISTS)? database_name // drop database
			|
				EVENT (IF EXISTS)? event_name // drop event
			|
				(PROCEDURE | FUNCTION) (IF EXISTS)?  function_name // drop procedure function
			|
				INDEX (ONLINE|OFFLINE)? index_name ON table_name (index_algorithm_option | drop_index_lock_option)?
			|
				LOGFILE GROUP logfile_group ENGINE (EQ)? engine_name
			|
				SERVER (IF EXISTS)? server_name
			|
				(TEMPORARY)? TABLE (IF EXISTS)? table_name (COMMA table_name) (RESTRICT | CASCADE)?
			|
				TABLESPACE table_space_name ENGINE (EQ)? engine_name
			|
				TRIGGER (IF EXISTS)? trigger_name
			|
				VIEW (IF EXISTS)? view_name (COMMA view_name)* (RESTRICT | CASCADE)?
		)
;

engine_name:
		NDBCLUSTER
	|
		NDB
;

help_clause:
	HELP USER_VAR
;

view_name:
	database_name
;

trigger_name:
	database_name
;

table_space_name:
	database_name
;

server_name:
	database_name
;

index_algorithm_option:
	ALGORITHM (EQ)? (DEFAULT | INPLACE | COPY)
;

drop_index_lock_option:
	LOCK (EQ)? (DEFAULT | NONE | SHARED | EXCLUSIVE)
;

function_name:
	database_name
;

event_name:
	database_name
;

rename_clause:
	RENAME TABLE table_name TO table_name (COMMA table_name TO table_name)*
;

truncate_clause:
	TRUNCATE (TABLE)? table_name
;

call_clause:
	CALL stored_procedure_name LPAREN (stored_procedure_parameter (COMMA stored_procedure_parameter)* )? RPAREN
;

stored_procedure_name:
	ID
;

stored_procedure_parameter:
		USER_VAR
	|
		blank_quotes
;

replace_clause:
	REPLACE (LOW_PRIORITY | DELAYED)?
		(INTO)? table_references
		(partition_clause)?
			(
					(column_list)?
					(VALUE | VALUES) LPAREN (DEFAULT | expression) (COMMA (DEFAULT | expression))* RPAREN (COMMA LPAREN (DEFAULT | expression) (COMMA (DEFAULT | expression))* RPAREN)*
				|
					SET column_name EQ (DEFAULT | expression) (COMMA column_name EQ (DEFAULT | expression))*
				|
					(column_list)?
					select_clause
			)
;

delete_clause:
	DELETE
		(LOW_PRIORITY)? (QUICK)? (IGNORE)?
		FROM table_references
		(partition_clause)?
		(where_clause)?
		(order_by_clause)?
		(limit_clause)?
;

insert_clause:
	INSERT
		(LOW_PRIORITY | DELAYED | HIGH_PRIORITY)?
		(IGNORE)?
		(INTO)? table_references
		(partition_clause)?
		(LPAREN column_name (COMMA column_name)* RPAREN)?
		(
			(VALUES | VALUE) LPAREN (DEFAULT | expression) (COMMA (DEFAULT | expression))* RPAREN (COMMA LPAREN (DEFAULT | expression) (COMMA (DEFAULT | expression))* RPAREN)*
			(ON DUPLICATE KEY UPDATE column_name EQ expression (COMMA column_name EQ expression)*)?
		|
			// handle insert ... select
			(LPAREN select_clause RPAREN | select_clause)
			(ON DUPLICATE KEY UPDATE column_name EQ expression (COMMA column_name EQ expression)*)?
		|
			SET column_name EQ (DEFAULT | expression) (COMMA column_name EQ (DEFAULT | expression))*
				(ON DUPLICATE KEY UPDATE column_name EQ expression (COMMA column_name EQ (DEFAULT | expression))*)?
		)
;



update_clause:
        UPDATE
            (LOW_PRIORITY)? (IGNORE)?
            table_references SET column_name EQ (DEFAULT | expression) (COMMA column_name EQ (DEFAULT | expression))*
            (where_clause)?
            (order_by_clause)?
            (limit_clause)?
;

explain_clause:
        (EXPLAIN | DESCRIBE | DESC) table_references (column_name | wildcard)
    |
        (EXPLAIN | DESCRIBE | DESC) (EXTENDED)? select_clause
;

rollback_clause:
	ROLLBACK (WORK)? (AND (NO)? CHAIN)? ((NO)? RELEASE)?
;

commit_clause:
	COMMIT (WORK)? (AND (NO)? CHAIN)? ((NO)? RELEASE)?
;

begin_clause:
	BEGIN (WORK)?
;

start_clause:
	START TRANSACTION (WITH CONSISTENT SNAPSHOT)?
;

transaction_level:
		REPEATABLE READ
	|
		READ COMMITTED
	|
		READ UNCOMMITTED
	|
		SERIALIZABLE
;

transaction_characteristic:
		ISOLATION LEVEL transaction_level
	|
		READ WRITE
	|
		READ ONLY
;

set_clause:
		SET (OPTION)? variable_name EQ variable_value
	|
		SET (OPTION)? variable_name variable_value
	|
		SET (GLOBAL | SESSION)? TRANSACTION transaction_characteristic (COMMA transaction_characteristic)*
;

variable_name:
		USER_VAR
	|
		ID
	|
		USER_VAR DOT ID
;

variable_value:
	expression
;

show_clause:
		SHOW (BINARY | MASTER) LOGS
	|
		SHOW BINLOG EVENTS (IN USER_VAR)? (FROM expression)? (LIMIT (expression COMMA)? expression)?
	|
		SHOW CHARACTER SET (like_or_where)?
	|
		SHOW COLLATION (like_or_where)?
	|
		SHOW (FULL)? COLUMNS FROM table_references (FROM database_name)? (like_or_where)?
	|
		SHOW CREATE DATABASE database_name
	|
		SHOW CREATE EVENT USER_VAR
	|
		SHOW CREATE FUNCTION USER_VAR
	|
		SHOW CREATE PROCEDURE USER_VAR
	|
		SHOW CREATE TABLE table_references
	|
		SHOW CREATE TRIGGER USER_VAR
	|
		SHOW DATABASES like_or_where
	|
		SHOW ENGINE USER_VAR (LOGS | STATUS | MUTEX)
	|
		SHOW (STORAGE)? ENGINES
	|
		SHOW ERRORS (LIMIT (expression COMMA)? expression)?
	|
		SHOW EVENTS
	|
		SHOW FUNCTION CODE USER_VAR
	|
		SHOW FUNCTION STATUS (like_or_where)?
	|
		SHOW GRANTS FOR USER_VAR
	|
		SHOW INDEX FROM table_references (FROM database_name)?
	|
	    	SHOW INNODB STATUS
	|
		SHOW MASTER STATUS
	|
		SHOW OPEN TABLES FROM database_name (like_or_where)?
	|
		SHOW PLUGINS
	|
		SHOW PROCEDURE CODE USER_VAR
	|
		SHOW PROCEDURE STATUS (like_or_where)?
	|
		SHOW PRIVILEGES
	|
		SHOW (FULL)? PROCESSLIST
	|
		SHOW PROFILE (show_profile_types (COMMA show_profile_types)*)? (FOR QUERY expression)? (LIMIT USER_VAR (OFFSET USER_VAR)?)?
	|
		SHOW PROFILES
	|
		SHOW SLAVE HOSTS
	|
		SHOW SLAVE STATUS (NONBLOCKING)?
	|
		SHOW (GLOBAL | SESSION)? STATUS (FROM database_name)? (like_or_where)?
	|
		SHOW TABLE STATUS (FROM database_name)? (like_or_where)?
	|
		SHOW (FULL)? TABLES (FROM database_name)? (like_or_where)?
	|
		SHOW TRIGGERS (FROM database_name)? (like_or_where)?
	|
		SHOW (GLOBAL | SESSION)? VARIABLES ( WHERE (ID|USER_VAR) EQ (ID|INT|USER_VAR) ((OR|AND) (ID|USER_VAR) EQ (ID|INT|USER_VAR))*)?
	//|
	//	SHOW (GLOBAL | SESSION)? VARIABLES like_or_where
	|
		SHOW WARNINGS (LIMIT (USER_VAR COMMA)? USER_VAR)?
;

show_profile_types:
		ALL
	|
		BLOCK IO
	|
		CPU
	|
		IPC
	|
		MEMORY
	|
		PAGE FAULTS
	|
		SOURCE
	|
		SWAPS
;

like_or_where:
	(LIKE USER_VAR | where_clause)
;

schema_name:
    ID
;

select_clause:
		//common_select_clause
	//|
		SELECT
		(ALL | DISTINCT | DISTINCTROW)?
		(HIGH_PRIORITY)?
		(STRAIGHT_JOIN)?
		(SQL_SMALL_RESULT)? (SQL_BIG_RESULT)? (SQL_BUFFER_RESULT)?
		(SQL_CACHE)? (SQL_NO_CACHE)? (SQL_CALC_FOUND_ROWS)?
		column_list_clause
		(from_clause)?
		(where_clause)?
		(group_by_clause)?
		(having_clause)?
		(order_by_clause)?
                (limit_clause)?
		(procedure_clause)?
		(outfile_clause)?
;

common_select_clause:
	SELECT  (
				common_select_join_clause
			|
				column_name (COMMA column_name)* from_clause where_clause
			|
		)
;

common_select_join_clause:
			column_name (COMMA column_name)* FROM table_name LEFT OUTER JOIN column_name ON column_name EQ column_name LEFT OUTER JOIN column_name ON column_name EQ column_name where_clause

;

from_clause:
		FROM table_references
	|
		subselect_clause
;

outfile_clause:
	INTO OUTFILE USER_VAR (load_file_parameters)
;

load_file_parameters:
	(REPLACE | IGNORE)?
	INTO TABLE table_name
	(PARTITION partition_names)?
	((FIELDS | COLUMNS)
		(TERMINATED BY USER_VAR)?
		((OPTIONALLY)? ENCLOSED BY USER_VAR)?
		(ESCAPED BY USER_VAR)?
	)?
	(LINES
		(STARTING BY USER_VAR)?
		(TERMINATED BY USER_VAR)?
	)?
	(IGNORE INT (LINES | ROWS)?)?
	(ID | USER_VAR)?
	(SET set_parameters)?
;


set_parameters:
	set_parameter (COMMA set_parameter)*
;
set_parameter:
	column_name EQ (USER_VAR | expression)
;


order_by_clause:
	ORDER BY having_or_group_parameters (ASC | DESC)?
;

having_clause:
	HAVING expression
;

group_by_clause:
	GROUP BY having_or_group_parameters ( ASC | DESC )? (WITH ROLLUP)?
;

order:
	ORDER
;

having_or_group_parameters:
		column_list_clause
	|
		expression
	|
		INT
;

procedure_clause:
	PROCEDURE procedure_name column_list_clause
;

procedure_name:
	ID
;

subselect_clause:
	FROM LPAREN select_clause RPAREN
;

limit_clause:
		LIMIT (expression COMMA)? expression
	|
		LIMIT expression OFFSET expression
;

table_name:
		USER_VAR (table_alias)?
	|
		absolute_table_name (table_alias)?
;

table_alias:
	(AS)? table_name
;

db_name:
		USER_VAR
	|
		reserved_keywords
	|
		ID
;

tb_name:
		USER_VAR
	|
		reserved_keywords
	|
		ID
;

col_name:
		USER_VAR
	|
		reserved_keywords
	|
		ID
;

column_name_alias:
	(AS)? valid_alias
;

valid_alias:
 	{!isKeyword()}? (reserved_keywords | USER_VAR | ID)
;

wildcard:
	ASTERISK
;

user_var:
	USER_VAR
;

column_name:
		(db_name DOT)? tb_name ALL_FIELDS
	|
		wildcard
	|
		mysql_function (column_name_alias)?
	|
		(db_name DOT)?? (tb_name DOT)? col_name (column_name_alias)?
;

mysql_function:
		control_flow_functions
	|
		string_functions
	|
		numeric_functions
	|
		date_time_functions
	|
		full_text_search_functions
	|
		cast_functions
	|
		xml_functions
	|
		bit_functions
	|
		encryption_and_compression_functions
	|
		information_functions
	|
		spatial_analysis_functions
	|
		misc_functions
	|
		group_by_functions
	|
		comparison_functions
;

statement_list:
	stat (stat)*
;

case_clause:
	CASE expression
		WHEN expression THEN statement_list
		(WHEN expression THEN statement_list)*
		(ELSE statement_list)?
	END CASE
;

if_clause:
	IF expression THEN statement_list
		(ELSEIF expression THEN statement_list)?
		(ELSE statement_list)?
	END IF
;

iterate_clause:
	ITERATE label
;

leave_clause:
	LEAVE label
;

loop_clause:
	(label_declaration)? LOOP
				statement_list
	END LOOP (label)?
;

repeat_clause:
	(label_declaration)? REPEAT
				statement_list
	UNTIL expression
	END REPEAT (label)?
;

return_clause:
	RETURN expression
;

while_clause:
	(label_declaration)? WHILE expression DO
				statement_list
	END WHILE (label)?
;

label_declaration:
	label COLON
;

label:
	ID
;

control_flow_functions:
		case_function
	|
		if_function
	|
		ifnull_function
	|
		nullif_function
;

case_function:
		CASE variable_value WHEN (expression)? THEN expression (WHEN (expression)? THEN expression)* (ELSE expression)? END
	|
		CASE WHEN (expression)? THEN expression (WHEN (expression)? THEN expression)* (ELSE expression)? END
;

if_function:
	IF LPAREN expression COMMA expression COMMA expression RPAREN
;

ifnull_function:
	IFNULL LPAREN expression COMMA expression RPAREN
;

nullif_function:
	NULLIF LPAREN expression COMMA expression RPAREN
;

control_flow_statements:
		case_clause
	|
		if_clause
	|
		iterate_clause
	|
		leave_clause
	|
		loop_clause
	|
		repeat_clause
	|
		return_clause
	|
		while_clause
;

string_functions:
		ASCII LPAREN expression RPAREN
	|
		BIN LPAREN expression RPAREN
	|
		BIT_LENGTH LPAREN expression RPAREN
	|
		CHAR LPAREN expression (COMMA expression)* (USING ID)? RPAREN
	|
		CHARACTER_LENGTH LPAREN expression RPAREN
	|
		CONCAT LPAREN expression (COMMA expression)*  RPAREN
	|
		CONCAT_WS LPAREN expression COMMA expression (COMMA expression)* LPAREN
	|
		ELT LPAREN INT COMMA expression (COMMA expression)* RPAREN
	|
		EXPORT_SET LPAREN INT COMMA expression COMMA expression (COMMA expression)* RPAREN
	|
		FIELD LPAREN expression (COMMA expression)* RPAREN
	|
		FIND_IN_SET LPAREN expression COMMA expression RPAREN
	|
		FORMAT LPAREN expression COMMA expression RPAREN
	|
		HEX LPAREN expression RPAREN
	|
		INSERT LPAREN expression COMMA expression COMMA expression COMMA expression RPAREN
	|
		INSTR LPAREN expression COMMA expression COMMA RPAREN
	|
		LCASE LPAREN expression RPAREN
	|
		LEFT LPAREN expression COMMA expression RPAREN
	|
		LENGTH LPAREN expression RPAREN
	|
		LOAD_FILE LPAREN expression RPAREN
	|
		LOCATE LPAREN expression COMMA expression (COMMA expression)? RPAREN
	|
		LOWER LPAREN expression RPAREN
	|
		LPAD LPAREN expression COMMA expression COMMA expression RPAREN
	|
		LTRIM LPAREN expression RPAREN
	|
		MAKE_SET LPAREN expression COMMA expression (COMMA expression)* RPAREN
	|
		MID LPAREN expression COMMA expression COMMA expression (COMMA expression)* RPAREN
	|
		OCT LPAREN expression RPAREN
	|
		OCTET_LENGTH LPAREN expression RPAREN
	|
		ORD LPAREN expression RPAREN
	|
		POSITION LPAREN expression IN expression RPAREN
	|
		QUOTE LPAREN expression RPAREN
	|
		REPEAT LPAREN expression COMMA expression RPAREN
	|
		REPLACE LPAREN expression COMMA expression COMMA expression RPAREN
	|
		REVERSE LPAREN expression RPAREN
	|
		RIGHT LPAREN expression COMMA expression RPAREN
	|
		RPAD LPAREN expression COMMA expression COMMA expression RPAREN
	|
		RTRIM LPAREN expression RPAREN
	|
		SOUNDEX LPAREN expression RPAREN
	// this one is broken, gotta fix expression
	//|
	//	expression SOUNDS LIKE expression
	|
		SPACE LPAREN expression RPAREN
	|
		STRCMP LPAREN expression COMMA expression RPAREN
	|
		SUBSTR LPAREN substring_parameters RPAREN
	|
		SUBSTRING LPAREN substring_parameters
	|
		SUBSTRING_INDEX LPAREN expression COMMA expression COMMA expression RPAREN
	|
		TRIM LPAREN (((BOTH | LEADING | TRAILING) USER_VAR? FROM)? expression | ((USER_VAR FROM)? expression)) RPAREN
	|
		UCASE LPAREN expression RPAREN
	|
		UNHEX LPAREN USER_VAR RPAREN
	|
		UPPER LPAREN USER_VAR RPAREN
	|
		WEIGHT_STRING LPAREN USER_VAR (AS (CHAR | BINARY) (LPAREN INT RPAREN)?)? RPAREN
;

substring_parameters:
	(
			expression COMMA expression
		|
			expression FROM expression
		|
			expression COMMA expression COMMA expression
		|
			expression FROM expression FOR expression
	)
;

numeric_functions:
                ABS LPAREN INT RPAREN
        |
                ACOS LPAREN expression RPAREN
        |
                ASIN LPAREN expression RPAREN
        |
                ATAN LPAREN expression (COMMA expression)? RPAREN
        |
                ATAN2 LPAREN expression COMMA expression RPAREN
        |
                CEIL LPAREN expression RPAREN
        |
                CEILING LPAREN expression RPAREN
        |
                CONV LPAREN expression COMMA expression COMMA expression RPAREN
        |
                COS LPAREN expression RPAREN
        |
                COT LPAREN expression RPAREN
        |
                CRC32 LPAREN expression RPAREN
        |
                DEGREES LPAREN expression RPAREN
        |
                EXP LPAREN expression RPAREN
        |
                FLOOR LPAREN expression RPAREN
        |       // skip FORMAT function because it's considered to be a string handling function as well
                //  and it's already included in that section
                // skip HEX function because it's considered to be a sting handling function as well
                //   and it's alreday included in that section

                LN LPAREN expression RPAREN
        |
                LOG LPAREN expression RPAREN
        |
                LOG2 LPAREN expression RPAREN
        |
                LOG10 LPAREN expression RPAREN
        |
                //(MOD LPAREN expression COMMA expression RPAREN | expression MOD expression) // This last one is broken
        //|
                PI LPAREN RPAREN
        |
                POW LPAREN expression COMMA expression RPAREN
        |
                POWER LPAREN expression COMMA expression RPAREN
        |
                RADIANS LPAREN expression RPAREN
        |
                RAND LPAREN (INT)? RPAREN
        |
                ROUND LPAREN expression (COMMA expression)? RPAREN
        |
                SIGN LPAREN expression RPAREN
        |
                SIN LPAREN expression RPAREN
        |
                SQRT LPAREN expression RPAREN
        |
                TAN LPAREN expression RPAREN
        |
                TRUNCATE LPAREN expression COMMA expression RPAREN
;

date_time_functions:
		ADDDATE LPAREN
			(
					USER_VAR COMMA interval_expr
				|
					expression COMMA INT
			)
			RPAREN
	|
		ADDTIME LPAREN expression COMMA expression RPAREN
	|
		CONVERT_TZ LPAREN expression COMMA expression COMMA expression RPAREN
	|
		CURDATE LPAREN RPAREN
	|
		CURRENT_DATE (LPAREN RPAREN)?
	|
		CURRENT_TIME (LPAREN RPAREN)?
	|
		CURRENT_TIMESTAMP (LPAREN RPAREN)?
	|
		CURTIME LPAREN RPAREN
	|
		DATE LPAREN expression RPAREN
	|
		DATEDIFF LPAREN expression COMMA expression RPAREN
	|
		DATE_ADD LPAREN expression COMMA interval_expr RPAREN
	|
		DATE_SUB LPAREN expression COMMA interval_expr RPAREN
	|
		DATE_FORMAT LPAREN expression COMMA expression RPAREN
	|
		DAY LPAREN (expression)? RPAREN
	|
		DAYNAME LPAREN USER_VAR RPAREN
	|
		DAYOFMONTH LPAREN USER_VAR RPAREN
	|
		DAYOFWEEK LPAREN USER_VAR RPAREN
	|
		DAYOFYEAR LPAREN USER_VAR RPAREN
	|
		EXTRACT LPAREN date_time_units FROM USER_VAR RPAREN
	|
		FROM_DAYS LPAREN expression RPAREN
	|
		FROM_UNIXTIME LPAREN USER_VAR (COMMA USER_VAR)? RPAREN
	|
		GET_FORMAT LPAREN (DATE | TIME | DATETIME | TIMESTAMP) COMMA USER_VAR RPAREN
	|
		HOUR LPAREN USER_VAR RPAREN
	|
		LAST_DAY LPAREN USER_VAR RPAREN
	|
		LOCALTIME (LPAREN USER_VAR RPAREN)?
	|
		LOCALTIMESTAMP (LPAREN USER_VAR RPAREN)?
	|
		MAKEDATE LPAREN INT COMMA INT RPAREN
	|
		MAKETIME LPAREN INT COMMA INT COMMA INT RPAREN
	|
		MICROSECOND LPAREN expression RPAREN
	|
		MINUTE LPAREN USER_VAR RPAREN
	|
		MONTH LPAREN expression RPAREN
	|
		MONTHNAME LPAREN USER_VAR RPAREN
	|
		NOW LPAREN RPAREN
	|
		PERIOD_ADD LPAREN INT COMMA INT RPAREN
	|
		PERIOD_DIFF LPAREN INT COMMA INT RPAREN
	|
		QUARTER LPAREN USER_VAR RPAREN
	|
		SECOND LPAREN USER_VAR RPAREN
	|
		SEC_TO_TIME LPAREN INT RPAREN
	|
		STR_TO_DATE LPAREN USER_VAR COMMA USER_VAR RPAREN
	|
		SUBDATE LPAREN
				(
						USER_VAR COMMA interval_expr
					|
						expression COMMA USER_VAR
				)
				RPAREN
	|
		SUBTIME LPAREN expression COMMA expression RPAREN
	|
		SYSDATE LPAREN RPAREN
	|
		TIME LPAREN expression RPAREN
	|
		TIMEDIFF LPAREN expression COMMA expression RPAREN
	|
		TIMESTAMP LPAREN expression (COMMA expression)? RPAREN
	|
		TIMESTAMPADD LPAREN date_time_units COMMA INT COMMA expression RPAREN
	|
		TIMESTAMPDIFF LPAREN date_time_units COMMA expression COMMA expression RPAREN
	|
		TIME_FORMAT LPAREN USER_VAR COMMA USER_VAR RPAREN
	|
		TIME_TO_SEC LPAREN USER_VAR RPAREN
	|
		TO_DAYS LPAREN expression RPAREN
	|
		TO_SECONDS LPAREN expression RPAREN
	|
		UNIX_TIMESTAMP LPAREN (expression)? RPAREN
	|
		UTC_DATE (LPAREN RPAREN)?
	|
		UTC_TIME (LPAREN RPAREN)?
	|
		UTC_TIMESTAMP (LPAREN RPAREN)?
	|
		WEEK LPAREN USER_VAR (COMMA INT)? RPAREN
	|
		WEEKDAY LPAREN USER_VAR RPAREN
	|
		WEEKOFYEAR LPAREN USER_VAR RPAREN
	|
		YEAR LPAREN USER_VAR RPAREN
	|
		YEARWEEK LPAREN USER_VAR (COMMA INT)? RPAREN
;

date_time_units:
		SECOND_MICROSECOND
	|
		MINUTE_MICROSECOND
	|
		MINUTE_SECOND
	|
		HOUR_MICROSECOND
	|
		HOUR_SECOND
	|
		HOUR_MINUTE
	|
		DAY_MICROSECOND
	|
		DAY_SECOND
	|
		DAY_MINUTE
	|
		DAY_HOUR
	|
		YEAR_MONTH
	|
		HOUR
	|
		MINUTE
	|
		SECOND
	|
		DAY
	|
		WEEK
	|
		MONTH
	|
		QUARTER
	|
		YEAR
	|
		MICROSECOND
;

full_text_search_functions:
	MATCH column_list AGAINST LPAREN expression (
			IN NATURAL LANGUAGE MODE (WITH QUERY EXPANSION)?
		|
			IN BOOLEAN MODE
		|
			WITH QUERY EXPANSION
	) RPAREN
;

cast_functions:
		BINARY
	|
		CAST LPAREN expression AS ID RPAREN
	|
		CONVERT LPAREN (expression COMMA ID | expression USING ID) RPAREN
;

xml_functions:
		EXTRACT_VALUE LPAREN expression COMMA expression RPAREN
	|
		UPDATE_XML LPAREN expression COMMA expression COMMA expression RPAREN
;

bit_functions:
		BIT_COUNT LPAREN expression RPAREN
;

encryption_and_compression_functions:
		AES_ENCRYPT LPAREN expression COMMA expression (COMMA expression)? RPAREN
	|
		COMPRESS LPAREN USER_VAR RPAREN
	|
		DECODE LPAREN expression COMMA expression RPAREN
	|
		DES_DECRYPT LPAREN expression (COMMA expression)? RPAREN
	|
		DES_ENCRYPT LPAREN expression (COMMA expression)? RPAREN
	|
		ENCODE LPAREN expression COMMA expression RPAREN
	|
		ENCRYPT LPAREN expression (COMMA expression)? RPAREN
	|
		MD5 LPAREN expression RPAREN
	|
		OLD_PASSWORD LPAREN RPAREN
	|
		PASSWORD LPAREN USER_VAR RPAREN
	|
		RANDOM_BYTES LPAREN expression RPAREN
	|
		SHA1 LPAREN expression RPAREN
	|
		SHA LPAREN expression RPAREN
	|
		SHA2 LPAREN expression COMMA expression RPAREN
	|
		UNCOMPRESS LPAREN expression RPAREN
	|
		UNCOMPRESSED_LENGTH LPAREN expression RPAREN
	|
		VALIDATE_PASSWORD_STRENGTH LPAREN expression RPAREN
;

information_functions:
		VERSION LPAREN RPAREN
;

spatial_analysis_functions:
		AREA LPAREN expression RPAREN
	|
		CENTROID LPAREN expression RPAREN
	|
		EXTERIORRING LPAREN expression RPAREN
	|
		NUMINTERIORRINGS LPAREN expression RPAREN
	|
		ST_AREA LPAREN expression RPAREN
	|
		ST_CENTROID LPAREN expression RPAREN
	|
		ST_EXTERIORRING LPAREN expression RPAREN
	|
		ST_INTERIORRINGN LPAREN expression COMMA expression RPAREN
	|
		ST_NUMINTERIORRINGS LPAREN expression RPAREN
	|
		geometry_functions
	|
		BUFFER LPAREN expression COMMA expression (COMMA expression)* RPAREN
	|
		CONVEXHULL LPAREN expression RPAREN
	|
		ST_BUFFER LPAREN expression COMMA expression (COMMA expression)* RPAREN
	|
		ST_BUFFER_STRATEGY expression (COMMA expression)? RPAREN
	|
		ST_CONVEXHULL LPAREN expression RPAREN
	|
		ST_DIFFERENCE LPAREN expression COMMA expression RPAREN
	|
		ST_INTERSECTION LPAREN expression COMMA expression RPAREN
	|
		ST_SYMDIFFERENCE LPAREN expression COMMA expression RPAREN
	|
		ST_UNION LPAREN expression COMMA expression RPAREN
	|
		ST_ENVELOPE LPAREN expression RPAREN
	|
		ST_STARTPOINT LPAREN expression RPAREN
	|
		ST_ENDPOINT LPAREN expression RPAREN
	|
		ST_POINTN LPAREN expression COMMA expression RPAREN
;

geometry_functions:
		GEOMETRYN LPAREN expression COMMA expression RPAREN
	|
		NUMGEOMETRIES LPAREN expression RPAREN
	|
		ST_GEOMETRYN LPAREN expression COMMA expression RPAREN
	|
		ST_NUMGEOMETRIES LPAREN expression RPAREN
;

misc_functions:
		ANY_VALUE LPAREN expression RPAREN
	|
		DEFAULT LPAREN column_name RPAREN
	|
		GET_LOCK LPAREN USER_VAR COMMA INT RPAREN
	|
		INET_ATON LPAREN expression RPAREN
	|
		INET_NTOA LPAREN expression RPAREN
	|
		INET6_ATON LPAREN expression RPAREN
	|
		INET6_NTOA LPAREN expression RPAREN
	|
		IS_FREE_LOCK LPAREN USER_VAR RPAREN
	|
		IS_IPV4 LPAREN expression RPAREN
	|
		IS_IPV4_COMPAT LPAREN expression RPAREN
	|
		IS_IPV4_MAPPED LPAREN expression RPAREN
	|
		IS_IPV6 LPAREN expression RPAREN
	|
		IS_USED_LOCK LPAREN USER_VAR RPAREN
	|
		MASTER_POS_WAIT LPAREN expression COMMA expression (COMMA expression)? RPAREN
	|
		NAME_CONST LPAREN expression COMMA expression RPAREN
	|
		RELEASE_ALL_LOCKS LPAREN RPAREN
	|
		RELEASE_LOCK LPAREN expression RPAREN
	|
		SLEEP LPAREN expression RPAREN
	|
		UUID LPAREN RPAREN
	|
		UUID_SHORT LPAREN RPAREN
	|
		VALUES LPAREN column_name RPAREN
;

group_by_functions:
		AVG LPAREN (DISTINCT)? expression RPAREN
	|
		BIT_AND LPAREN expression RPAREN
	|
		BIT_OR LPAREN expression RPAREN
	|
		BIT_XOR LPAREN expression RPAREN
	|
		COUNT LPAREN (DISTINCT)? (ASTERISK | (expression (COMMA expression)*))? RPAREN
	|
		GROUP_CONCAT LPAREN expression RPAREN
	|
		MAX LPAREN (DISTINCT)? expression RPAREN
	|
		MIN LPAREN (DISTINCT)? expression RPAREN
	|
		STD LPAREN expression RPAREN
	|
		STDDEV LPAREN expression RPAREN
	|
		STDDEV_POP LPAREN expression RPAREN
	|
		STDDEV_SAMP LPAREN expression RPAREN
	|
		SUM LPAREN (DISTINCT)? expression RPAREN
	|
		VAR_POP LPAREN expression RPAREN
	|
		VAR_SAMP LPAREN expression RPAREN
	|
		VARIANCE LPAREN expression RPAREN
;

comparison_functions:
		COALESCE LPAREN expression COMMA expression (COMMA expression)* RPAREN
	|
		GREATEST LPAREN expression COMMA expression (COMMA expression)* RPAREN
	|
		ISNULL LPAREN expression RPAREN
	|
		INTERVAL LPAREN expression COMMA expression (COMMA expression)* RPAREN
	|
		LEAST LPAREN expression COMMA expression (COMMA expression)* RPAREN
;

concat_parameters:
	concat_parameter (COMMA concat_parameter)*
;

concat_parameter:
		USER_VAR
	|
		expression
	|
		absolute_table_name

;

index_name:
	ID
;

column_list:
	LPAREN column_name (COMMA column_name)* RPAREN
;

column_list_clause:
	expression (column_name_alias)? (COMMA expression (column_name_alias)?)*
;

where_clause:
	WHERE expression
;

blank_quotes:
		BLANK_SINGLE
	|
		BLANK_DOUBLE
	|
		BLANK_SLANT
;

comparison_operator:
		EQ
	|
		GET
	|
		GTH
	|
		LET
	|
		LTH
	|
		NOT_EQ
;

expression:
		expression OR expression
	|
		expression DBLVERTBAR expression
	|
		expression XOR expression
	|
		expression AND expression
	|
		NOT expression
	|
		boolean_primary (IS (NOT)? (TRUE | FALSE | UNKNOWN))?
;

boolean_primary:
                boolean_primary IS (NOT)? NULL
        |
                boolean_primary GTEQLT predicate
        |
                boolean_primary comparison_operator predicate
        |
                boolean_primary comparison_operator (ALL | ANY) LPAREN subquery RPAREN
        |
                predicate
;

predicate:
		bit_expr (NOT)? IN LPAREN subquery RPAREN
	|
		bit_expr (NOT)? IN LPAREN expression (COMMA expression)* RPAREN
	|
		bit_expr (NOT)? BETWEEN bit_expr AND predicate
	|
		bit_expr SOUNDS LIKE bit_expr
	|
		bit_expr (NOT)? LIKE simple_expr (ESCAPE simple_expr)?
	|
		bit_expr (NOT)? REGEXP bit_expr
	|
		bit_expr
;

bit_expr:
		bit_expr VERTBAR bit_expr
	|
		bit_expr BITAND bit_expr
	|
		bit_expr SHIFT_LEFT bit_expr
	|
		bit_expr SHIFT_RIGHT  bit_expr
	|
		bit_expr PLUS bit_expr
	|
		bit_expr MINUS bit_expr
	|
		bit_expr ASTERISK bit_expr
	|
		bit_expr DIVIDE bit_expr
	|
		bit_expr MOD bit_expr
	|
		bit_expr POWER_OP bit_expr
	|
		bit_expr PLUS interval_expr
	|
		bit_expr MINUS interval_expr
	|
		simple_expr
;

simple_expr:
                literals
        |
                mysql_function
        |
                column_name // aka identifier
        |
                simple_expr COLLATE collation_name
        |
                param_marker
        |
                variable // variable
        |
                simple_expr DBLVERTBAR simple_expr
        |
                PLUS simple_expr
        |
                MINUS simple_expr
        |
                TILDE simple_expr
        |
                NOT simple_expr
        |
                BINARY simple_expr
        |
                LPAREN expression (COMMA expression)* RPAREN
        |
                ROW LPAREN expression COMMA expression (COMMA expression)* RPAREN
        |
                subquery
        |
                EXISTS LPAREN subquery RPAREN
        |
                indentifier expression
        |
                full_text_search_functions
        |
                case_clause
        |
                interval_expr
;


interval_expr:
	INTERVAL expression date_time_units
;


collation_name:
	USER_VAR | ID
;

param_marker:
	QUESTION_MARK
;

variable:
		USER_VAR
	|
		blank_quotes
;

indentifier:
	column_name
;

literals:
		string_literals
	|
		numeric_literals
	|
		date_time_literals
	|
		hexadecimal_literals
	|
		boolean_literals
	|
		bit_field_literals
	|
		null_values
;

string_literals:
	USER_VAR
;

numeric_literals:
		(MINUS)?
			(
					INT? DOT INT
				|
					SCIENTIFIC_NOTATION
				|
					INT
			)
;

date_time_literals:
		USER_VAR
;

hexadecimal_literals:
	HEX_LITERALS
;

boolean_literals:
		TRUE
	|
		FALSE
;

bit_field_literals:
	BIT_FIELD_LITERAL
;

null_values:
		NULL
	|
		SLASH_N
;

bit_operators:
		VERTBAR
	|
		AND
	|
		SHIFT_LEFT
	|
		SHIFT_RIGHT
	|
		PLUS
	|
		MINUS
	|
		ASTERISK
	|
		DIVIDE
	|
		MOD
	|
		POWER_OP
;

relational_op:
	EQ | LTH | GTH | NOT_EQ | LET | GET
;

expr_op:
	AND | XOR | OR | NOT
;

between_op:
	BETWEEN
;

is_or_is_not:
	IS (NOT)?
;

database_name:
	ID | absolute_table_name
;

table_references:
        table_reference (COMMA (table_reference) | join_clause )*
;

absolute_table_name:
	column_name
;

table_reference:
                db_table
	|
		column_name
	|
		table_atom
	|
		table_factor1
;

db_table:
	(db_name DOT)? tb_name (table_alias2)?
;

table_alias2:
	(AS)? (ID | USER_VAR)
;


table_factor1:
	table_factor2 (  (INNER | CROSS)? JOIN table_atom (join_condition)? )?
;

table_factor2:
	table_factor3 (  STRAIGHT_JOIN table_atom (ON expression)?  )?
;

table_factor3:
	table_factor4 (  (LEFT|RIGHT) (OUTER)? JOIN table_factor4 join_condition  )?
;

table_factor4:
	table_atom (  NATURAL ( (LEFT|RIGHT) (OUTER)? )? JOIN table_atom )?
;

table_atom:
	  ( table_name (partition_clause)? (table_alias)? (index_hint_list)? )
	| ( subquery subquery_alias )
	| ( LPAREN table_references RPAREN )
	| ( OJ table_reference LEFT OUTER JOIN table_reference ON expression )
;

join_clause:
        (  (INNER | CROSS)? JOIN table_atom (join_condition)? )
    |
        (  STRAIGHT_JOIN table_atom (ON expression)?  )
    |
        (  (LEFT|RIGHT) (OUTER)? JOIN table_factor4 join_condition  )
    |
        (  NATURAL ( (LEFT|RIGHT) (OUTER)? )? JOIN table_atom )
    ;

join_condition:
	  //(ON expression (expr_op expression)*) | (USING column_list)

		ON column_name comparison_operator column_name (COMMA column_name comparison_operator column_name)*
	|
	  	ON expression
	|
		USING column_list
;

index_hint_list:
	index_hint (COMMA index_hint)*
;

index_options:
	(INDEX | KEY) (FOR ((JOIN) | (ORDER BY) | (GROUP BY)))?
;

index_hint:
		USE    index_options LPAREN (index_list)? RPAREN
	|
		IGNORE index_options LPAREN index_list RPAREN
;

index_list:
	index_name (COMMA index_name)*
;

partition_clause:
	PARTITION LPAREN partition_names RPAREN
;

partition_names:
	partition_name (COMMA partition_name)*
;

partition_name:
	ID
;

subquery_alias:
	ID
;

subquery:
	LPAREN select_clause RPAREN
;
