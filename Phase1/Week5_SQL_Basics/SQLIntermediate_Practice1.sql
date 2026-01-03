--SELECT user_id, name
--FROM SQL_Tutorial.dbo.users

--SELECT COUNT(order_id) as Total_Number_of_Orders
--FROM SQL_Tutorial.dbo.orders2

--SELECT SUM(amount) as Total_amount
--FROM SQL_Tutorial.dbo.orders2

--SELECT user_id, COUNT(order_id) AS total_orders
--FROM SQL_Tutorial.dbo.orders2
--GROUP BY user_id
--HAVING COUNT(order_id) > 2
--ORDER BY user_id

--SELECT u.user_id,name, SUM(amount) AS Total_spending_ph
--FROM SQL_Tutorial.dbo.orders2 o
--JOIN SQL_Tutorial.dbo.users u
-- ON o.user_id = u.user_id
--GROUP BY u.user_id, name
--ORDER BY SUM(amount) DESC


