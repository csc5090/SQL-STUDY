2025-09-02-01) ���� ���ν���(Stored procedure : Procedure)
 - ��ȯ���� ���� ���
 - Ư¡�� ������ PL/SQL�� BLOCK�� ������
 
 �������)
 CREATE [OR REPLACE] PROCEDURE ���ν�����[(
    ������ [IN|OUT|INOUT] Ÿ�Ը�,...)
    RETURN ������
    {AS|IS}
     ���𿵿�
    BEGIN 
        ���࿵��
        RETURN ��|������; -- ���� ���� ��ȯ.
        [EXCEPTION
            ����ó��;
        ]
        END;
        
    . 'IN|OUT|INOUT' : ������ ����(MODE)�� IN�� �Է¿��̰�, OUT�� ��¿�, INOUT�� ����¿����� �����Ǹ�
                       �����ϸ� IN���� ���ֵ�
    . ��ȯ ���� �����ϸ� ���� OUT �Ű������� ������ ����
    . �ַ� SELECT��� �� ��ȯ���� �ִ� ��ɿ� ����
    
    ��뿹) ��ǰ�ڵ带 �Է¹޾� 2020�� 6�� ���� �հ�� �����հ踦 ���ϴ� �Լ��� �ۼ��Ͻÿ�.
    
    CREATE OR REPLACE FUNCTION fn_sum_maeib(P_PROD_ID PROD.PROD_ID%TYPE)
      RETURN NUMBER
      AS
      L_MSUM NUMBER:=0; -- ���Աݾ��հ� / ��ȯ�� ������ ����
      BEGIN
      SELECT SUM(A.BUY_QTY*B.PROD_COST) INTO L_MSUM
      FROM BUYPROD A 
      INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
      WHERE A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')
        AND A.PROD_ID=P_PROD_ID;
        RETURN L_MSUM;
        
        EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('���� �߻� : '||SQLERRM);
      END;
    
    
    
    
    ������?
    
     CREATE OR REPLACE FUNCTION fn_sum_maechul(P_PROD_ID PROD.PROD_ID%TYPE)
      RETURN NUMBER
      AS
      L_CSUM NUMBER:=0; -- ����ݾ��հ� / ��ȯ�� ������ ����
      BEGIN
      SELECT SUM(A.CART_QTY*B.PROD_COST) INTO L_CSUM
      FROM CART A 
      INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
      WHERE A.CART_NO LIKE '202006%'
        AND A.PROD_ID=P_PROD_ID;
        RETURN L_CSUM;
        
        EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('���� �߻� : '||SQLERRM);
      END;
    
    --����
    
    SELECT PROD_ID AS ��ǰ�ڵ�,
           PROD_NAME AS ��ǰ��,
           TO_CHAR(NVL(fn_sum_maeib(PROD_ID),0),'999,999,999') AS ���Աݾ��հ�,
           TO_CHAR(NVL(fn_sum_maechul(PROD_ID),0),'999,999,999') AS �����հ�
      FROM PROD
      ORDER BY 1;
      
      
      
      
�Լ������3) ��ٱ��Ϲ�ȣ�� �����ϴ� �Լ��� ������.

CREATE OR REPLACE FUNCTION fn_create_cart_no(
    P_DATE IN DATE, P_MEM_ID IN MEMBER.MEM_ID%TYPE)
    RETURN CHAR
    AS
    L_CNT NUMBER:=0; -- �ش������� �ڷ��� ��
    L_CART_NO CART.CART_NO%TYPE; -- �ӽ� ��ٱ��� ��ȣ ����/��ȯ�� �ڷ�(������,Ÿ��)
    L_MEM_ID MEMBER.MEM_ID%TYPE; -- �ش������� ���� ū ��ٱ��Ϲ�ȣ�� ������ ȸ����ȣ
    L_DATE CHAR(8):=TO_CHAR(P_DATE,'YYYYMMDD');
    BEGIN
     -- �ش� ������ ���� �� ���
     SELECT COUNT(*) INTO L_CNT
     FROM CART
     WHERE CART_NO LIKE L_DATE||'%';
     IF L_CNT=0 THEN
        L_CART_NO:=L_DATE||TRIM('00001');
        ELSE
        --�ش������� ���� ū ��ٱ��� ��ȣ 
        SELECT MAX(CART_NO) INTO L_CART_NO
        FROM CART
        WHERE SUBSTR(CART_NO,1,8)=L_DATE;
        -- ���� ū ��ٱ��� ��ȣ�� ������ ȸ����ȣ 
        SELECT DISTINCT MEM_ID INTO L_MEM_ID
        FROM CART
        WHERE CART_NO=L_CART_NO;
        
        IF L_MEM_ID != P_MEM_ID THEN
            L_CART_NO:=L_CART_NO+1;
            END IF;
        END IF;
        RETURN L_CART_NO;
    END;


      
      SELECT fn_create_cart_no(TO_DATE('20200409'),'k001') FROM DUAL;
      
      
      ��뿹) 2020�� 4�� 8�� 't001' ȸ���� 'P20100007' ��ǰ 2���� ������ ���� ó���Ͻÿ�.
      
      CREATE OR REPLACE PROCEDURE proc_cart_insert(
    P_DATE    IN DATE,
    P_MEM_ID  IN MEMBER.MEM_ID%TYPE,
    P_PROD_ID IN VARCHAR2,
    P_QTY     IN NUMBER
) AS
  L_MILEAGE NUMBER := 0; -- ���ϸ��� ��� ����
BEGIN
  -- CART INSERT
  INSERT INTO CART (MEM_ID, CART_NO, PROD_ID, CART_QTY)
  VALUES (
    P_MEM_ID,
    fn_create_cart_no(TO_DATE('20200408','YYYYMMDD'), P_MEM_ID),
    P_PROD_ID,
    P_QTY
  );

  -- REMAIN UPDATE
  UPDATE REMAIN
     SET REMAIN_O    = REMAIN_O + P_QTY,
         REMAIN_J_99 = REMAIN_J_99 - P_QTY,
         REMAIN_DATE = P_DATE
   WHERE PROD_ID = P_PROD_ID;

  -- MEMBER ���ϸ��� ����
  SELECT PROD_MILEAGE * P_QTY
    INTO L_MILEAGE
    FROM PROD
   WHERE PROD_ID = P_PROD_ID;

  UPDATE MEMBER
     SET MEM_MILEAGE = MEM_MILEAGE + L_MILEAGE
   WHERE MEM_ID = P_MEM_ID;

  COMMIT;
END;

      ����)
      EXECUTE proc_cart_insert(TO_DATE('20200408'),'t001','P201000007',2);
      