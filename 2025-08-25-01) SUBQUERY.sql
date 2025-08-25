2025-08-25-01) SUBQUERY
  - ������ �ȿ� ���Ե� �� �ٸ� ����.
  - ( )�ȿ� ���
  - �˷����� ���� ������ ������� �˻��ϴ� ��� ���
  - �Ϲ� ��������/INLINE ��������/��ø��������, ���/���� �������� ������ ����
  
��뿹)
 1) ������̺��� ��� ����� ��� �޿����� �� ���� �޿��� �޴� ����� �����ȣ, �����, �μ���ȣ, �޿��� ��ȸ�ϱ�.
 
 
 ��ø��������(WHERE���� ���������� ����)�� �ۼ�.
 
 
SELECT  EMPLYEE_ID AS �����ȣ,
        EMP_NAME AS �����,
        DEPARTMENT_ID AS �μ���ȣ,
        SALARY AS �޿�
FROM C##HR.EMPLOYEES 
WHERE SALARY > (��ձ޿�:��������)
ORDER BY 3;

�������� : ��� �޿�)

SELECT AVG(SALARY)
FROM C##HR.EMPLOYEES;

����)

SELECT  EMPLOYEE_ID AS �����ȣ,
        EMP_NAME AS �����,
        DEPARTMENT_ID AS �μ���ȣ,
        SALARY AS �޿�,
        (SELECT ROUND(AVG(SALARY)) FROM C##HR.EMPLOYEES) AS ��ձ޿�
FROM C##HR.EMPLOYEES 
WHERE SALARY > (SELECT AVG(SALARY) FROM C##HR.EMPLOYEES)
ORDER BY 4;


INLINE ���������� �ۼ�.

SELECT  A.EMPLOYEE_ID AS �����ȣ,
        A.EMP_NAME AS �����,
        A.DEPARTMENT_ID AS �μ���ȣ,
        A.SALARY AS �޿�,
        ROUND(B.ASAL) AS ��ձ޿�
FROM C##HR.EMPLOYEES A, (SELECT AVG(SALARY) AS ASAL FROM C##HR.EMPLOYEES) B
WHERE A.SALARY > B.ASAL
ORDER BY 4;

��뿹) ������̺��� 50�� �μ����� ���� ���� �Ի��� ������� �Ի����� ���� �����
       �����ȣ, �����, �μ���ȣ, �μ���, �����ڵ带 ��ȸ�Ͻÿ�.
       
��������)

SELECT A.EMPLOYEE_ID AS �����ȣ,
       A.EMP_NAME AS �����,
       A.DEPARTMENT_ID AS �μ���ȣ,
       B.DEPARTMENT_NAME AS �μ���,
       A.JOB_ID AS �����ڵ�
FROM C##HR.EMPLOYEES A
INNER JOIN C##HE.DEPARTMENTS B ON(A.DEPARTMENT_ID=B.DEPARTMENT_ID)
WHERE A.HIRE_DATE<(SELECT MIN(HIRE_DATE)
                   FROM C##HR.EMPLOYEES
                   WHERE DEPARTMENT_ID=50;)
ORDER BY 3;


��������)

SELECT MIN(HIRE_DATE)
FROM C##HR.EMPLOYEES
WHERE DEPARTMENT_ID=50;

SELECT HIRE_DATE
FROM (SELECT HIRE_DATE
      FROM C##HR.EMPLOYEES
      WHERE DEPARTMENT_ID=50
      ORDER BY 1)
WHERE ROWNUM=1;

����)

SELECT A.EMPLOYEE_ID AS �����ȣ,
       A.EMP_NAME AS �����,
       A.DEPARTMENT_ID AS �μ���ȣ,
       B.DEPARTMENT_NAME AS �μ���,
       A.HIRE_DATE AS �Ի���,
       A.JOB_ID AS �����ڵ�
FROM C##HR.EMPLOYEES A
INNER JOIN C##HR.DEPARTMENTS B ON(A.DEPARTMENT_ID=B.DEPARTMENT_ID)
WHERE A.HIRE_DATE<(SELECT HIRE_DATE
                   FROM (SELECT HIRE_DATE
                         FROM C##HR.EMPLOYEES
                         WHERE DEPARTMENT_ID=50
                         ORDER BY 1)
                         WHERE ROWNUM=1)
ORDER BY 5;

��뿹) 2020�� 5�� ���űݾ��� ���� ���� ȸ���� ȸ����ȣ,ȸ����,����,���ϸ����� ��ȸ�Ͻÿ�.

�������� :

SELECT MEM_ID AS ȸ����ȣ,
       MEM_NAME AS ȸ����,
       MEM_JOB AS ����,
       MEM_MILEAGE AS ���ϸ���
