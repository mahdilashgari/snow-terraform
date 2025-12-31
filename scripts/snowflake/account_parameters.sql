use role accountadmin; 
alter account set timezone = 'europe/berlin';
alter account set week_start = 1;
alter account set allow_id_token = true;
alter account set enable_unredacted_query_syntax_error=true;