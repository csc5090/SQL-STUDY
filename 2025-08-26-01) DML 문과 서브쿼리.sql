2025-08-26-01) DML ���� ��������

1. INSERT ���� SUBQUERY
   - INSERT ���� SUBQUERY�� ����ϴ� ��� VALUES���� ������.
   - ���Ǵ� ���������� '()'�� ������� ����.
   - INTO ���� �÷��� ������ ������ �������� SELECT���� �÷��� ���� �� ������ ��ġ�ؾ� ��.
   
��뿹) ORDERS ���̺��� �����ϰ� CART���̺��� �ڷḦ �̿��Ͽ� ��ٱ��Ϲ�ȣ, ȸ����ȣ�� �Է��Ͻÿ�
  ORDERS ���̺�
  ----------------
  �÷���         ������Ÿ��        �⺻��        PK/FK
  ORDER_NUM     CHAR(13)                      PK
  ORDER_DATE    DATE                         
  MEM_ID        VARCHAR2(15)                  FK
  ORDER_AMT     NUMBER(9)        0              
  -----------------------
  - CART ���̺��� �ڷῡ�� ��¥��, ȸ������ �ϳ��� �ֹ���ȣ ����
  - ��ٱ��Ϲ�ȣ���� ��¥����
  - �ֹ��ݾ�(ORDER_AMT)�� 0���� ����
  
  (��������)
  SELECT DISTINCT CART_NO, TO_DATE(SUBSTR(CART_NO,1,8)), MEM_ID
  FROM CART
  ORDER BY 1;
  
  (��������)
  INSERT INTO ORDERS(ORDER_NUM,ORDER_DATE,MEM_ID)
  SELECT DISTINCT CART_NO, TO_DATE(SUBSTR(CART_NO,1,8)), MEM_ID
  FROM CART;
  
  SELECT * FROM ORDERS
  ORDER BY 1;
  
2. UPDATE ���� SUBQUERY
  - SET ���� �������� ����
  - ���� SET���� �ϳ� �̻��� �÷��� ����� ������ '(  )'  �� ���. -> �÷��� ���� �� ������
    ���������� SELECT ���� �÷��� ���� �� ������ ��ġ�ؾ��Ѵ�.

�������) 
 UPDATE ���̺�� [��Ī]
 SET (�÷���,�÷���,...)=(��������)
 WHERE ����;
 
 ��뿹) 2020 1~3�� ��ǰ�� ���Լ����� ��ȸ�ؼ� ���������̺��� �����Ͻÿ�.
        ���� ���ڴ� 2020/03/31
  
  (�������� : 2020�� 1~3�� ��ǰ�� ���Լ���)
  SELECT PROD_ID, SUM(BUY_QTY) AS AQTY
  FROM BUYPROD
  WHERE BUY_DATE BETWEEN TO_DATE('2020-01-01') AND TO_DATE('2020-03-31')
  GROUP BY PROD_ID;
 
 COMMIT;
 
 ��������
 UPDATE REMAIN A 
    SET (A.REMAIN_I,A.REMAIN_J_99,A.REMAIN_DATE)=
        (SELECT A.REMAIN_I+AQTY,A.REMAIN_J_99+AQTY, TO_DATE('20200331')
         FROM  ( SELECT PROD_ID, SUM(BUY_QTY) AS AQTY
                 FROM BUYPROD
                 WHERE BUY_DATE BETWEEN TO_DATE('2020-01-01') AND TO_DATE('2020-03-31')
                 GROUP BY PROD_ID ) B                 
        WHERE A.PROD_ID=B.PROD_ID
          AND A.REMAIN_YEAR='2020')
  WHERE A.PROD_ID IN(SELECT DISTINCT PROD_ID
                              FROM BUYPROD
                             WHERE BUY_DATE BETWEEN TO_DATE('2020-01-01') AND TO_DATE('2020-03-31'))


ROLLBACK;

UPDATE REMAIN A 
    SET (A.REMAIN_I,A.REMAIN_J_99,A.REMAIN_DATE)=
        (SELECT A.REMAIN_I+NVL(SUM(B.BUY_QTY),0),A.REMAIN_J_99+NVL(SUM(B.BUY_QTY),0),TO_DATE('20200331')
                                FROM BUYPROD B
                                WHERE A.PROD_ID=B.PROD_ID
                                AND B.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200331'))
                                
                                

--PROD���̺��� PROD_MILEAGE�÷����� ���� ������ ��� ������ �����Ͻÿ�.

�������� ���Դܰ��� 0.2%�� ���� ù�ڸ����� �ݿø� �� ��
  ROUND(SELECT PROD_COST*0.002,-1)
  FROM PROD
  
  ��������
  UPDATE PROD
  SET PROD_MILEAGE=ROUND(PROD_COST*0.002,-1);
COMMIT;


MEMBER ���̺��� ���ϸ����� �ʱ�ȭ�ϰ� ���������� �̿��Ͽ� ���ϸ����� �����Ͻÿ�.

�������� : 2020�� 4-7������ ȸ���� ���������� �̿��� ���ϸ��� ��ȸ

    SELECT A.MEM_ID AS AMID,
           1000+SUM(A.CART_QTY*B.PROD_MILEAGE)*0.2 AS AMT
      FROM CART A
INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
     WHERE SUBSTR(A.CART_NO,1,6) BETWEEN '202004' AND '202007'
  GROUP BY A.MEM_ID  
  ORDER BY 1;
  
��������

UPDATE MEMBER M
SET M.MEM_MILEAGE=(SELECT C.AMT
                     FROM (SELECT A.MEM_ID AS AMID,
                                  1000+SUM(A.CART_QTY*B.PROD_MILEAGE)*0.2 AS AMT
                                  FROM CART A
                                  INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
                                  WHERE SUBSTR(A.CART_NO,1,6) BETWEEN '202004' AND '202007'
                                  GROUP BY A.MEM_ID)C
                          WHERE M.MEM_ID=C.AMID)
   WHERE M.MEM_ID IN (SELECT DISTINCT MEM_ID
                        FROM CART
                       WHERE SUBSTR(CART_NO,1,6) BETWEEN '202004' AND '202007')
                       
                       COMMIT;
                       
                       
3. DELETE ���� ��������
  �ڷ������ ����� ������ ���������� ����
  �������) 
  DELETE FROM ���̺��
  WHERE �÷���=(��������)
  
  
��뿹) ������̺��� �����ȣ, �����, �μ���ȣ, �Ի���, ��å�ڵ�, �޿��� ��ȸ�ϰ� �̸� 
       ���̺�� �����Ͻÿ�.

CREATE TABLE C##HR.EMP2(EMP_ID,EMP_NAME,DEPT_ID,HIRE_DATE,JOB_ID,SALARY)
AS
    SELECT EMPLOYEE_ID,EMP_NAME,DEPARTMENT_ID,HIRE_DATE,JOB_ID,SALARY
      FROM C##HR.EMPLOYEES;

��뿹) EMP���̺��� �Ի����� 2018�� ������ ����� �����Ͻÿ�
�������� : �Ի����� 2018�� ������ ����� �����ȣ

SELECT EMP_ID
FROM C##HR.EMP2 WHERE EXTRACT(YEAR FROM HIRE_DATE)<2018

DELETE FROM C##HR.EMP2
WHERE EMP_ID =ANY(SELECT EMP_ID
FROM C##HR.EMP2 WHERE EXTRACT(YEAR FROM HIRE_DATE)<2018)
