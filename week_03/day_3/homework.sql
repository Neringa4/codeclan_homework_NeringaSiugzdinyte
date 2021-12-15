-- MVP

-- Q1

SELECT 
    count(id) num_employees
FROM employees
WHERE grade IS NULL AND salary IS NULL;

-- Q2

SELECT 
    department,
    concat(first_name, ' ', last_name) AS full_name
FROM employees 
ORDER BY department, last_name;

-- Q3

SELECT *
FROM employees
WHERE last_name ILIKE 'A%'
ORDER BY salary DESC NULLS LAST
LIMIT 10;

-- Q4

SELECT 
    department,
    count(id) AS num_employees_2003
FROM employees
WHERE start_date BETWEEN '2003-01-01' AND '2003-12-31'
GROUP BY department;

-- Q5

SELECT 
    department,
    fte_hours,
    count(id) AS num_employees
FROM employees
GROUP BY department, fte_hours 
ORDER BY department, fte_hours; 

-- Q6

SELECT 
    pension_enrol,
    count(id) AS num_employees
FROM employees
GROUP BY pension_enrol;

-- Q7

SELECT *
FROM employees
WHERE department = 'Accounting' AND pension_enrol IS FALSE 
ORDER BY salary DESC NULLS LAST
LIMIT 1;

-- Q8

SELECT 
    country,
    count(id) AS num_employees,
    round(avg(salary), 2) AS avg_salary
FROM employees 
GROUP BY country
HAVING count(id) > 30
ORDER BY avg(salary) DESC;

-- Q9

SELECT 
    first_name,
    last_name,
    fte_hours, 
    salary,
    fte_hours * salary AS effective_yearly_salary
FROM employees
WHERE (fte_hours * salary) > 30000;

-- Q10

SELECT
    e.*,
    t.name AS team_name
FROM employees AS e INNER JOIN teams AS t 
ON e.team_id = t.id
WHERE t.name IN ('Data Team 1', 'Data Team 2');

-- Q11

SELECT 
    e.first_name,
    e.last_name,
    pd.local_tax_code
FROM employees AS e LEFT JOIN pay_details AS pd 
ON e.pay_detail_id = pd.id 
WHERE pd.local_tax_code IS NULL;

-- Q12

SELECT 
    e.*,
    (48 * 35 * CAST(charge_cost AS INT) - salary) * fte_hours
    AS expected_profit
FROM employees AS e LEFT JOIN teams AS t 
ON e.team_id = t.id;

-- Q13

SELECT 
    first_name,
    last_name,
    salary
FROM employees 
WHERE country = 'Japan' AND fte_hours = (SELECT 
                                            fte_hours
                                         FROM employees 
                                         GROUP BY fte_hours 
                                         ORDER BY count(id) ASC
                                         LIMIT 1)
ORDER BY salary ASC 
LIMIT 1;

-- Q14

SELECT 
    department,
    count(id) AS num_employees
FROM employees 
WHERE first_name IS NULL
GROUP BY department
HAVING count(id) >= 2
ORDER BY count(id) DESC, department ASC;

-- Q15 

SELECT 
    first_name,
    count(id) AS num_employees
FROM employees 
WHERE first_name IS NOT NULL
GROUP BY first_name
HAVING count(id) > 1
ORDER BY count(id) DESC, first_name ASC;

-- Q16

SELECT 
    department, 
    CAST(SUM(CAST(grade = 1 AS INT)) AS REAL) / COUNT(id) AS proportion_in_grade_1
FROM employees 
GROUP BY department

-- EXTENSION 

-- Q1

SELECT 
    id,
    first_name,
    last_name,
    department,
    salary,
    fte_hours,
    salary / AVG(salary) OVER (PARTITION BY department) AS salary_raito,
    fte_hours / AVG(fte_hours) OVER (PARTITION BY department) AS fte_hours_ratio
FROM employees 
WHERE department = (SELECT 
                        department
                    FROM employees 
                    GROUP BY department 
                    ORDER BY count(id) DESC
                    LIMIT 1);
                
-- Q2
                
SELECT 
    COALESCE(CAST(pension_enrol AS VARCHAR), 'unknown') AS enrolled_in_pension,
    count(id) AS num_employees
FROM employees
GROUP BY pension_enrol;

-- Q3

SELECT 
    e.first_name,
    e.last_name,
    e.email,
    e.start_date,
    c."name" AS comittee_name
FROM (employees AS e INNER JOIN employees_committees AS ec 
ON e.id = ec.employee_id) 
INNER JOIN committees AS c ON ec.committee_id = c.id 
WHERE c.name = 'Equality and Diversity'
ORDER BY start_date ASC NULLS LAST;

-- Q4

SELECT 
    count(e.id),
CASE 
    WHEN salary < 40000 THEN 'low'
    WHEN salary >= 40000 THEN 'high'
    ELSE 'none'
END AS salary_class
FROM employees AS e INNER JOIN employees_committees AS ec 
ON e.id = ec.employee_id
GROUP BY salary_class;










