2025-0818-02) �����Լ�
 - SUM, AVG, COUNT, MAX, MIN
 - �׷��� ������ �׷캰�� ������ ����� ��ȯ
 - �׷��Լ��� �׷��Լ��� ������ �� ����(��, �Ϲ��Լ��� �׷��Լ��� ������ �� �ְ�, �ݴ��
   �׷��Լ��� �Ϲ��Լ��� ������ �� �ִ�)
   
�������)
    SELECT [�÷�,...,]
            SUM(col| expr) | AVG(col| expr) | COUNT(*| expr) | MAX(col| expr) | MIN(col| expr)
    FROM ���̺��
    
    [WHERE ����]
    
    [GROUP BY �÷���[,�÷���,....]
    [HAVING ���� ]
    [ORDER BY �÷��� | �÷��ε���[ASC | DESC] [,�÷���|�÷��ε���[ASC | DESC],...]];
    
    SELECT ���� �����Լ��� ���� ��� GROUP BY�� ����(���̺���ü�� �ϳ��� �׷�)
    SELECT ���� �����Լ��� �ƴ� �Ϲ��÷��� ����ǰ� ���� �Լ��� ���Ǹ� �ݵ�� GROUP BY���� ����Ǿ�� �ϸ�
    SELECT ���� ���� �Ϲ��÷��� GROUP BY ���� ��� ����ؾ���
    
    �����Լ��� ������ �ο��Ǵ� ��� HAVING���� ����ؾ���
    
��뿹)
    1) ȸ�����̺��� ��� ȸ������ ���ϸ��� �հ��, ��ո��ϸ���, �ο���, �ִ븶�ϸ���, �ּҸ��ϸ����� ���Ͻÿ�
    
    SELECT SUM(MEM_MILEAGE) AS ���ϸ����հ�,
           TRUNC(AVG(MEM_MILEAGE),0) AS ��ո��ϸ���,
           COUNT(*) AS �ο���,
           MAX(MEM_MILEAGE) AS �ִ븶�ϸ���,
           MIN(MEM_MILEAGE) AS �ּҸ��ϸ���
    FROM MEMBER;
    
    2) ��ǰ���̺��� ��ǰ�� ��, �ִ��ǸŰ�, �ּ� �ǸŰ��� ���Ͻÿ�.
    
    SELECT 
       COUNT(*) AS ��ǰ�Ǽ�,         
       MAX(PROD_PRICE) AS �ִ��ǸŰ�,
       MIN(PROD_PRICE) AS �ּ��ǸŰ� 
    FROM PROD;
    
    3) 2020�� 4�� �Ǹż��� �հ踦 ���Ͻÿ�.
    
    SELECT
        SUM(CART_QTY) AS "�Ǹż��� �հ�"
      FROM CART
     WHERE CART_NO LIKE '202004%';
     
    4) ��ǰ���̺��� �з��� ��ǰ�Ǽ��� ,����ǸŰ�, �ִ��ǸŰ�, �ּ��ǸŰ� ��ȸ�Ͻÿ�.
    
    SELECT LPROD_GU AS �з��ڵ�,
           COUNT(*) AS ��ǰ�Ǽ�,
           TRUNC(AVG(PROD_PRICE)) AS ����ǸŰ�,
           MAX(PROD_PRICE) AS �ִ��ǸŰ�,
           MIN(PROD_PRICE) AS �ּ��ǸŰ�
    FROM PROD
    GROUP BY LPROD_GU
    ORDER BY 1;
    
    5) ������̺��� �μ��� ��ձ޿��� �ο����� ��ȸ�Ͻÿ�.
    
    SELECT DEPARTMENT_ID AS �μ�,
           TRUNC(AVG(SALARY)) AS ��ձ޿�,
           COUNT(*) AS �ο���
    FROM C##HR.EMPLOYEES
    GROUP BY DEPARTMENT_ID
    ORDER BY 1;
    
    6) ��ǰ���̺��� �з��� ��ǰ�� �� ��� �ǸŰ��� ��ȸ�ϵ� ��ǰ�Ǽ��� 10���� �̻��� �з��� ��ȸ�Ͻÿ�.
    
    SELECT LPROD_GU AS �з��ڵ�,
        COUNT(*) AS ��ǰ�Ǽ�,
        TRUNC(AVG(PROD_PRICE)) AS ����ǸŰ�,
        MAX(PROD_PRICE) AS �ִ��ǸŰ�,
        MIN(PROD_PRICE) AS �ּ��ǸŰ�
    FROM PROD
    GROUP BY LPROD_GU
    HAVING COUNT(*) >= 10
    ORDER BY 1;
    
