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

