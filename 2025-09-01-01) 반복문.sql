2025-09-01-01) �ݺ���

- ����Ŭ�� �ݺ����� LOOP, WHILE, FOR ���� ������.

1. LOOP��
 - �ݺ����� �⺻������ ����
 - ���� ������ ������

�������) 
    LOOP
        �ݺ�ó����(��);
        EXIT WHEN ����;
        [�ݺ�ó����(��);]
        END LOOP;
    
    . 'EXIT WHEN ����' : ������ �����ϸ� �ݺ��� ���
    
    
��뿹) �������� 7���� ���.

DECLARE
    L_CNT NUMBER:=1;
BEGIN
    LOOP
    EXIT WHEN L_CNT > 9;
    DBMS_OUTPUT.PUT_LINE('7 * '||L_CNT||' = '||7*L_CNT);
    L_CNT:=L_CNT+1;
    END LOOP;
END;

��뿹) �泲�� �����ϴ� ȸ������ 2020�� 4�� ������Ȳ�� ��ȸ�Ͻÿ�.
       ����� ȸ����ȣ, ȸ����, ���űݾ��հ��̴�.
       


Ŀ��) 2020�� 5�� �泲 ���� ȸ������ ������ ��ǰ�ڵ�, ȸ����ȣ,ȸ����
    
DECLARE L_MID MEMBER.MEM_ID%TYPE;
        L_NAME VARCHAR2(100);
        L_SUM NUMBER:=0;
        
        CURSOR cur_cart_05 IS 
         SELECT MEM_ID, MEM_NAME
           FROM MEMBER
          WHERE MEM_ADD1 LIKE '�泲%';

BEGIN
    OPEN cur_cart_05;
    LOOP
    FETCH cur_cart_05 INTO L_MID,L_NAME;
    EXIT WHEN cur_cart_05%NOTFOUND;
    SELECT SUM(A.CART_QTY*B.PROD_PRICE) INTO L_SUM
      FROM CART A, PROD B
      WHERE A.PROD_ID=B.PROD_ID
        AND A.MEM_ID=L_MID
        AND A.CART_NO LIKE '202005%';
      DBMS_OUTPUT.PUT_LINE(L_MID||'  '||L_NAME||'  '||TO_CHAR(NVL(L_SUM,0),'99,999,999'));
      DBMS_OUTPUT.PUT_LINE('---------------------------------');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('ó�� �Ǽ� : '||cur_cart_05%ROWCOUNT);
    CLOSE cur_cart_05;
END;


��뿹) �Է� ���� �μ���ȣ�� �̿��Ͽ� �ش�μ��� �ٹ��ϴ� ��������� ����Ͻÿ�
       ��� �����ȣ, �����, �μ���ȣ, �μ���, �Ի���
       
DECLARE 
  L_EID C##HR.EMPLOYEES.EMPLOYEE_ID%TYPE;   -- �����ȣ
  L_ENAME VARCHAR2(100); --�����
  L_DID C##HR.DEPARTMENTS.DEPARTMENT_ID%TYPE; -- �μ���ȣ
  L_DNAME VARCHAR2(50); -- �μ���
  L_HIRE_DATE DATE; -- �Ի���
  
  CURSOR cur_emp_02(P_DID C##HR.DEPARTMENTS.DEPARTMENT_ID%TYPE) IS 
    SELECT EMPLOYEE_ID
    FROM C##HR.EMPLOYEES
    WHERE DEPARTMENT_ID=P_DID;

BEGIN
    OPEN cur_emp_02(30);
    LOOP
    FETCH cur_emp_02 INTO L_EID;
    EXIT WHEN cur_emp_02%NOTFOUND;
    SELECT A.EMP_NAME, B.DEPARTMENT_ID, A.HIRE_DATE, B.DEPARTMENT_NAME
        INTO L_ENAME,L_DID,L_HIRE_DATE,L_DNAME
    FROM C##HR.EMPLOYEES A, C##HR.DEPARTMENTS B
    WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
    AND A.EMPLOYEE_ID=L_EID;
    DBMS_OUTPUT.PUT_LINE('�����ȣ :'||L_EID);
    DBMS_OUTPUT.PUT_LINE('����� :'||L_ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ :'||L_DID);
    DBMS_OUTPUT.PUT_LINE('�μ��� :'||L_DNAME);
    DBMS_OUTPUT.PUT_LINE('�Ի��� :'||L_HIRE_DATE);
    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('ó�� �ο� : '||cur_emp_02%ROWCOUNT);
    CLOSE cur_emp_02;
END;



2.WHILE ��
  - �Ϲ� �� ���߾���� WHILE�� ���� ���
  
  �������)
  WHILE ���� LOOP
    �ݺ�ó����(��);
        :
        :
    END LOOP;
    
    .'����'�� ���̸� �ݺ�ó�������� �����ϰ� ������ �����̸� END LOOP ������� ����
    
��뿹) �������� 7���� �����

DECLARE 
    L_CNT NUMBER:=0;
BEGIN
    WHILE L_CNT < 9
    LOOP
    L_CNT:=L_CNT+1;
    DBMS_OUTPUT.PUT_LINE('7 * '||L_CNT' = '||7*L_CNT);
    END LOOP;
END;




