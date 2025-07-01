use librarydb;

SELECT title
FROM Books
WHERE category_id = (
  SELECT category_id FROM Categories WHERE name = 'Science'
);


SELECT member_id, COUNT(*) AS loan_count
FROM Loans
GROUP BY member_id
HAVING COUNT(*) > (
  SELECT AVG(cnt) FROM (
    SELECT COUNT(*) AS cnt FROM Loans GROUP BY member_id
  ) AS avg_table
);




SELECT DISTINCT name
FROM Authors a
WHERE EXISTS (
  SELECT 1
  FROM Book_Author ba
  WHERE ba.author_id = a.author_id
  GROUP BY ba.author_id
  HAVING COUNT(*) > 1
);


SELECT title, loan_count
FROM (
  SELECT b.title, COUNT(*) AS loan_count
  FROM Books b
  JOIN Loans l ON b.book_id = l.book_id
  GROUP BY b.book_id
) AS book_loans
ORDER BY loan_count DESC
LIMIT 1;


SELECT m.name,
  (SELECT COUNT(*) FROM Loans l WHERE l.member_id = m.member_id) AS total_loans
FROM Members m;
