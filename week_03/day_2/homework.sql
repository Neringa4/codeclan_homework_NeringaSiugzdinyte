/* MVP */

/* Q1 */

/* (a) */

SELECT 
    e.first_name,
    e.last_name,
    t."name" 
FROM employees AS e INNER JOIN teams AS t
ON e.team_id = t.id;

/* (b) */

SELECT 
    e.first_name,
    e.last_name,
    t."name" 
FROM employees AS e INNER JOIN teams AS t
ON e.team_id = t.id
WHERE pension_enrol IS TRUE;

/* (c) */

SELECT 
    e.first_name,
    e.last_name,
    t."name" 
FROM employees AS e INNER JOIN teams AS t
ON e.team_id = t.id
WHERE CAST(t.charge_cost AS int) > 80;


/* Q2 */

/* (a) */

SELECT 
    e.*,
    pd.local_account_no,
    pd.local_sort_code 
FROM employees AS e LEFT JOIN pay_details AS pd 
ON e.pay_detail_id = pd.id;

/* (b) */

SELECT 
    e.*,
    pd.local_account_no,
    pd.local_sort_code,
    t."name" 
FROM (employees AS e LEFT JOIN pay_details AS pd 
ON e.pay_detail_id = pd.id) 
LEFT JOIN teams AS t ON e.team_id = t.id;

/* Q3 */

/* (a) */

SELECT 
    e.id,
    t."name"
FROM employees AS e INNER JOIN teams AS t
ON e.team_id = t.id;

/* (b) */

SELECT
    t."name",
    count(e.id)
FROM employees AS e INNER JOIN teams AS t
ON e.team_id = t.id
GROUP BY t."name";

/* (c) */

SELECT
    t."name",
    count(e.id) AS num_employees
FROM employees AS e INNER JOIN teams AS t
ON e.team_id = t.id
GROUP BY t."name"
ORDER BY num_employees;


/* Q4 */

/* (a) */

SELECT
    t.id,
    t."name",
    count(e.id) AS num_employees
FROM teams AS t INNER JOIN employees AS e 
ON t.id = e.team_id 
GROUP BY t."name", t.id;

/* (b) */

SELECT
    t.id,
    t."name",
    count(e.id) AS num_employees,
    t.charge_cost,
    CAST(t.charge_cost AS int) * count(e.id) AS total_day_charge
FROM teams AS t INNER JOIN employees AS e 
ON t.id = e.team_id 
GROUP BY t."name", t.id;

/* (c) */

SELECT
    t.id,
    t."name",
    t.total_day_charge
FROM (SELECT
          t.id,
          t."name",
          count(e.id) AS num_employees,
          t.charge_cost,
          CAST(t.charge_cost AS int) * count(e.id) AS total_day_charge
      FROM teams AS t INNER JOIN employees AS e 
      ON t.id = e.team_id 
      GROUP BY t."name", t.id
    ) t
WHERE total_day_charge > 5000


/* Extension */

/* Q5 */

SELECT
    count(DISTINCT employee_id)
FROM employees_committees 

/* Q6 */

SELECT
    count(e.id)
FROM employees AS e LEFT JOIN employees_committees AS ec 
ON e.id = ec.employee_id 
WHERE ec.committee_id IS NULL








