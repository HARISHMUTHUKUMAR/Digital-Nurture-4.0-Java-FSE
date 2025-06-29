
/*Exercise 1: Control Structures

Scenario 1: The bank wants to apply a discount to loan interest rates for customers above 60 years old.
o	Question: Write a PL/SQL block that loops through all customers, checks their age, and if they are above 60, apply a 1% discount to their current loan interest rates.
Scenario 2: A customer can be promoted to VIP status based on their balance.
o	Question: Write a PL/SQL block that iterates through all customers and sets a flag IsVIP to TRUE for those with a balance over $10,000.
Scenario 3: The bank wants to send reminders to customers whose loans are due within the next 30 days.
o	Question: Write a PL/SQL block that fetches all loans due in the next 30 days and prints a reminder message for each customer.*/


-- Schema to be created

CREATE TABLE customers (
  customer_id        NUMBER PRIMARY KEY,
  name               VARCHAR2(100),
  age                NUMBER,
  loan_interest_rate NUMBER(5,2),
  balance            NUMBER(12,2),
  IsVIP              CHAR(1) DEFAULT 'N'  -- Y or N
);

CREATE TABLE loans (
  loan_id     NUMBER PRIMARY KEY,
  customer_id NUMBER,
  due_date    DATE,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Inserting the values

INSERT INTO customers VALUES (1, 'Harish', 65, 8.5, 45000, 'N');
INSERT INTO customers VALUES (2, 'Gopi', 45, 9.0, 9000, 'N');
INSERT INTO customers VALUES (3, 'Sharon', 70, 7.8, 20000, 'N');
INSERT INTO customers VALUES (4, 'Deepak', 30, 10.2, 5000, 'N');


INSERT INTO loans VALUES (101, 1, SYSDATE + 15);
INSERT INTO loans VALUES (102, 2, SYSDATE + 45); 
INSERT INTO loans VALUES (103, 3, SYSDATE + 10);
INSERT INTO loans VALUES (104, 4, SYSDATE + 5);  

COMMIT;

-- Scenario 1: Apply 1% Interest Discount for Customers Over 60

SET SERVEROUTPUT ON;

DECLARE
  v_new_rate NUMBER(5,2);
BEGIN
  FOR rec IN (
    SELECT customer_id, name, loan_interest_rate
    FROM customers
    WHERE age > 60
  ) LOOP
    v_new_rate := rec.loan_interest_rate - (rec.loan_interest_rate * 0.01);

    UPDATE customers
    SET loan_interest_rate = v_new_rate
    WHERE customer_id = rec.customer_id;

    DBMS_OUTPUT.PUT_LINE('Updated ' || rec.name || 
                         ' (Customer ID: ' || rec.customer_id || 
                         ') to new rate: ' || TO_CHAR(v_new_rate));
  END LOOP;

  COMMIT;
END;

-- Scenario 2: Promote to VIP if Balance > $10,000

SET SERVEROUTPUT ON;

BEGIN
  FOR rec IN (
    SELECT customer_id, name, balance
    FROM customers
    WHERE balance > 10000
  ) LOOP
    UPDATE customers
    SET IsVIP = 'Y'
    WHERE customer_id = rec.customer_id;

    DBMS_OUTPUT.PUT_LINE('Promoted ' || rec.name || 
                         ' (Customer ID: ' || rec.customer_id || 
                         ') to VIP. Balance: $' || TO_CHAR(rec.balance));
  END LOOP;

  COMMIT;
END;

-- Scenario 3: Reminders for Loans Due in Next 30 Days

SET SERVEROUTPUT ON;

DECLARE
  CURSOR due_soon_loans IS
    SELECT l.loan_id, c.name, l.due_date
    FROM loans l
    JOIN customers c ON l.customer_id = c.customer_id
    WHERE l.due_date BETWEEN SYSDATE AND SYSDATE + 30;
BEGIN
  FOR rec IN due_soon_loans LOOP
    DBMS_OUTPUT.PUT_LINE('Reminder: Loan ID ' || rec.loan_id ||
                         ' for customer ' || rec.name ||
                         ' is due on ' || TO_CHAR(rec.due_date, 'DD-MON-YYYY'));
  END LOOP;
END;


