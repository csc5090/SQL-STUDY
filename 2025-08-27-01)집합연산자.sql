2025-08-27-01)���տ�����

   - UNION, UNION ALL, INTERSECT, MINUS �� ������.
   . SELECT ���� �÷��� ����, �������, �ڷ�Ÿ���� �����ؾ���.
    (�÷��� ���� ���� ������ ���� �ٸ� �����ͷ� ���ֵ�)
    .ORDER BY ���� �� ������ SELECT ������ ��� ����
    .�÷��� ��Ī�� ù ��° SELECT���� ���� �����
    
1. UNION / UNION ALL
   - �������� ����� ��ȯ
   - �ߺ� ����(UNION), �ߺ� ���(UNION ALL)
   - ���� �ٸ� ������ ���̺��� �ϳ��� �����Ͽ� ��ȯ
   
��뿹) 2020�� 6���� ���Ե� ��ǰ�� 7�� ���Ե� ��� ��ǰ�� ��ȸ�Ͻÿ�.
        AS�� ��ǰ�ڵ�, ��ǰ��, ���Դܰ�, ���԰ŷ�ó��
        
SELECT A.PROD_ID AS ��ǰ�ڵ�,
       B.PROD_NAME AS ��ǰ��,
       B.PROD_COST AS ���Դܰ�,
       C.BUYER_NAME AS ���԰ŷ�ó��
FROM BUYPROD A
INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
INNER JOIN BUYER C ON(B.BUYER_ID=C.BUYER_ID)
WHERE A.BUY_DATE BETWEEN TO_DATE('20200201') AND LAST_DAY(TO_DATE('20200201'))
ORDER BY 1;
UNION 
SELECT A.PROD_ID,
       B.PROD_NAME,
       B.PROD_COST,
       C. BUYER_NAME
FROM BUYPROD A
INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
INNER JOIN BUYER C ON(B.BUYER_ID=C.BUYER_ID)
WHERE A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')
ORDER BY 1;

SELECT PERIOD AS �Ⱓ,
       SUM(BUDGET_AMT) AS ��ǥġ,
       SUM(SALE_AMT) AS ����,
       ROUND(SUM(SALE_AMT)/SUM(BUDGET_AMT)*100) ||'%' AS �޼���
  FROM (SELECT PERIOD,
                BUDGET_AMT,
                0 AS "SALE_AMT"
                FROM BUDGET
                UNION ALL
                SELECT PERIOD,0,SALE_AMT
                FROM SALES
                ORDER BY 1)
GROUP BY PERIOD;


SELECT PERIOD AS �Ⱓ,
       BUDGET_AMT AS ��ȹ,
       0 AS ����
FROM BUDGET
UNION ALL
SELECT PERIOD, 0, SALE_AMT
FROM SALES
ORDER BY 1;



2. INTERSECT
  - �������� ����� ��ȯ
  - EXISTS �����ڷ� ���� ����
  
��뿹) 2020�� 4���� �Ǹŵ� ��ǰ�� 2020�� 6���� �Ǹŵ� ��ǰ �� �� �� ���
       �Ǹŵ� ��ǰ�� ��ǰ��ȣ, ��ǰ���� ��ȸ�ϱ�
(2020�� 4���� �Ǹŵ� ��ǰ)

SELECT DISTINCT(A.PROD_ID) AS ��ǰ��ȣ,
       B.PROD_NAME AS ��ǰ��
FROM CART A, PROD B
WHERE A.PROD_ID=B.PROD_ID
AND   A.CART_NO LIKE '202004%'
INTERSECT
SELECT DISTINCT(A.PROD_ID) AS ��ǰ��ȣ,
       B.PROD_NAME AS ��ǰ��
FROM CART A, PROD B
WHERE A.PROD_ID=B.PROD_ID
AND   A.CART_NO LIKE '202006%'
ORDER BY 1;

EXISTS))
SELECT DISTINCT(A.PROD_ID) AS ��ǰ��ȣ,
       B.PROD_NAME AS ��ǰ��
FROM CART A, PROD B
WHERE A.PROD_ID=B.PROD_ID
AND   A.CART_NO LIKE '202004%'
AND EXISTS(SELECT DISTINCT A.PROD_ID, B.PROD_NAME
             FROM CART C
            WHERE A.PROD_ID=C.PROD_ID
              AND C.CART_NO LIKE '202006%')
         ORDER BY 1;


3. MINUS
  - �������� ����� ��ȯ
  - ������ ���ʿ� ��� ������ ����ϴ��Ŀ� ���� ����� �޶���.
  - NOT EXISTS �� ������ ����.
  
SELECT DISTINCT(A.PROD_ID) AS ��ǰ��ȣ,
               B.PROD_NAME AS ��ǰ��
FROM CART A, PROD B
WHERE A.PROD_ID=B.PROD_ID
AND   A.CART_NO LIKE '202006%'
MINUS
SELECT DISTINCT(A.PROD_ID) AS ��ǰ��ȣ,
       B.PROD_NAME AS ��ǰ��
FROM CART A, PROD B
WHERE A.PROD_ID=B.PROD_ID
AND   A.CART_NO LIKE '202004%'
ORDER BY 1;