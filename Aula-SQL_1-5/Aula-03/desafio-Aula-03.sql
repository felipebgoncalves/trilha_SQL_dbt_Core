-- 1. Cria um relatório para todos os pedidos de 1996 e seus clientes (152 linhas)
SELECT *
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE EXTRACT(YEAR FROM o.order_date) = 1996;

-- 2. Cria um relatório que mostra o número de funcionários e clientes de cada cidade que tem funcionários (5 linhas)
SELECT e.city AS cidade,
       COUNT(DISTINCT e.employee_id) AS número_de_funcionários,
       COUNT(DISTINCT c.customer_id) AS número_de_clientes
FROM employees e
LEFT JOIN customers c ON e.city = c.city
GROUP BY e.city
ORDER BY cidade;

-- 3. Cria um relatório que mostra o número de funcionários e clientes de cada cidade que tem clientes (69 linhas)
SELECT c.city AS cidade,
       COUNT(DISTINCT c.customer_id) AS número_de_clientes,
       COUNT(DISTINCT e.employee_id) AS número_de_funcionários
FROM employees e
RIGHT JOIN customers c ON e.city = c.city
GROUP BY c.city;

-- 4.Cria um relatório que mostra o número de funcionários e clientes de cada cidade (71 linhas)
SELECT COALESCE(e.city, c.city) AS cidade,
       COUNT(DISTINCT e.employee_id) AS número_de_funcionários,
       COUNT(DISTINCT c.customer_id) AS número_de_clientes
FROM employees e
FULL JOIN customers c ON e.city = c.city
GROUP BY COALESCE(e.city, c.city);

-- 5. Cria um relatório que mostra a quantidade total de produtos encomendados.
-- Mostra apenas registros para produtos para os quais a quantidade encomendada é menor que 200 (5 linhas)
SELECT p.product_name,
       SUM(od.quantity) AS quantidade_total_encomendada
FROM products p
JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.product_name
HAVING SUM(od.quantity) < 200;

-- 6. Cria um relatório que mostra o total de pedidos por cliente desde 31 de dezembro de 1996.
-- O relatório deve retornar apenas linhas para as quais o total de pedidos é maior que 15 (5 linhas)