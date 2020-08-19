SELECT normalizeQuery('SELECT 1');
SELECT normalizeQuery('SELECT  1');
SELECT normalizeQuery('SELECT  1, 1, 1');
SELECT normalizeQuery('SELECT 1, 1, 1, /* Hwllo */');
SELECT normalizeQuery('SELECT 1, 1, 1, /* Hello */');
SELECT normalizeQuery('SELECT 1, 1, 1, /* Hello */ \'abc\'');
SELECT normalizeQuery('SELECT 1, 1, 1, /* Hello */ \'abc\' WHERE 1');
SELECT normalizeQuery('SELECT 1, 1, 1, /* Hello */ \'abc\' WHERE 1 = 1');
SELECT normalizeQuery('SELECT 1, 1, 1, /* Hello */ \'abc\' WHERE 1 = 1 AND (x, y)');
SELECT normalizeQuery('SELECT 1, 1, 1, /* Hello */ \'abc\' WHERE 1 = 1 AND (1, y)');
SELECT normalizeQuery('[1, 2, 3]');
SELECT normalizeQuery('[1, 2, 3, x]');
SELECT normalizeQuery('SELECT 1, 1, 1, /* Hello */ \'abc\' WHERE 1 = 1 AND (1, y) LIMIT 1, 1');
SELECT normalizeQuery('SELECT 1 AS `xyz`');
SELECT normalizeQuery('SELECT 1 AS `xyz1`');
SELECT normalizeQuery('SELECT 1 AS `xyz11`');
SELECT normalizeQuery('SELECT 1 AS xyz111');
SELECT normalizeQuery('SELECT 1 AS xyz1');
SELECT normalizeQuery('SELECT 1 AS xyz11');
SELECT normalizeQuery('SELECT 1 xyz11');
SELECT normalizeQuery('SELECT 1, xyz11');
SELECT normalizeQuery('SELECT 1, ''xyz11''');
