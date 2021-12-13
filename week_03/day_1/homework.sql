/* MVP */
/* Q1 */

SELECT *
FROM employees e 
WHERE department = 'Human Resources';


/* Q2 */

SELECT 
    first_name, 
    last_name, 
    country
FROM employees e 
WHERE department = 'Legal';

/* Q3 */

SELECT 
    count(id)
FROM employees e 
WHERE country = 'Portugal';

/* Q4 */

SELECT 
    count(id)
FROM employees e 
WHERE country IN ('Portugal', 'Spain');

/* Q5 */

SELECT 
    count(id)
FROM pay_details pd 
WHERE local_account_no IS NULL;

/* Q6 */

SELECT 
    count(id)
FROM pay_details pd 
WHERE local_account_no IS NULL AND iban IS NULL;

/* Q7 */

SELECT
    first_name,
    last_name
FROM employees e 
ORDER BY last_name ASC NULLS LAST;

/* Q8 */

SELECT 
    first_name,
    last_name,
    country
FROM employees e 
ORDER BY country ASC NULLS LAST, last_name ASC NULLS LAST;

/* Q9 */

SELECT *
FROM employees e 
ORDER BY salary DESC NULLS LAST
LIMIT 10;

/* Q10 */

SELECT 
    first_name,
    last_name,
    salary
FROM employees e 
WHERE country = 'Hungary'
ORDER BY salary ASC NULLS LAST;

/* Q11 */

SELECT 
    count(id)
FROM employees e 
WHERE first_name ~* '^F'

/* Q12 */

SELECT *
FROM employees e 
WHERE email ILIKE '%@yahoo%';

/* Q13 */

SELECT 
    count(id)
FROM employees e 
WHERE pension_enrol = TRUE AND country NOT IN ('France', 'Germany');

/* Q14 */

SELECT 
    max(salary)
FROM employees e 
WHERE department = 'Engineering' AND fte_hours = 1;

/* Q15 */

SELECT 
    first_name,
    last_name,
    fte_hours,
    salary,
    fte_hours * salary AS effective_yearly_salary
FROM employees e;

/* Extension */

/* Q16 */

SELECT 
    concat(first_name, ' ', last_name, ' - ', department) AS badge_label
FROM employees e
WHERE first_name IS NOT NULL AND last_name IS NOT NULL AND department IS NOT NULL;

/* Q17 */

SELECT
    concat(first_name, ' ',
           last_name, ' - ',
           department, ' (joined ',
           TO_CHAR(start_date, 'TMMonth'), ' ',
           EXTRACT(YEAR FROM start_date), ')')
           AS badge_label
FROM employees e
WHERE
      first_name IS NOT NULL AND last_name IS NOT NULL AND 
      department IS NOT NULL AND start_date IS NOT null;
  
  /* Q18 */
  
SELECT 
    first_name,
    last_name, 
    salary,
    CASE 
        WHEN salary < 40000 THEN 'Low'
        WHEN salary >= 40000 THEN 'High'
        WHEN salary IS NULL THEN 'Unknown'
    END AS salary_class
FROM employees e 


