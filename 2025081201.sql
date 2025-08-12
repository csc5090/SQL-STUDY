2025-0812-01) �Լ�

�����Լ�

1) ������ �Լ� ABS(n), SIGN(n), SQRT(n), POWER(b, n)

ABS : n�� ���밪
SIGN : n�� ��ȣ�� ���� �����̸� -1, 0�̸� 0, ����̸� 1�� ��ȯ
SQRT : n�� ����(��Ʈ)
POWER : b�� n�°� (b�� n�� �ŵ������� ��)

��뿹)
SELECT ABS(-1200), ABS(1200), SIGN(0.000001), SIGN(1200), SIGN(0),
SQRT(16), POWER(2,10)
FROM DUAL;


�ڡڡڡ�
2) ROUND(n [, m])
  m�� ����� ���: �־��� �ڷ� n�� �Ҽ��κ� m+1��° �ڸ����� �ݿø��Ͽ� m��°���� ��ȯ
  m�� ������ ���: �־��� �ڷ� n�� �����κ� m��° �ڸ����� �ݿø��Ͽ� ��ȯ

��뿹)HR������ ������̺��� ������� ���ʽ��� ����Ͽ� ���޾��� ����ϴ� SQL���� �ۼ��϶�.
���ʽ� = �޿� * �������� * 30%
���޾�=�޿�+���ʽ�
����� �����ȣ,�����,��������,�޿�,���ʽ�,���޾��̸�
���޾��� ���� �ڸ����� �ݿø��ϰ�, ���ʽ��� �Ҽ� ù�ڸ����� �ݿø��Ͻÿ�.

SELECT EMPLOYEE_ID AS �����ȣ,
       EMP_NAME AS �����,
       NVL(COMMISSION_PCT,0) AS ��������,
       SALARY AS �޿�,
       ROUND(SALARY*NVL(COMMISSION_PCT,0)*0.3) AS ���ʽ�,
       ROUND(SALARY+ROUND(SALARY*NVL(COMMISSION_PCT,0)*0.3),-1) AS ���޾�
FROM C##HR.EMPLOYEES

SELECT ROUND(230/17,2), TRUNC(230/17,2)  FROM DUAL;

�ڡڡ�
TRUNC(n [, m])
  m�� ����� ���: �־��� �ڷ� n�� �Ҽ��κ� m+1��° �ڸ����� �����Ͽ� m��°���� ��ȯ
  m�� ������ ���: �־��� �ڷ� n�� �����κ� m��° �ڸ����� �����Ͽ� ��ȯ

MOD(n [, m]) : n�� m���� ���� ������ ��ȯ (Java�� % ������ ���)

��뿹)
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           MEM_BIR AS �������,
    CASE MOD((TRUNC(MEM_BIR)-TO_DATE('00010101')-1),7)
                WHEN 0 THEN '�Ͽ���'
                WHEN 1 THEN '������'
                WHEN 2 THEN 'ȭ����'
                WHEN 3 THEN '������'
                WHEN 4 THEN '�����'
                WHEN 5 THEN '�ݿ���'
                ELSE '�����' 
            END AS ����
    FROM MEMBER;

FLOOR(n) : n�� ���ų� ���� �� �߿��� ���� ū ����

CEIL(n) : n�� ���ų� ū �� �߿��� ���� ���� ����. �Ҽ��� ������ ���� �����ϸ� ������ �ø�.
�޿������� ��� �� �ݾ� ��꿡�� ���� ����.

��뿹)
    SELECT FLOOR(2.43), FLOOR(10), FLOOR(-12.5), CEIL(2.43), CEIL(10), CEIL(12.5)
    FROM DUAL;

GREATEST(n1,n2,...n),  LEAST(n1,n2,....n)
    �־��� n1,n2,...n ���� ���� ū ��(GREATEST) �Ǵ� ���� ������(LEAST)�� ��ȯ
    'n1,n2,...n'�� ��� ���� �ڷ��� �̾�� ��.
    
��뿹)
    SELECT GREATEST(200,3400, 20), LEAST('ȫ�浿', 'ȫ���', 'ȫ�泲')
    FROM DUAL;
    
    ����] ȸ�� ���̺��� ���ϸ����� 1000�̸��� ȸ���� ���ϸ����� 1000���� ����ϰ� 1000�̻�
    ȸ���� ���� ���ϸ����� �״�� ����Ͻÿ�.
    
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           MEM_MILEAGE AS ���ϸ���,
  GREATEST(MEM_MILEAGE,1000) AS ���渶�ϸ���
    FROM MEMBER;

7)WIDTH_BUCKET(n, lower, upper, block_count)
  - block(����)�� �׻� 1���� ī����.
  - ���� �� lower���� ���Ѱ� upper�� block_count ���� ��ŭ�� ������� 
    �������� �� �־��� �� n�� �Ҽӵ� ����� ������ ��ȯ.
  - �� ��Ͽ��� ���� ���� ���Ե����� ���� ���� ���Ե��� ����(���� ������ ����)
  - ����� ������ n���� �� ��µǴ� ����� ���� n+2����(���� �� �̸��� ���Ѱ� �̻�)
  
��뿹) ȸ�����̺��� ���ϸ��� ���� 1000-8000���̸� 8���� �������� ������
       ȸ������ ������ ���ϸ����� ���� ������ ���� ������, ȸ�� ����� ����Ͻÿ�.
       ȸ������� ������ ���.
       ALIAS�� ȸ����ȣ, ȸ����, ���ϸ���,���,���
       
       0-3:�ʱ�ȸ��
       4-6:����ȸ��
       7�̻�:VIPȸ��
       
       SELECT MEM_ID AS ȸ����ȣ,
              MEM_NAME AS ȸ����,
              MEM_MILEAGE AS ���ϸ���,
              WIDTH_BUCKET(MEM_MILEAGE,1000,8000,8) AS ���,
       CASE WHEN WIDTH_BUCKET(MEM_MILEAGE,1000,8000,8) BETWEEN 0 AND 3 THEN '�ʱ�ȸ��'
            WHEN WIDTH_BUCKET(MEM_MILEAGE,1000,8000,8) BETWEEN 4 AND 6 THEN '����ȸ��'
            ELSE 'VIPȸ��'
        END AS ���
       FROM MEMBER
       ORDER BY 3 DESC;
       

����) �� �������� ���� ���ϸ����� ���� ȸ������ '1���ȸ��' �� ���ʴ�� ����� ����ϴ� 
     ���� �ۼ�.     ALIAS�� ȸ����ȣ, ȸ����, ���ϸ���, ȸ�����
     
     SELECT MEM_ID AS ȸ����ȣ,
            MEM_NAME AS ȸ����,
            MEM_MILEAGE AS ���ϸ���,
    10-WIDTH_BUCKET(MEM_MILEAGE,1000,8000,8)||'���ȸ��' AS ȸ�����
    FROM MEMBER
    ORDER BY 3 DESC;
    
    
    
    
    
    SELECT MEM_ID AS ȸ����ȣ,
            MEM_NAME AS ȸ����,
            MEM_MILEAGE AS ���ϸ���,
    WIDTH_BUCKET(MEM_MILEAGE,700,8700,24)||'���' AS ���
    FROM MEMBER
    WHERE WIDTH_BUCKET(MEM_MILEAGE,700,8700,24) = 3
    ORDER BY 3 DESC;