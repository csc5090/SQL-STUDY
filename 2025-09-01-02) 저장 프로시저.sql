2025-09-01-02) ���� ���ν���(Stored procedure : Procedure)
 - ��ȯ���� ���� ���
 - Ư¡�� ������ PL/SQL�� BLOCK�� ������
 
 �������)
 CREATE [OR REPLACE] PROCEDURE ���ν�����[(
    ������ [IN|OUT|INOUT] Ÿ�Ը�,...)
    {AS|IS}
     ���𿵿�
    BEGIN 
        ���࿵��
        
        [EXCEPTION
            ����ó��;
        ]
        END;
        
    . 'IN|OUT|INOUT' : ������ ����(MODE)�� IN�� �Է¿��̰�, OUT�� ��¿�, INOUT�� ����¿����� �����Ǹ�
                       �����ϸ� IN���� ���ֵ�
    . ��ȯ ���� ������ OUT���� �Ϻ� �ڷ�� ��ȯ�� ������
    . �ַ� DML����� ������ ��(��ȯ ���� ���� ��) ����

[����]
  . OUT �Ű������� ���� ��
    EXECUTE | EXEC ���ν�����[(��list...)];
    
  . OUT �Ű������� ���� �� - �͸����̳� �ٸ� ���ν��� �Ǵ� �Լ� ���ο��� ȣ�� �ؾ� ��.
    
    ���ν�����[(��list...,����list)];
      - ����list : ��ȯ�ϴ� ���� ������ ����list
      
      
��뿹) ���� �ڷ�(��ǰ�ڵ�, ����)�� �Է¹޾� �������̺� �����ϴ� ���ν����� �ۼ��Ͻÿ�.
        ��¥�� �ý��� ��¥�� ����
    CREATE OR REPLACE PROCEDURE prod_insert_buyprod(
        P_PROD_ID  PROD.PROD_ID%TYPE, P_QTY IN NUMBER)
     AS
     BEGIN
        INSERT INTO BUYPROD VALUES(SYSDATE, P_PROD_ID,P_QTY);
        COMMIT;
    END;
    
    EXECUTE PROD_INSERT_BUYPROD(

