2025082002) �����Լ�
    - ������ ��ȯ���ִ� �Լ�.
    - RANK() OVER, DENSE_RANK() OVER, ROW_NUMBER() OVER
    - SELECT �� ���� �Լ���.
�������)
SELECT RANK() |DENSE_RANK()|ROW_NUMBER()| OVER(ORDER BY �÷��� [ASC|DESC],...) AS ��Ī
    . RANK() : �Ϲ����� ���� �ο�(���� ���̸� ���� ������ �ο��ϰ� ���� ������ "������� + ���� ���� ����"�� �ο�)
    . DENSE_RANK() : ���� ���̸� ���� ������ �ο��ϰ� ���� ������ "�������+1"�� �ο�
    . ROW_NUMBER() : ����ȭ�� ���� ������ ���� ���� ���ʴ�� �������� �ο�

    EX)         9, 8, 8, 7, 7, 7, 7, 6, 5, 4
    RANK()      1  2  2  4  4  4  4  8  9  10
  DENSE_RANK()  1  2  2  3  3  3  3  4  5  6
  ROW_NUMBER()  1  2  3  4  5  6  7  8  9  10
  
  ��뿹) ȸ�����̺��� ���ϸ����� ���� ȸ������ ������ �ο��Ͻÿ�.
        AS�� ȸ����ȣ, ȸ����, ���ϸ���, ����
        
        SELECT MEM_ID AS ȸ����ȣ,
               MEM_NAME AS ȸ����,
               MEM_MILEAGE AS ���ϸ���,
               RANK() OVER(ORDER BY MEM_MILEAGE DESC, 
               EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) ASC) AS "����(RANK())", 
               DENSE_RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS "����(DENSE_RANK())",
               ROW_NUMBER() OVER(ORDER BY MEM_MILEAGE DESC) AS "����(ROW_NUMBER())"
        FROM MEMBER;
        
2. �׷캰 ����
    - Ư�� �÷��� �������� �׷��� ������ �� �׷쳻���� ������ ������.
    - RANK(). DENSE_RANK(), ROW_NUMBER()�� ����.

�������)
SELECT RANK() | DENSE_RANK() | ROW_NUMBER() OVER(PARTITION BY �÷��� [,�÷���,...]  ORDER BY �÷��� [ASC|DESC] [,...]) AS �÷���
        - PARTITION BY �÷��� : '�÷���'�� �������� �׷��� ����
        

��뿹) ������̺��� �� �μ��� ������� �Ի��Ͽ� ���� ������ �ο��Ͻÿ�
        AS�� �����ȣ, �����, �μ���ȣ, �Ի���, ����
        
SELECT EMPLOYEE_ID AS �����ȣ,
       EMP_NAME AS �����,
       DEPARTMENT_ID AS �μ���ȣ,
       HIRE_DATE AS �Ի���,
       RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY HIRE_DATE ASC) AS ����
FROM   C##HR.EMPLOYEES;
        
��뿹) 2020�� 2�� ��ǰ�� ���Լ����հ迡 ���� ������ ���Ͻÿ�.
       AS�� ��ǰ�ڵ�, ��ǰ��, ���Լ���, ���� 
       
SELECT PROD_ID AS ��ǰ�ڵ�,
       SUM(BUY_QTY) AS ���Լ���,
       RANK() OVER(ORDER BY SUM(BUY_QTY) DESC) AS ����
FROM BUYPROD
WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND LAST_DAY(TO_DATE('20200201'))
GROUP BY PROD_ID;

��뿹)
1. ��� ���̺��� �μ��� �޿������� ������ �ο��Ͻÿ�.

SELECT  DEPARTMENT_ID AS �μ�,
        RANK() OVER(ORDER BY DEPARTMENT_ID ASC) AS �޿�����
FROM   C##HR.EMPLOYEES
GROUP BY DEPARTMENT_ID;


2. ȸ�����̺��� ���ɴ� �� ���ϸ��������� ������ �ο��Ͻÿ�.


SELECT
TRUNC(TRUNC(MONTHS_BETWEEN(SYSDATE, MEM_BIR)/12)/10)*10 || '��' AS ���ɴ�,
RANK() OVER (PARTITION BY TRUNC(TRUNC(MONTHS_BETWEEN(SYSDATE, MEM_BIR)/12)/10)*10 ORDER BY MEM_MILEAGE ASC) AS ���ϸ�������
FROM MEMBER
ORDER BY 1, 2;

->

SELECT
TRUNC(TRUNC(MONTHS_BETWEEN(SYSDATE, MEM_BIR)/12)/10)*10 || '��' AS ���ɴ�,
MAX(MEM_MILEAGE) AS ���ϸ���,
RANK() OVER(ORDER BY MAX(MEM_MILEAGE) DESC) AS ����
FROM MEMBER
GROUP BY TRUNC(TRUNC(MONTHS_BETWEEN(SYSDATE, MEM_BIR)/12)/10)*10;