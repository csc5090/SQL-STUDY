2025-0807-01)SELECT ��
�������)
    SELECT * | [DISTINCT] [�÷���[AS ��Ī,]
                            :
                            :
                            �÷Ÿ�[AS��Ī]  ]
        FROM ���̺��
        [WHERE ����]
        [GROUP BY �÷���[,�÷���,~,�÷���]]
        [HAVING ����]
        [ORDER BY �÷���|�÷��ε���[ASC|DESC] [, �÷���|�÷��ε���[ASC|DESC] ,~]]
        
        ASC:��������.
        DESC:��������.
        
��뿹)
 1) ȸ�����̺�(MEMBER)�� ��� �ڷḦ ����Ͻÿ�.
    SELECT *   --��� ��
      FROM MEMBER;
      
 2) HR������ �μ������� ��� ��ȸ�Ͻÿ�.
    
    SELECT *
        FROM C##HR.DEPARTMENTS;

 3) HR������ ������̺�(EMPLOYEES)���� �����ȣ(EMPLOYEE_ID), �����(EMP_NAME), �޿�(SALARY)�� ����Ͻÿ�.
 
    SELECT EMPLOYEE_ID,EMP_NAME,SALARY
        FROM C##HR.EMPLOYEES;
        
    SELECT EMPLOYEE_ID AS �����ȣ, 
           EMP_NAME AS �����,
           SALARY AS �޿�
        FROM C##HR.EMPLOYEES;
 
 4) ��ǰ���̺�(PROD)���� ��ǰ��ȣ(PROD_ID),��ǰ��(PROD_NAME),���԰�(PROD_COST),���Ⱑ(PROD_PRICE)�� ��ȸ�Ͻÿ�.
 
    SELECT PROD_ID AS ��ǰ��ȣ,
        PROD_NAME AS ��ǰ��,
        PROD_COST AS ���԰�,
        PROD_PRICE AS ���Ⱑ
            FROM PROD
            ORDER BY ���԰� DESC;
 
 5) ȸ�����̺��� ���ϸ����� 5000�̻��� ȸ������ ��ȸ�Ͻÿ�.
    alias�� ȸ����ȣ, ȸ����, ����,���ϸ����̸� ���ϸ����� ū ȸ������ ����Ͻÿ�.
    
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����ȣ,
           MEM_JOB AS ����,
           MEM_MILEAGE AS ���ϸ���
            FROM MEMBER
            WHERE MEM_MILEAGE >= 5000
            ORDER BY 4 DESC;
            
 6) HR������ ������̺��� �Ի����� 2020�� 1�� 1�� ������ ��������� ��ȸ�Ͻÿ�.
    Alias�� �����ȣ, �����, �μ���ȣ, �Ի����̸� �μ��ڵ������ �����ϰ�
    ���� �μ��̸� �޿��� ���� ������� ����Ͻÿ�.
 
    SELECT  EMPLOYEE_ID AS �����ȣ,
            EMP_NAME AS �����,
            DEPARTMENT_ID AS �μ��ڵ�,
            HIRE_DATE AS �Ի���,
            SALARY AS �޿�
            FROM C##HR.EMPLOYEES 
            WHERE HIRE_DATE >= TO_DATE('20200101')
            ORDER BY �μ��ڵ�, �޿� ASC;



    ������.
    
    1. ��ǰ���̺��� �ǸŰ����� 100���� �̻��� ��ǰ�� ��ȸ�Ͻÿ�.
    ALIAS�� ��ǰ��ȣ, ��ǰ��, �ǸŰ���
    
    SELECT   PROD_ID AS ��ǰ��ȣ,
             PROD_NAME AS ��ǰ��,
             PROD_PRICE AS �ǸŰ���
        FROM PROD 
        WHERE PROD_PRICE >= 1000000;
    
    
    2. ȸ�����̺��� ���ϸ����� 2000�̸��� ȸ�������� ��ȸ�Ͻÿ�.
    ALIAS�� ȸ����ȣ, ȸ����, ����, ���ϸ���
    
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           MEM_JOB AS ����,
           MEM_MILEAGE ���ϸ���
        FROM MEMBER
        WHERE MEM_MILEAGE < 2000
        ORDER BY ���ϸ��� ASC;
    
    6.���ϸ����� 2000�̻��̸鼭 ������ �ֺ��� ȸ�������� ��ȸ�Ͻÿ�.
    ALIAS�� ȸ����ȣ, ȸ����, ����, ���ϸ���
    
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           MEM_JOB AS ����,
           MEM_MILEAGE AS ���ϸ���
        FROM MEMBER
        WHERE MEM_MILEAGE >= 2000 AND MEM_JOB LIKE '%�ֺ�%';
        
    7.���￡ �����ϴ� ����ȸ�� ������ ��ȸ�Ͻÿ�.
    ALIAS�� ȸ����ȣ, ȸ����, �ֹε�Ϲ�ȣ, �ּ�
    
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           MEM_REGNO1 AS �ֹε�Ϲ�ȣ���ڸ�,
           MEM_REGNO2 AS �ֹε�Ϲ�ȣ���ڸ�,
           SUBSTR(MEM_REGNO2,1,1) AS �����ڵ�,
           MEM_ADD1 AS �ּ�
        FROM MEMBER
        WHERE MEM_ADD1 LIKE '%����%'
          AND (MEM_REGNO2 LIKE '2%' OR MEM_REGNO2 LIKE '4%');
          
