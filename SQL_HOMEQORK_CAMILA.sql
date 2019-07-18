-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/

CREATE TABLE titles (
    id SERIAL PRIMARY KEY,
    emp_no INTEGER   NOT NULL,
    title VARCHAR   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL
);

CREATE TABLE salaries (
    emp_no INTEGER  PRIMARY KEY NOT NULL,
    salary INTEGER   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL
);

CREATE TABLE employees (
    emp_no INTEGER  PRIMARY KEY NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    gender VARCHAR   NOT NULL,
    hire_date DATE   NOT NULL
);

    CREATE TABLE dept_manager (
        id SERIAL PRIMARY KEY,
        dept_no VARCHAR   NOT NULL,
        emp_no INTEGER   NOT NULL,
        from_date DATE   NOT NULL,
        to_date DATE   NOT NULL
    );

CREATE TABLE dept_emp (
    id SERIAL PRIMARY KEY,
    emp_no INTEGER   NOT NULL,
    dept_no VARCHAR   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL
);

CREATE TABLE departments (
    dept_no VARCHAR PRIMARY KEY   NOT NULL,
    dept_name VARCHAR   NOT NULL
);

ALTER TABLE titles ADD CONSTRAINT fk_titles_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE salaries ADD CONSTRAINT fk_salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

-- Queries:

--List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary 
FROM employees as e
JOIN salaries as s
ON e.emp_no = s.emp_no

--List employees who were hired in 1986.
SELECT emp_no, last_name, first_name
FROM employees
WHERE hire_date BETWEEN '01/01/1986' AND '12/31/1986'

--List the manager of each department with the following information: department number, department name,
-- the manager's employee number, last name, first name, and start and end employment dates.

SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name,e.first_name, dm.from_date,dm.to_date
FROM dept_manager AS dm
LEFT JOIN employees AS e
ON dm.emp_no = e.emp_no
JOIN departments AS d 
ON dm.dept_no = d.dept_no;

--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.

SELECT de.emp_no, e.last_name,e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de
ON e.emp_no = de.emp_no
JOIN departments AS d 
ON de.dept_no = d.dept_no;

--List all employees whose
--first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name
FROM employees
WHERE first_name ='Hercules' AND last_name LIKE 'B%'

--List all employees in the Sales department, including their
--employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de
ON e.emp_no = de.emp_no
JOIN departments AS d
ON de.dept_no = d.dept_no 
WHERE d.dept_name ='Sales'
 

-- List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de
ON e.emp_no = de.emp_no
JOIN departments AS d
ON de.dept_no = d.dept_no 
WHERE d.dept_name IN ('Sales', 'Development')
 

-- In descending order, list the frequency count of employee last names, i.e.,
--  how many employees share each last name.

SELECT last_name, COUNT(*) FROM employees
GROUP BY last_name
ORDER BY COUNT(*) DESC

-- BONUS:

SELECT * FROM employees
WHERE emp_no = '499942'