-- Schemato be created

-- Savings Account Table
CREATE TABLE savings_accounts (
  account_id NUMBER PRIMARY KEY,
  customer_id NUMBER,
  balance NUMBER(12,2)
);

-- Employees Table
CREATE TABLE employees (
  emp_id NUMBER PRIMARY KEY,
  name VARCHAR2(100),
  department_id NUMBER,
  salary NUMBER(10,2)
);

-- Accounts Table 
CREATE TABLE accounts (
  account_id NUMBER PRIMARY KEY,
  customer_id NUMBER,
  balance NUMBER(12,2)
);

-- Inserting the values 
INSERT INTO savings_accounts VALUES (201, 1, 10000.00);
INSERT INTO savings_accounts VALUES (202, 2, 5000.00);
INSERT INTO savings_accounts VALUES (203, 3, 20000.00);

INSERT INTO employees VALUES (301, 'Harish', 101, 50000.00);
INSERT INTO employees VALUES (302, 'Sharon', 102, 45000.00);
INSERT INTO employees VALUES (303, 'Gopi', 101, 55000.00);
INSERT INTO employees VALUES (304, 'deepak', 103, 60000.00);

INSERT INTO accounts VALUES (401, 1, 12000.00); 
INSERT INTO accounts VALUES (402, 2, 8000.00);  
INSERT INTO accounts VALUES (403, 3, 500.00);   


-- Scenario 1: ProcessMonthlyInterest – Add 1% to All Savings Accounts
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
  v_new_balance NUMBER(12,2);
BEGIN
  FOR rec IN (SELECT account_id, balance FROM savings_accounts) LOOP
    v_new_balance := rec.balance + (rec.balance * 0.01);

    UPDATE savings_accounts
    SET balance = v_new_balance
    WHERE account_id = rec.account_id;

    DBMS_OUTPUT.PUT_LINE(' Interest applied to Account ID: ' || rec.account_id ||
                         ' | New Balance: ' || TO_CHAR(v_new_balance, '999,999.99'));
  END LOOP;

  COMMIT;
END;
/

-- Execute the procedure
BEGIN
  ProcessMonthlyInterest;
END;
/

-- Scenario 2: UpdateEmployeeBonus

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
  dept_id IN NUMBER,
  bonus_pct IN NUMBER
) IS
BEGIN
  FOR rec IN (SELECT emp_id, salary FROM employees WHERE department_id = dept_id) LOOP
    UPDATE employees
    SET salary = salary + (salary * bonus_pct)
    WHERE emp_id = rec.emp_id;

    DBMS_OUTPUT.PUT_LINE('Bonus applied to Employee ID: ' || rec.emp_id ||
                         ' | New Salary: ' || TO_CHAR(rec.salary + (rec.salary * bonus_pct)));
  END LOOP;

  COMMIT;
END;
/
EXEC UpdateEmployeeBonus(101, 0.10); 


-- Scenario 3: TransferFunds

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE TransferFunds (
  from_account_id IN NUMBER,
  to_account_id IN NUMBER,
  amount IN NUMBER
) IS
  insufficient_funds EXCEPTION;
  v_balance NUMBER;
BEGIN
  SELECT balance INTO v_balance FROM accounts WHERE account_id = from_account_id;

  IF v_balance < amount THEN
    RAISE insufficient_funds;
  END IF;

  UPDATE accounts SET balance = balance - amount WHERE account_id = from_account_id;
  UPDATE accounts SET balance = balance + amount WHERE account_id = to_account_id;

  COMMIT;

  DBMS_OUTPUT.PUT_LINE('Transferred ' || amount ||
                       ' from Account ' || from_account_id ||
                       ' to Account ' || to_account_id);
EXCEPTION
  WHEN insufficient_funds THEN
    DBMS_OUTPUT.PUT_LINE('Transfer failed: Insufficient funds in Account ' || from_account_id);
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END;
/
-- Successful
EXEC TransferFunds(401, 402, 2000);

-- Failure
EXEC TransferFunds(403, 402, 1000);