-> �ڵ� ����ȯ�� ���� ���� �� ������, ��� ��������� ����ȯ�� �ؾ����� ���� ��ﳪ�� �ʽ��ϴ�...

    ����)

    3.���￡ �����ϴ� ȸ�������� ��ȸ�Ͻÿ�.
    ALIAS�� ȸ����ȣ, ȸ����, �ּ�
    
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           MEM_ADD1 AS �ּ�
        FROM MEMBER
        WHERE MEM_ADD1 LIKE '%����%';
        
        Ȥ��...
        
        SELECT MEM_ID AS ȸ����ȣ,
               MEM_NAME AS ȸ����,
               MEM_ADD1 AS �ּ�,
               MEM_HOMETEL AS ����ȭ��ȣ
        FROM MEMBER
        WHERE MEM_HOMETEL LIKE '%02%';       
        ->����ȭ��ȣ�� 02�鼭 �ٸ� ���� �ּ��� ��쵵 �ִٴ� ������ �������� �� ��.
    
    4.2020�� 6���� �������� ���� ȸ������ ��ȸ�Ͻÿ�.
    ALIAS�� ȸ����ȣ, ȸ����, ����, ���ϸ���
    
    SELECT M.MEM_ID AS ȸ����ȣ,
           M.MEM_NAME AS ȸ����,
           M.MEM_REGNO2 AS ����,
           M.MEM_MILEAGE AS ���ϸ���,
           C.CART_NO AS ��������
    FROM MEMBER M
    JOIN CART C ON M.MEM_ID = C.MEM_ID
    WHERE (M.MEM_REGNO2 LIKE '2%' OR M.MEM_REGNO2 LIKE '4%')
      AND C.CART_NO NOT LIKE '202006%';
    
   
    
    5. Ű����� �⵵�� �Է¹޾� ����� ����� ���Ͻÿ�.
    ���� : 4�� ����̸鼭 100�� ����� �ƴϰų� 400�� ����� �Ǵ� ��.
    
    //&&�� ���ڸ� �ٲٸ� ���� �Է�.
    
    SELECT &&2322 AS �Է³⵵,  
       CASE
         WHEN MOD(&&YEAR, 400) = 0 THEN '����'
         WHEN MOD(&&YEAR, 100) = 0 THEN '���'
         WHEN MOD(&&YEAR, 4) = 0   THEN '����'
         ELSE '���'
       END AS ���⿩��
FROM DUAL;
    
    ���� = �Է°� / 4 = 0, �Է°� / 100 != 0, �Է°� / 400 = 0.
    
    