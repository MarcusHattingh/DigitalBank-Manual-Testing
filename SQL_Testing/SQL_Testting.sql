-- 1. Get full user profile info with linked account numbers
SELECT u.user_id, u.full_name, u.email, a.account_id, a.account_type
FROM users u
JOIN accounts a ON u.user_id = a.user_id;

-- 2. Find all transactions over R1000 for checking accounts
SELECT t.transaction_id, t.account_id, t.amount, t.type, t.date
FROM transactions t
JOIN accounts a ON t.account_id = a.account_id
WHERE a.account_type = 'Checking' AND t.amount > 1000;

-- 3. Identify accounts that have gone into negative balance
SELECT account_id, balance
FROM accounts
WHERE balance < 0;

-- 4. Count number of transactions per account (descending)
SELECT account_id, COUNT(*) AS transaction_count
FROM transactions
GROUP BY account_id
ORDER BY transaction_count DESC;

-- 5. Show total transferred amount (outgoing) by user in July 2025
SELECT u.full_name, SUM(t.amount) AS total_outgoing
FROM transactions t
JOIN accounts a ON t.account_id = a.account_id
JOIN users u ON a.user_id = u.user_id
WHERE t.type = 'Transfer Out'
  AND t.date BETWEEN '2025-07-01' AND '2025-07-31'
GROUP BY u.full_name
ORDER BY total_outgoing DESC;

-- 6. List all transactions where the amount field was entered as negative
SELECT *
FROM transactions
WHERE amount < 0;

-- 7. Retrieve the 5 most recent transactions for a specific account
SELECT *
FROM transactions
WHERE account_id = 2002
ORDER BY date DESC
LIMIT 5;