FROM MEMBER A
WHERE MEM_ID
 
�������� :  2020�� 5�� ���űݾ��� ���� ���� ȸ���� ȸ����ȣ

SELECT AMID, ASUM
FROM (SELECT A.MEM_ID AS AMID,
       SUM(A.CART_QTY*B.PROD_PRICE) AS ASUM
FROM CART A
INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID AND A.CART_NO LIKE '202005%')
GROUP BY A.MEM_ID
ORDER BY 2 DESC)
WHERE ROWNUM=1

(����)

SELECT MEM_ID AS ȸ����ȣ,
       MEM_NAME AS ȸ����,
       MEM_JOB AS ����,
       MEM_MILEAGE AS ���ϸ���
FROM MEMBER
WHERE MEM_ID=(SELECT AMID
              FROM (SELECT A.MEM_ID AS AMID,
                           SUM(A.CART_QTY * B.PROD_PRICE) AS ASUM
                      FROM CART A
                      INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID AND A.CART_NO LIKE '202005%')
                      GROUP BY A.MEM_ID
                      ORDER BY 2 DESC)
                      WHERE ROWNUM=1);
                      
                      
��뿹) ������̺��� �ڽ� �μ��� ��ձ޿����� �� ���� �޿��� �޴� ����� �����ȣ,�����,�μ���ȣ,�μ���ձ޿��� ��ȸ�Ͻÿ�.
�������� : ������̺��� ���ǿ� �´� ����� �����ȣ, �����, �μ���ȣ, �޿�, �μ���ձ޿�

SELECT A.EMPOYEE_ID AS �����ȣ,
       A.EMP_NAME AS �����,
       A.DEPARTMENT_ID AS �μ���ȣ,
       A.SALARY AS �޿�,
       (SELECT ROUND(AVG(B.SALARY))
       FROM C##HR.EMPLOYEES B
       WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID) AS �μ���ձ޿�
FROM C##HR.EMPLOYEES A
WHERE A.SALARY<(��������:�μ� ��ձ޿�)

�������� : �μ��� ��ձ޿�)
SELECT DEPARTMENT_ID,
       AVG(SALARY)
FROM C##HR.EMPLOYEES
GROUP BY DEPARTMENT_ID;

����
SELECT A.EMPLOYEE_ID AS �����ȣ,
       A.EMP_NAME AS �����,
       A.DEPARTMENT_ID AS �μ���ȣ,
       A.SALARY AS �޿�,
       (SELECT ROUND(AVG(B.SALARY))
       FROM C##HR.EMPLOYEES B
       WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID) AS �μ���ձ޿�
FROM C##HR.EMPLOYEES A, (SELECT DEPARTMENT_ID, AVG(SALARY) AS ASAL
                         FROM C##HR.EMPLOYEES
                         GROUP BY DEPARTMENT_ID) B
WHERE A.SALARY<B.ASAL
AND B.DEPARTMENT_ID=A.DEPARTMENT_ID
        ORDER BY 3, 4 DESC;

��뿹) ���ϸ����� ���� 3���� 2020�� 4-6�� ������Ȳ�� ��ȸ�Ͻÿ�.
        AS�� ȸ����ȣ, ȸ����, ���űݾ��հ�
        
        
---------

��� ���� ���̺�  ����

���̺�� : REMAIN

�÷Ÿ�           Ÿ��          �⺻��          PK/FK           ����

REMAIN_YEAR   CHAR(4)                        PK             �����ҳ⵵
PROD_ID       VARCHAR2(10)                 PK & FK          ��ǰ�ڵ�
REMAIN_J_00   NUMBER(5)                                     �������
REMAIN_I      NUMBER(5)        0                            ���Լ���
REMAIN_O      NUMBER(5)        0                            �������
REMAIN_J_99   NUMBER(5)        0                            �����
REMAIN_DATE   DATE           SYSDATE                        ��������

�� ���̺� ������ �ڷḦ �����Ͻÿ�

�����ҳ⵵ : 2020
PROD_ID : PROD���̺��� ��� PROD_ID
������� : PROD���̺��� �������(PROD_PROPERSTOCK)
����/������� : 0
����� : PROD���̺��� �������(PROD_PROPERSTOCK)
�������� : 2020-01-01

INSERT INTO REMAIN(REMAIN_YEAR,PROD_ID,REMAIN_J_00,REMAIN_J_99,REMAIN_DATE)
SELECT '2020',PROD_ID,PROD_PROPERSTOCK,PROD_PROPERSTOCK,TO_DATE('20200101')
FROM PROD;

COMMIT;