2025-0821-01)JOIN
- �� �� �̻��� ���̺���� ���� �Ǵ� �����Ͽ� �����͸� ����ϴ� ��
- �Ϲ����� ��� ����� Primary Key(PK)�� Foreign Key(FK)���� ������ ���� ������ ����.
- � ��쿡�� �̷��� PK,FK�� ���谡 ��� ������ ������ ���������� ���� ������ ������.
- JOIN�� ������ WHERE ���� ����ϸ� �����ϴ� ���̺��� ���� N�� �� �� JOIN ������ �ݵ�� N-1�� �̻��̾�� �Ѵ�.
- JOIN�� ����/�ܺ�, �Ϲ�/ANSI, ����/�񵿵�, ����, CARTESIAN PRODUCT ������ ������.

1. CARTESIAN PRODUCT
 - ���� ������ ���ų� �߸� ����� ���
 - ANSI������ CROSS JOIN�̶�� ��.
 
��� ���� - �Ϲ� ����)
SELECT �÷���
FROM ���̺�1 [��Ī1], ���̺�2 [��Ī2]...

��Ī1�� �ش� ���� �ȿ��� ���̺��� ��Ī�ϴ� �� �ٸ� �̸����� ���� �θ��� ���� ����ϱ� ���� �ܾ��

�������-ANSI����)
SELECT �÷���
FROM ���̺�1 [��Ī1]
CROSS JOIN   ���̺�2 [��Ī2]
CROSS JOIN ���̺��3 [��Ī3]...


*** ��� ANSI JOIN�� FROM������ �ϳ��� ���̺��� �����Ѵ�.
 - CARTESIAN PRODUCT�� CROSS JOIN�� ����� ���ο� �����ϴ� ��� ���̺���� ���� ���� �� ��ŭ,
   ���� ���� �� ��ŭ �����ȴ�.
 - ���� �ذ��� ���Ͽ� �ݵ�� �ʿ��� ��찡 �ƴϸ� ����� ���� �ؾ���.

�������)
SELECT 'CART' AS ���̺��, COUNT(*) AS ���Ǽ�
FROM CART
UNION ALL
SELECT 'BUYPROD', COUNT(*)
FROM PROD; 

SELECT * 
FROM CART,BUYPROD,PROD;

ANSI : CROSS JOIN

SELECT COUNT(*)
FROM BUYPROD
CROSS JOIN CART
CROSS JOIN PROD;


2. ��������( INNER JOIN ) 
 - ���� ������ �����ϴ� �ڷḸ ��ȯ�ϰ�, ���� ������ �������� �ʴ� �ڷ�� ������.

������� - �Ϲ�����)

SELECT �÷���
FROM ���̺��1 [��Ī1], ���̺��2[��Ī2],...
WHERE ��������
[AND ��������]
............
[AND �Ϲ�����]

    �Ϲ� ���ǰ� ���������� ��� ������ �������
    ���������� �����ϴ� ��� ���
    

������� - ANSI JOIN )

SELECT �÷���
FROM ���̺��
INNER JOIN ���̺��2 [��Ī2] ON(��������1 [AND �Ϲ�����])
[INNER JOIN ���̺��3 [��Ī3] ON(��������2 [AND �Ϲ�����2])
                    :       
                    :
                    :
[WHERE �Ϲ�����]

    FROM���� ���̺�� ù ��° INNER JOIN ���� ���̺��� �ݵ�� ���� ���� �Ǿ�� �Ѵ�.
    . JOIN�� ����� '���̺��1' �� '���̺��2'�� ���� ����� '���̺��3'�� ���ε�.
    . '�Ϲ�����1'�� '���̺��1'�� '���̺��2'�� ���õ� �����̸� '�Ϲ�����2'��
      '���̺��1'�� '���̺��2', '���̺��3'�� ���õ� ������.
    . WHERE ���� ������ ��ο� ����Ǵ� �������� INNER ���ο����� ON ���� ����ص�, WHERE���� ����ص�
      ����� �����ϳ� �ܺ������� WHERE���� ����ϸ� �� ��.(���� JOIN������ �ݵ�� ������. �� ���� ī�׽þ� ���� �Ǿ����.)
    
    

��뿹)
 1) ������̺�� �μ����̺��� �̿��Ͽ� �μ��� ������� ��ձ޿��� ����Ͻÿ�.
    AS�� �μ���ȣ, �μ���, �����, ��ձ޿��̸� �μ���ȣ ������ ����ؾ� ��.
 
 (�Ϲ� ����)
 SELECT A.DEPARTMENT_ID AS �μ���ȣ, 
        B.DEPARTMENT_NAME AS �μ���,
        COUNT(*) AS �����,
        ROUND(AVG(SALARY)) AS ��ձ޿�
 FROM C##HR.EMPLOYEES A, C##HR.DEPARTMENTS B
 WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
 GROUP BY A.DEPARTMENT_ID,B.DEPARTMENT_NAME
 ORDER BY 1;
 
ANSI FORMAT

