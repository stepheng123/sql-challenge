-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/ZjiGnk
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.
CREATE TABLE "salaries" (
    "employee_no" int   NOT NULL,
    "salary" int   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" varchar   NOT NULL,
    "title" varchar   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "employees" (
    "employee_no" int   NOT NULL,
    "employee_title_id" varchar   NOT NULL,
    "birth_date" varchar   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "sex" varchar   NOT NULL,
    "hire_date" varchar   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "employee_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar   NOT NULL,
    "employee_no" int   NOT NULL
);

CREATE TABLE "dept_emp" (
    "employee_no" int   NOT NULL,
    "dept_no" varchar   NOT NULL
);

CREATE TABLE "departments" (
    "dept_no" varchar   NOT NULL,
    "dept_name" varchar   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_employee_no" FOREIGN KEY("employee_no")
REFERENCES "employees" ("employee_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_employee_title_id" FOREIGN KEY("employee_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_employee_no" FOREIGN KEY("employee_no")
REFERENCES "employees" ("employee_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_employee_no" FOREIGN KEY("employee_no")
REFERENCES "employees" ("employee_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

--1. List the following details of each employee: employee number, last name, first name, sex, and salary
select employees.employee_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM salaries
INNER JOIN employees ON 
employees.employee_no = salaries.employee_no;

--2. List first name, last name, and hire date for employees who were hired in 1986.
select * from employees;
SELECT first_name, last_name, hire_date 
FROM employees
WHERE YEAR(hire_date) = '%1986'

--3. List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name.

SELECT dept_manager.dept_no, departments.dept_name, employees.employee_no, employees.last_name, employees.first_name 
FROM dept_manager 
INNER JOIN employees
ON employees.employee_no = dept_manager.employee_no
INNER JOIN departments 
ON dept_manager.dept_no = departments.dept_no;

--4. List the department of each employee with the following information: 
--employee number, last name, first name, and department name

SELECT employees.employee_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees INNER JOIN dept_emp
ON employees.employee_no = dept_emp.employee_no
INNER JOIN departments 
ON dept_emp.dept_no = departments.dept_no;

--5. List first name, last name, and sex for employees 
--whose first name is "Hercules" and last names begin with "B."
SELECT employees.first_name, employees.last_name, employees.sex FROM employees
WHERE first_name LIKE 'Hercules' 
AND last_name LIKE 'B%';

--6. List all employees in the Sales department, 
--including their employee number, last name, first name, and department name.
SELECT dept_emp.employee_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.employee_no = employees.employee_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

--7. List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
SELECT dept_emp.employee_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.employee_no = employees.employee_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales'
OR departments.dept_name = 'Development';

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name AS "LAST NAME",
COUNT(last_name) AS "FREQUENCY COUNT OF LAST NAMES"
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;