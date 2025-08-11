2025-0811-02)�Լ�
    -�̹� ���α׷��ǰ� �����ϵǾ� ����Ǿ� ������, ����ڰ� �ʿ��� ��� ȣ���Ͽ� ����� 
     ��ȯ ���� �� �ִ� ���
    -���ڿ�, ����, ��¥, ��ȯ �Լ�, NULLó���Լ�, �����Լ�, �����Լ� ���� ����.
    - �Լ��� �Լ��� ������ �� �ִ�.

1.  ���ڿ� �Լ�
    - 1) ||
        - ���ڿ� ���� ������
        - JAVA�� ���ڿ� "+" �����ڿ� ���� ���.
        
      2) CONTACT(c1, c2)
        - ���ڿ� c1�� c2�� �����Ͽ� ��ȯ.
        - c1 || c2�� ����.
        
��뿹) ȸ�����̺��� ȸ����ȣ, ȸ����, �ֹι�ȣ�� ����Ͻÿ�.
       ��, �ֹι�ȣ�� 'XXXXXX-XXXXXXX'�������� ����Ͻÿ�.
       
       SELECT MEM_ID AS ȸ����ȣ,
              MEM_NAME AS ȸ����,
              MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ
              --CONCAT (CONCAT(MEM_REGNO1,'-'), MEM_REGNO2) AS �ֹι�ȣ
         FROM MEMBER;
        
      3) LOWER(C1), UPPER(C2), INITCAP(C1)
        - �־��� ���ڿ��� ��� �ҹ��ڷ�(LOWER), ��� �빮�ڷ�(UPPER).
          �� �ܾ��� ���۹��ڸ� �빮�ڷ�(INITCAP) ��ȯ.
          
��뿹) ��ǰ�� �з��ڵ� 'p102'�� ���� ��ǰ��ȣ, ��ǰ��, ���԰����� ����Ͻÿ�.

        SELECT PROD_ID AS ��ǰ��ȣ,
               PROD_NAME AS ��ǰ��,
               PROD_COST AS ���԰���
          FROM PROD
         WHERE LOWER(LPROD_GU)='p102';
         
(INITCAP)
    SELECT EMPLOYEE_ID, EMP_NAME, LOWER(EMP_NAME), INITCAP(LOWER(EMP_NAME))
    FROM C##HR.EMPLOYEES
    WHERE DEPARTMENT_ID=80;
          
      4) LPAD(c1, n [,c2]), RPAD(c1, n [,c2])
        - �־��� ���ڿ� c1�� n�ڸ��� �����ʺ��� ä��� ���� ������ c2�� ä��(LPAD)
        - �־��� ���ڿ� c1�� n�ڸ��� ���ʺ��� ä��� ���� ������ ������ c2�� ä��(RPAD)
        - c2�� �����ϸ� ������ ä��.
        
��뿹)
    SELECT PROD_NAME, RPAD(PROD_COST,10,'#'),LPAD(PROD_COST,10)
    FROM   PROD
    WHERE  PROD_COST < 300000
    ORDER BY 2;
    

5. LTRIM(c1 [,c2]), RTRIM(c1 [,c2])
    - �־��� ���ڿ� c1���� ���ʺ���(LTRIM), �Ǵ� ������(RTRIM)���� c2 ���ڿ� ���ϰ� ������ 
      ���ڿ��� ã�� ����
    - c2�� �����Ǹ� ����(LTRIM) �Ǵ� ������(RTRIM)�� �����ϴ� ������ ����
    
��뿹)
    SELECT LTRIM('AABBCDABAB', 'AB'), AS "COL1",
        LTRIM('     DAB AB  '), AS "COL2",
        RTRIM('AABBCDABAB', 'AB'), AS "COL3",
        RTRIM('DA BAB   ') AS "COL4"
    FROM DUAL;

    
6. TRIM(c1)
    - c1ü�� ���Ե� ���� ������ ã�� ����

��뿹) CART���̺� ���� ��¥�� ��ٱ��� ��ȣ�� �����Ͽ� ����Ͻÿ�.
       ��, ���� ���� �� ó�� �α����� ȸ����.
       
        SELECT TO_CHAR(SYSDATE, 'YYYYMMDD')||TRIM(TO_CHAR(1,'00000'))
        FROM   DUAL;
        
7. SUBSTR(c1, n [,count])
   - �־��� ���ڿ� c1���� n��ġ���� count ���� ��ŭ�� �κ� ���ڿ��� �����Ͽ� ��ȯ.
   - count�� �����Ǹ� n���� ������ ��� ���ڿ��� ��ȯ
   - n�� �����̸� ������ ���� �����Ͽ� count���� ��ŭ�� �κ� ���ڿ��� �����Ͽ� ��ȯ.
   
��뿹)
    SELECT MEM_ADD1,
           SUBSTR(MEM_ADD1,1,2) AS "COL2",
           SUBSTR(MEM_ADD1,3),
           SUBSTR(MEM_ADD1,-10,5)
    FROM   MEMBER;
    
��뿹) ���� �ڷ� �� �⵵�� ������� 5���� �Ǹŵ� ��ǰ�� �Ǹż��� �հ踦 ��ȸ�Ͻÿ�.
    
    SELECT PROD_ID AS ��ǰ��ȣ,
        SUM (CART_QTY) AS "�Ǹż��� �հ�"
    FROM   CART
    WHERE SUBSTR(CART_NO,5,2)='05'
    GROUP BY PROD_ID
    ORDER BY 2 DESC;
    
    
8. INSTR(c, c1 [,loc1 [,rept])
    - �־��� ���ڿ� c���� ó�� ���� c1�� ��ġ�� ��ȯ
    - loc�� ���� ��ġ ��
    - rept�� �ݺ�Ƚ�� ����
    
��뿹)
    SELECT INSTR('PERSIMONPEARAPPLE', 'P') AS "COL1",
           INSTR('PERSIMONPEARAPPLE', 'P',3) AS "COL2",
           INSTR('PERSIMONPEARAPPLE', 'P',3,2) AS "COL3"
        FROM DUAL;
    
9. REPLACE(c, c1[ ,c2])
    - �־��� ���ڿ� c1�� ã�� c2�� ��ġ ��Ŵ
    - c2�� �����Ǹ� c1�� ã�� ����
    
 ��뿹) ��ǰ���̺��� ��ǰ�� �� '�Ｚ'�� ã�� 'SAMSUNG'���� ġȯ�ϰ�,
        ���ڿ� ������ ������ �����Ͻÿ�.
 
    SELECT PROD_NAME,
            REPLACE (PROD_NAME, '�Ｚ','SAMSUNG') AS "COL2",
            REPLACE (PROD_NAME, ' ') AS "COL3"
      FROM PROD; 
    
    