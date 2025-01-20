SELECT * FROM bank_loan_data
--KPI requirements: Total loan applications
SELECT COUNT(id) AS Total_Loan_Applications FROM bank_loan_data

--Monitor MOnth to date Loan application
SELECT COUNT(id) AS MTD_Loan_Applications FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

--KPI REquirement:Total funded amount
SELECT SUM(loan_amount) AS Total_Funded_Amount From bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
--Previous Month:
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount From bank_loan_data 
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--Total Amount Recieved:
SELECT SUM(total_payment) AS Total_Amount_Recieved From bank_loan_data 

--Month to date
SELECT SUM(total_payment) AS MTD_Total_Amount_Recieved From bank_loan_data 
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

--Month to month
SELECT SUM(total_payment) AS PMTD_Total_Amount_Recieved From bank_loan_data 
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--average interest rate
SELECT ROUND(AVG(int_rate), 2) *100 AS Avg_Interest_Rate From bank_loan_data

--Month to date:
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--Average debt to income ratio:
SELECT ROUND(AVG(dti), 4) * 100 AS Avg_DTI FROM bank_loan_data

--LOAN STATUS
--SELECT loan_status FROM bank_loan_data

--Good loan percentage
SELECT 
(COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END)* 100)
/
COUNT (id) AS Good_loan_percentage
FROM bank_loan_data

--Good Loan Application:
SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan_data 
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--Good Loan Funded amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount FROM bank_loan_data 
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--Good Loan TOTAL AMOUNT RECIEVED
SELECT SUM(total_payment) AS Good_Loan_Recieved_Amount FROM bank_loan_data 
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--BAD LOAN

--BAD loan percentage
SELECT 
(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END)* 100)
/
COUNT (id) AS Bad_loan_percentage
FROM bank_loan_data

--BAD Loan Application:
SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan_data 
WHERE loan_status = 'Charged Off'

--Bad Loan Funded amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount FROM bank_loan_data 
WHERE loan_status = 'Charged Off'

--Good Loan TOTAL AMOUNT RECIEVED
SELECT SUM(total_payment) AS Bad_Loan_Recieved_Amount FROM bank_loan_data 
WHERE loan_status = 'Charged Off'

--Loan status:

SELECT loan_status,
COUNT(id) AS Total_Loan_applications,
SUM(total_payment) AS Total_Amount_Recieved,
SUM(loan_amount) AS Total_Funded_Amount,
AVG(int_rate * 100) AS Interest_Rate,
AVG(dti * 100) AS DTI
FROM
Bank_loan_data
GROUP BY
loan_status

--MTD
SELECT loan_status,
SUM(total_payment) AS MTD_Total_Amount_Recieved,
SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM
Bank_loan_data
WHERE MONTH(issue_date) = 12
GROUP BY
loan_status

--Charts
--Monthly Trends by issue date 
SELECT 
MONTH(issue_date) AS Month_Number,
DATENAME(MONTH, issue_date) AS Month_Name,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amont,
SUM(total_payment) AS Total_Recieved_Amount
FROM
Bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH (issue_date)

--Regional Analysis by State 
SELECT address_state,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amont,
SUM(total_payment) AS Total_Recieved_Amount
FROM
Bank_loan_data
GROUP BY address_state
ORDER BY COUNT(id) DESC

--Loan Term Analysis
SELECT term,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amont,
SUM(total_payment) AS Total_Recieved_Amount
FROM
Bank_loan_data
GROUP BY term
ORDER BY term

--Employee length Analysis 
SELECT emp_length,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amont,
SUM(total_payment) AS Total_Recieved_Amount
FROM
Bank_loan_data
GROUP BY emp_length
ORDER BY emp_length

--Loan Purpose Breakdown 

SELECT purpose,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amont,
SUM(total_payment) AS Total_Recieved_Amount
FROM
Bank_loan_data
GROUP BY purpose
ORDER BY COUNT(id)DESC

--Home Ownership analysis 

SELECT home_ownership,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amont,
SUM(total_payment) AS Total_Recieved_Amount
FROM
Bank_loan_data
GROUP BY home_ownership
ORDER BY COUNT(id)DESC