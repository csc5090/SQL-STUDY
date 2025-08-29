2025-08-28-03) PL/SQL)

 - Procedural Language SQL
 - �������� ������ ó���� ���� ǥ�� SQL�� Ȯ���� ���
 - �̸� �ۼ��� ���� �������Ͽ� ���� ������ ���·� ������ �����ϰ� �ʿ�� ���� ��ɸ� �ҷ� ���
   => ���� ������ ������ �̿��ϴ� �ڷ��� ���� �۾����� ������ ȿ������ Ȯ���� �� ����
      (���� ��Ʈ��ũ�� Ʈ������ ���� ��Ŵ)
 - �⺻�� block���� �����Ǹ� �������� SQL���� �ϰ� ���� ����
 - ���ȭ ĸ��ȭ�� ����
 - Anonymous Block, Stored Procedure, User defined Function, Trigger, Package
 
 
1. PL/SQL�� ����
  DECLARE
    ���𿵿� : ����,���,Ŀ�� ����
  
  BEGIN
  ���࿵�� : �����Ͻ� ������ sql��, �ݺ���, ���ǹ� ���� �̿��Ͽ� ó��
  
     [EXCEPTION
          ����ó��          ]
    
    END;
    

1)����
  - �ڷᰡ ����Ǵ� �������� �̸�(��ȣ����)
  - SCLAR, REFERENCES, COMPOSITE, BIND ������ ���е�
  
    (1) SCLAR ����
      . �Ϲ����� ����
      . �� ���� ���� ������ �����ϸ� ���ο� ���� �ԷµǸ� ������ ���� ������
      
    ��������)
    ������  [CONSTANT] ������Ÿ�� [NOT NULL] [:= �ʱⰪ];
    
    
    (2) ������ ����
       - �������� ����
       (�������)
       ������ ���̺��.�÷���%type
       . '������'�� �ڷ� Ÿ���� '���̺��.�÷���'�� �ڷ� Ÿ�԰� ũ��� ������
       
��뿹) 2020�� 5�� ���� ���� �Ǹŵ� ��ǰ 5���� ��ǰ��ȣ, ��ǰ��, �Ǹż����� ����Ͻÿ�.

SELECT A.PROD_ID AS ��ǰ��ȣ,
       P.PROD_NAME AS ��ǰ��,
       A.SQTY AS �Ǹż���
FROM PROD P
INNER JOIN (SELECT PROD_ID, SUM(CART_QTY) AS SQTY
              FROM CART
              WHERE CART_NO LIKE '202005%'
              GROUP BY PROD_ID
              ORDER BY 2 DESC)A ON(A.PROD_ID=P.PROD_ID)
WHERE ROWNUM<=5;


PL/SQL))

DECLARE
  l_prod_id   prod.prod_id%TYPE;
  l_prod_name prod.prod_name%TYPE;
  l_sqty      NUMBER;

  CURSOR cur_cart_top5 IS
    SELECT prod_id, prod_name, sqty
    FROM (
      SELECT p.prod_id,
             p.prod_name,
             SUM(c.cart_qty) AS sqty,
             ROW_NUMBER() OVER (ORDER BY SUM(c.cart_qty) DESC) AS rn
      FROM prod p
      JOIN cart c ON c.prod_id = p.prod_id
      WHERE c.cart_no LIKE '202005%'
      GROUP BY p.prod_id, p.prod_name
    )
    WHERE rn <= 5;
BEGIN
  OPEN cur_cart_top5;
  LOOP
    FETCH cur_cart_top5 INTO l_prod_id, l_prod_name, l_sqty;
    EXIT WHEN cur_cart_top5%NOTFOUND;

    DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ� : ' || l_prod_id);
    DBMS_OUTPUT.PUT_LINE('��ǰ��   : ' || l_prod_name);
    DBMS_OUTPUT.PUT_LINE('�Ǹż��� : ' || l_sqty);
    DBMS_OUTPUT.PUT_LINE('---------------------------');
  END LOOP;
  CLOSE cur_cart_top5;
END;


- �������� ����
 (�������)
    ������ ���̺��%ROWTYPE
    . '������'�� �ڷ� Ÿ���� '���̺��'�� �ϳ��� ��� ������ �������� ���� ��Ÿ���� Ÿ������ ����
    . �ش����̺��� Ư������ �����Ϸ��� '������.�÷���'�� ���
    
    
��뿹) �͸� ����� ����Ͽ� LPROD ���̺��� ��� �ڷḦ ����Ͻÿ�.


DECLARE
L_LPROD LPROD%ROWTYPE;
CURSOR cur_lprod_all IS 
SELECT * FROM LPROD;
BEGIN
OPEN cur_lprod_all; 
LOOP
FETCH cur_lprod_all
INTO L_LPROD;
EXIT WHEN cur_lprod_all%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(L_LPROD.LPROD_ID||'  '||L_LPROD.LPROD_GU||'  '||L_LPROD.LPROD_NAME);
DBMS_OUTPUT.PUT_LINE('-----------------------------------');
END LOOP;
CLOSE cur_lprod_all;
END;


 (3) BIND ����
     - �Ű����� ���Ǵ� ������ BIND ������ ��
     - IN(�Է¿�), OUT(��¿�) INOUT(����� ����)
     - ũ�⸦ �����ϸ� ������ ��.
     
��뿹) �Ⱓ�� ��ǰ�ڵ带 �Է� �޾� �ش� ��ǰ�� �Ǹż��� ���� ��ȯ�ϴ� �Լ��� �ۼ��Ͻÿ�.

CREATE OR REPLACE FUNCTION fn_sum_qty(P_PERIOD IN VARCHAR2, P_PID IN PROD.PROD_ID%TYPE)
RETURN NUMBER
IS
L_SUM_QTY NUMBER:=0;
BEGIN
SELECT SUM(CART_QTY) INTO L_SUM_QTY
FROM CART
WHERE PROD_ID=P_PIP
AND CART_NO LIKE P_PERIOD||'%';
RETURN L_SUM_QTY;
END;

SELECT PROD_ID,PROD_NAME,NVL(fn_sum_qty('202006',PROD_ID),0)
FROM PROD
ORDER BY 1;