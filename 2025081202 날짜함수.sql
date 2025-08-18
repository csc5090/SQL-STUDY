2025-0812-02)
3. ��¥�Լ�
    1) SYSDATE
        - ǥ�� ��¥ �Լ�
        - �ý����� �����ϴ� ��,��,��,��,��,�ʸ� ���·� ��ȯ.
        - ������ ������ ����� �� �� ������ ��¥�� ������ �� ��¥ ���̿� ����� ������ ��ȯ.
        
��뿹)
    SELECT SYSDATE, SYSDATE-10, SYSDATE+35,
           SYSDATE-TO_DATE('20241215'),TRUNC(SYSDATE)-TO_DATE('20241215')
        FROM DUAL;
        
        
2.ADD_MONTH(date, n)
    - �־��� ��¥�ڷ� date�� ���� n�� ���� ��¥�� ��ȯ.
    
��뿹2)
ȸ�����̺��� MEM_BIR�� ȸ�� �������̶� �������� ��. 2�� �� 7�� ���� ��¥�����Ͻÿ�.
SELECT MEM_ID AS ȸ����ȣ,
       MEM_NAME AS ȸ����,
       MEM_BIR AS ����,
       ADD_MONTHS(MEM_BIR,2) AS ������,
       ADD_MONTHS(MEM_BIR,2)-7 AS �˶�����
FROM MEMBER;
        
3. NEXT_DAY(date, c)  ex) SELECT NEXT_DAY(DATE '2025-08-12', 'ȭ����')
  - �־��� ��¥ 'date'���� �ٰ��� 'c'������ ��¥�� ��ȯ.
  - 'c'�� '������', '��' ~ '�Ͽ���', '��'�� �����.

��뿹)
SELECT NEXT_DAY(SYSDATE,'ȭ����'),
       NEXT_DAY(SYSDATE,'�����')
    FROM DUAL;
    

������̺��� 80�� �μ��� ����� �ټӱⰣ�� XX�� XX���� �������� ����Ͽ� ��ȸ�Ͻÿ�.
       ALIAS�� �����ȣ, �����, �Ի���, �ټӱⰣ.
       
4. LAST_DAY(date)
  - �־��� ��¥�ڷῡ ���Ե� ���� ���������� �����ϴ� ��¥ ��ȯ
  

��뿹) Ű����� 1-6�� ������ ���� �Է¹޾� �ش���� �����Ѿ��� ����Ͻÿ�.

    ACCEPT P_MONTH PROMPT '��(1-6) �Է� : '
    DECLARE
            L_SUM NUMBER:=0;
            S_DATE DATE := TO_DATE('2020'||TRIM(TO_CHAR(&P_MONTH, '00'))||'01');
            E_DATE DATE := LAST_DAY(S_DATE);
    BEGIN
            SELECT SUM(A.BUY_QTY*B.PROD_COST) INTO L_SUM
            FROM BUYPROD A
            INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
            WHERE A.BUY_DATE BETWEEN S_DATE AND E_DATE;
            
            DBMS_OUTPUT.PUT_LINE(&P_MONTH||'���� ���� �Ѿ��� '||
            TO_CHAR(L_SUM,'9,999,999,999')'���Դϴ�');
    END;
    
    
    
5. MONTHS_BETWEEN(d1,d2)
    - �� ��¥ �ڷ�(d1,d2) ������ �������� ��ȯ
    - ���̳� ��� ���� � ���
    
    SELECT MEM_ID AS ȸ����ȣ,
              MEM_NAME AS ȸ����,
              MEM_BIR AS �������,
              TRUNC(MONTHS_BETWEEN(SYSDATE, MEM_BIR)/12) ||'��' ||
              ROUND(MOD(MONTHS_BETWEEN(SYSDATE, MEM_BIR),12))||'��' AS ����
       FROM MEMBER;
    
��뿹) ȸ�����̺��� ȸ������ ���̸� xx�� xx���� �������� ���Ͽ� ����Ͻÿ�.
       ���̴� MEM_BIT�÷��� �̿��Ͽ� ����ϰ�, ȸ����ȣ, ȸ����, �������, ���̸� ���Ͻÿ�.
       
       SELECT MEM_ID AS ȸ����ȣ,
              MEM_NAME AS ȸ����,
              MEM_BIR AS �������, 
              TRUNC(MONTHS_BETWEEN(SYSDATE, MEM_BIR)/12) ||'�� ' ||
              ROUND(MOD(MONTHS_BETWEEN(SYSDATE, MEM_BIR),12))||'��' AS ����
       FROM MEMBER;
       

��뿹) ������̺��� 80�� �μ��� ����� �ټӱⰣ�� XX�� XX���� �������� ���.
        AS �� �����ȣ, �����, �Ի���, �ټӱⰣ
        
        
        
        
6. EXTRACT(fmt FROM date)
  - �־��� ��¥�ڷ� date���� �ʿ��� �κи� ����
    (fmt=YEAR, MONTH, DAY, HOUR, MINUTE, SECOND)
  - ����� �ڷ��� ������ Ÿ���� ����
  
  
��뿹) ȸ�����̺��� ������ ������ ȸ������ �����Ͻÿ�.
       AS�� ȸ����ȣ, ȸ����, �������, �ڵ�����ȣ,

      
      SELECT MEM_ID AS ȸ����ȣ,
             MEM_NAME AS ȸ����,
             MEM_BIR AS �������,
             MEM_HP AS �ڵ�����ȣ
      FROM MEMBER
      WHERE
      EXTRACT (MONTH FROM SYSDATE)+1=EXTRACT(MONTH FROM MEM_BIR);