7)���� ���̺��� 2020�� ���� ���Լ����հ踦 ��ȸ�Ͻÿ�.
    SELECT
        EXTRACT(MONTH FROM BUY_DATE) AS ��,
        SUM(BUY_QTY) AS ���Լ����հ�
      FROM BUYPROD
    WHERE EXTRACT(YEAR FROM BUY_DATE) = 2020
    GROUP BY EXTRACT(MONTH FROM BUY_DATE)
    ORDER BY 1;
8)���� ���̺��� 2020�� ��ǰ�� ���Լ��� �հ踦 ��ȸ�Ͻÿ�.

    SELECT
        PROD_ID AS ��ǰ��,
        SUM(BUY_QTY) AS ���Լ����հ�
    FROM BUYPROD
    WHERE EXTRACT(YEAR FROM BUY_DATE) = 2020
    GROUP BY PROD_ID
    ORDER BY 1;
8-1) �������̺��� 2020�� ��ǰ�� ���Լ��� �հ踦 ��ȸ�ϵ� ���Լ��� �հ谡 100�� �̻��� ��ǰ�� ��ǰ��ȣ ��ǰ�� ���Լ����հ踦 ����Ͻÿ�.
    
    SELECT A.PROD_ID AS ��ǰ��ȣ,
           B.PROD_NAME AS ��ǰ��,
           SUM(A.BUY_QTY) AS ���Լ����հ�
    FROM BUYPROD A
    INNER JOIN PROD B ON(A.PROD_ID = B.PROD_ID AND EXTRACT(YEAR FROM BUY_DATE) = 2020)
    GROUP BY A.PROD_ID,B.PROD_NAME
    HAVING SUM(A.BUY_QTY) >= 100
    ORDER BY 1;

9)�������̺��� 2020�� ����, ��ǰ��, ��ǰ�����հ踦 ��ȸ�Ͻÿ�
    SELECT  SUBSTR(CART_NO,5,2) AS ��,
            PROD_ID AS ��ǰ��ȣ,
            SUM(CART_QTY) AS �Ǹż����հ�
    FROM CART
    WHERE CART_NO LIKE '2020%'
    GROUP BY SUBSTR(CART_NO,5,2),PROD_ID
    HAVING SUM(CART_QTY) BETWEEN 15 AND MAX(CART_QTY)
    ORDER BY 1, 2;
    
10)������̺��� �μ���, �⵵�� �Ի��� ������� ��ȸ�Ͻÿ�.
    SELECT DEPARTMENT_ID AS �μ���,
           EXTRACT (YEAR FROM HIRE_DATE) AS �⵵,
           COUNT(*) AS "�Ի��� �����"
    FROM C##HR.EMPLOYEES
    GROUP BY DEPARTMENT_ID,EXTRACT (YEAR FROM HIRE_DATE)
    ORDER BY 1;
11)ȸ�����̺��� �������� ��ո��ϸ����� ȸ������ ��ȸ�Ͻÿ�.
    
    SELECT 
           SUBSTR(MEM_ADD1,1,2) AS ������,
           TRUNC(AVG(MEM_MILEAGE)) AS ��ո��ϸ���,
           COUNT(MEM_ID) AS ȸ����
    FROM MEMBER
    GROUP BY SUBSTR(MEM_ADD1,1,2)
    ORDER BY 3 DESC;

-------------------------------------------------------------------------����

12)ȸ�����̺��� ���� ��ո��ϸ����� ��ȸ�Ͻÿ�.
    
13)ȸ�����̺��� ���ɴ뺰 ȸ������ ��ո��ϸ����� ��ȸ�Ͻÿ�.

14)��ǰ���̺��� ���԰ŷ�ó�� ��ǰ�� ���� �ְ���԰�, �������԰��� ��ȸ�Ͻÿ�.

