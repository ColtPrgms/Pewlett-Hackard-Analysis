--All Titles
--BETWEEN '1952-01-01' AND '1955-12-31'
--DISTINCT ON *most recent title*
--COUNT *Number if retirement age employees*
--EXCLUDE employees who left already

SELECT * FROM employees;

SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees AS e
	LEFT OUTER JOIN title AS t
		ON (e.emp_no = t.emp_no)
	WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	ORDER BY e.emp_no;
	
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles AS rt
	WHERE (rt.to_date = '9999-01-01')
	ORDER BY rt.emp_no, rt.to_date DESC;

SELECT COUNT (ut.title), ut.title
INTO retiring_title
FROM unique_titles AS ut
	GROUP BY ut.title
	ORDER BY count DESC;

SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees AS e
	LEFT OUTER JOIN dept_emp AS de
		ON (e.emp_no = de.emp_no)
	LEFT OUTER JOIN title AS t
		ON (e.emp_no = t.emp_no)
	WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	ORDER BY e.emp_no;