��뿹 ) �Է� ���� �з��� ���� ��ǰ�� 2020�� ������Ȳ�� ��ȸ�Ͻÿ�.
        ����� ��ǰ��ȣ, ��ǰ��, ���Աݾ�
   
   
        
DECLARE 
  L_PID   PROD.PROD_ID%TYPE;     -- ��ǰ��ȣ
  L_PNAME PROD.PROD_NAME%TYPE;   -- ��ǰ��
  L_MSUM  NUMBER := 0;           -- ���Աݾ�

  CURSOR cur_buyprod_02(P_LPROD_GU LPROD.LPROD_GU%TYPE) IS
    SELECT PROD_ID, PROD_NAME
      FROM PROD
     WHERE LPROD_GU = P_LPROD_GU;
BEGIN
  OPEN cur_buyprod_02('P102');
  FETCH cur_buyprod_02 INTO L_PID, L_PNAME;
  WHILE cur_buyprod_02%FOUND LOOP
    -- ��ǰ�� 2020�� ���Աݾ� �հ�
    SELECT NVL(SUM(A.BUY_QTY * B.PROD_COST), 0)
      INTO L_MSUM
      FROM BUYPROD A
      JOIN PROD B ON A.PROD_ID = B.PROD_ID
     WHERE A.PROD_ID = L_PID
       AND EXTRACT(YEAR FROM A.BUY_DATE) = 2020;

    DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ� : ' || L_PID);
    DBMS_OUTPUT.PUT_LINE('��ǰ��   : ' || L_PNAME);
    DBMS_OUTPUT.PUT_LINE('���Աݾ� : ' || TO_CHAR(L_MSUM, 'FM999,999,999'));
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------');

    FETCH cur_buyprod_02 INTO L_PID, L_PNAME; -- ���� �� ��������
  END LOOP;

  CLOSE cur_buyprod_02;
END;


3. �Ϲ� FOR ��
  - �Ϲ� �� ���߾���� FOR �� ���� ���
  
�������) 
FOR �����ε��� [REVERSE] IN �ʱⰪ...������ LOOP
    �ݺ�ó����(��);
        :
        :
    END LOOP;
    . �����ε����� �ʱⰪ�� �Ҵ��Ͽ� �������� ���Ͽ� �������� ���̸� �ݺ�����
    . �����ε����� �ý��ۿ��� �����ϴ� �����̸� 1�� ����.
    . REVERSE�� ���Ǹ� �������� �ݺ�ó����.
    
    
��뿹) ������ 7�� ����ϱ�.

DECLARE
BEGIN
    FOR I IN 1..9 LOOP
    DBMS_OUTPUT.PUT_LINE('7 * '||I||' = '||7*I);
    END LOOP;
END;

3-1) Ŀ���� FOR ��
�Ϲ� FOR���� �ٸ��� Ŀ���� ���Ǵ� FOR�� 
- OPEN, FETCH, CLOSE ���� ������.

�������) 
FOR ���ڵ�� IN Ŀ����[�Ű�������]|Ŀ������ SELECT ��� LOOP 
    Ŀ��ó����;
END LOOP;
    .Ŀ���� �ִ� �÷� ���� : ���ڵ��.Ŀ���÷���
    
��뿹) �Է¹��� �з��� ���� ��ǰ�� 2020�� ������Ȳ�� ��ȸ�϶�.
        ��ǰ��ȣ, ��ǰ��, ���Աݾ� ����ϱ�
        
        
DECLARE 
    L_MSUM NUMBER:=0; -- ���Աݾ�

CURSOR cur_buyprod_03(P_LPROD_GU LPROD.LPROD_GU%TYPE) IS
    SELECT PROD_ID,PROD_NAME
    FROM PROD
    WHERE LPROD_GU=P_LPROD_GU;
BEGIN 
FOR REC IN cur_buyprod_03('P201') LOOP
SELECT SUM(A.BUY_QTY*B.PROD_COST) INTO L_MSUM
FROM BUYPROD A, PROD B
WHERE EXTRACT(YEAR FROM A.BUY_DATE)=2020
AND A.PROD_ID=REC.PROD_ID
AND A.PROD_ID=B.PROD_ID;
    DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ� : ' || REC.PROD_ID);
    DBMS_OUTPUT.PUT_LINE('��ǰ��   : ' || REC.PROD_NAME);
    DBMS_OUTPUT.PUT_LINE('���Աݾ� : ' || TO_CHAR(NVL(L_MSUM,0),'999,999,999'));
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
END LOOP;
END;




(IN-LINE VIEW)

DECLARE 
    L_MSUM NUMBER:=0; -- ���Աݾ�
BEGIN 
FOR REC IN (SELECT PROD_ID,PROD_NAME
              FROM PROD
              WHERE LPROD_GU='P201')

LOOP
SELECT SUM(A.BUY_QTY*B.PROD_COST) INTO L_MSUM
FROM BUYPROD A, PROD B
WHERE EXTRACT(YEAR FROM A.BUY_DATE)=2020
AND A.PROD_ID=REC.PROD_ID
AND A.PROD_ID=B.PROD_ID;
    DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ� : ' || REC.PROD_ID);
    DBMS_OUTPUT.PUT_LINE('��ǰ��   : ' || REC.PROD_NAME);
    DBMS_OUTPUT.PUT_LINE('���Աݾ� : ' || TO_CHAR(NVL(L_MSUM,0),'999,999,999'));
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
END LOOP;
END;


