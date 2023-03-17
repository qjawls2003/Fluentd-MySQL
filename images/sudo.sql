USE logs;
SELECT * FROM rsyslog
WHERE ident='sudo'and timestamp != 'NULL';