SELECT A.DEPARTMENT_ID AS �μ���ȣ, 
        B.DEPARTMENT_NAME AS �μ���,
        COUNT(*) AS �����,
        ROUND(AVG(SALARY)) AS ��ձ޿�
 FROM C##HR.EMPLOYEES A
 INNER JOIN C##HR.DEPARTMENTS B ON(A.DEPARTMENT_ID=B.DEPARTMENT_ID) -- ��������
 GROUP BY A.DEPARTMENT_ID,B.DEPARTMENT_NAME
 ORDER BY 1;

 
 2) �������̺�� ��ǰ���̺��� Ȱ���Ͽ� 2020�� 1�� ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�.
    AS�� ��ǰ��ȣ, ��ǰ��, ���Լ����հ�, ���Աݾ��հ�
    
    SELECT B.PROD_ID AS ��ǰ��ȣ,
           A.PROD_NAME AS ��ǰ��,
           SUM(B.BUY_QTY) AS ���Լ����հ�,
           SUM(A.PROD_COST*B.BUY_QTY) AS ���Աݾ��հ�
    FROM PROD A, BUYPROD B
    WHERE A.PROD_ID=B.PROD_ID 
          AND B.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131') -- ��������
    GROUP BY B.PROD_ID, A.PROD_NAME
    ORDER BY 1;
    
    
    ANSI ����
    
    SELECT B.PROD_ID AS ��ǰ��ȣ,
           A.PROD_NAME AS ��ǰ��,
           SUM(B.BUY_QTY) AS ���Լ����հ�,
           SUM(A.PROD_COST*B.BUY_QTY) AS ���Աݾ��հ�
    FROM  PROD A
    INNER JOIN BUYPROD ON(A.PROD_ID=B.PROD_ID AND
    B.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131'))
    GROUP BY B.PROD_ID,A.PROD_NAME
    ORDER BY 1;
    
    
 3) 2020�� 4�� ȸ���� ������Ȳ�� ����Ͻÿ�.
    AS�� ȸ����ȣ, ȸ����, ���űݾ�
    
    SELECT A.MEM_ID AS ȸ����ȣ,
           A.MEM_NAME AS ȸ����,
           SUM(C.CART_QTY*B.PROD_PRICE) AS ���űݾ�
    FROM MEMBER A,PROD B,CART C
    WHERE A.MEM_ID=C.MEM_ID 
          AND B.PROD_ID = C.PROD_ID
          AND C.CART_NO LIKE '202004%'
    GROUP BY A.MEM_ID, A.MEM_NAME;

    ANSI ����

    SELECT A.MEM_ID AS ȸ����ȣ,
           A.MEM_NAME AS ȸ����,
           SUM(C.CART_QTY*B.PROD_PRICE) AS ���űݾ�
    FROM MEMBER A
    INNER JOIN CART C ON A.MEM_ID = C.MEM_ID
    INNER JOIN PROD B ON B.PROD_ID = C.PROD_ID AND C.CART_NO LIKE '202004%'
    GROUP BY A.MEM_ID,A.MEM_NAME;

    SELECT A.MEM_ID AS ȸ����ȣ,
           A.MEM_NAME AS ȸ����,
           SUM(C.CART_QTY*B.PROD_PRICE) AS ���űݾ�
    FROM  CART C
    INNER JOIN MEMBER A ON A.MEM_ID = C.MEM_ID
    INNER JOIN PROD B ON B.PROD_ID = C.PROD_ID
    AND C.CART_NO LIKE '202004%'
    GROUP BY A.MEM_ID, A.MEM_NAME;
    
    
 4) 2020�� 4�� ȸ���� ���űݾ��� ��ȸ�ϵ� 1000���� �̻��� ȸ���� ����Ͻÿ�
    AS�� ȸ����ȣ, ȸ����, ���űݾ��հ� 
    
    SELECT C.MEM_ID AS ȸ����ȣ,
           M.MEM_NAME AS ȸ����,
           SUM(C.CART_QTY*P.PROD_PRICE) AS ���űݾ��հ�
    FROM CART C
    INNER JOIN MEMBER M ON C.MEM_ID = M.MEM_ID
    INNER JOIN PROD P ON C.PROD_ID = P.PROD_ID
    HAVING SUM(C.CART_QTY*P.PROD_PRICE)>=10000000 
    GROUP BY C.MEM_ID, M.MEM_NAME;
    
    
    
    
 5) hr������ ���̺���� Ȱ���Ͽ� �ּҰ� �̱��� ���� ���� �μ��� ���� ��������� ��ȸ�Ͻÿ�.
    AS�� ȸ����ȣ, ȸ����, �μ���ȣ, �μ���, ��å

SELECT A.EMPLOYEE_ID AS �����ȣ,
       A.EMP_NAME AS �����,
       A.DEPARTMENT_ID AS �μ���ȣ,
       B.DEPARTMENT_NAME AS �μ���,
       C.JOB_TITLE AS ��å,
       D.COUNTRY_ID AS �����ڵ�
FROM   C##HR.EMPLOYEES A, C##HR.DEPARTMENTS B, C##HR.JOBS C, C##HR.LOCATIONS D
WHERE  A.DEPARTMENT_ID=B.DEPARTMENT_ID  -- ��������(�μ��� ����)
AND    A.JOB_ID=C.JOB_ID  -- ��������(������ ����)
AND    B.LOCATION_ID=D.LOCATION_ID
AND    D.COUNTRY_ID != 'US'
ORDER BY 3;


ANSI �������� �ϱ�.


 hr������ ���̺���� Ȱ���Ͽ� �ּҰ� �̱��� ���� ���� �μ��� ���� ��������� ��ȸ�Ͻÿ�.
    AS�� ȸ����ȣ, ȸ����, �μ���ȣ, �μ���, ��å
    
SELECT E.EMPLOYEE_ID AS �����ȣ,
       E.EMP_NAME AS �����,
       E.DEPARTMENT_ID AS �μ���ȣ,
       D.DEPARTMENT_NAME AS �μ���,
       J.JOB_TITLE AS ��å,
       L.COUNTRY_ID AS �����ڵ�
FROM C##HR.EMPLOYEES E
INNER JOIN C##HR.DEPARTMENTS D ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
INNER JOIN C##HR.LOCATIONS L ON L.LOCATION_ID=D.LOCATION_ID
INNER JOIN C##HR.JOBS J ON J.JOB_ID=E.JOB_ID
WHERE NOT(L.COUNTRY_ID IN ('US'))
ORDER BY 1;
