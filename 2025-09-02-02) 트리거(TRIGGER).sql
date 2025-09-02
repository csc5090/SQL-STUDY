2025-09-02-02) Ʈ����(TRIGGER)
  - Ư�� ���̺� �߻��� �̺�Ʈ�� ���� �ٸ� ���̺��� �ڵ����� ����ǵ��� �ϱ�����
    ���Ǵ� Ư�� ���ν���
�������)
    CREATE [OR REPLACE] TRIGGER Ʈ���� �̸� 
    {AFTER|BEFORE} {INSERT | UPDATE | DELETE} ON ���̺��
    [FOR EACH ROW]
    [WHEN ����]
    [DECLARE]
    ���𿵿�
    BEGIN
    Ʈ���� ����
    
    END;
    . 'AFTER|BEFORE' : Ʈ���� Ÿ�̹����� 'Ʈ���� ����'�� �̺�Ʈ('INSERT | UPDATE | DELETE')
      �߻� ��(AFTER), �߻� ��(BEFORE)�� ���� �Ǿ�� �ϴ��� ����.
    . 'INSERT | UPDATE | DELETE':�̺�Ʈ�� OR �����ڷ� ���յ� ������
    . 'FOR EACH ROW': ����� Ʈ���Ÿ� �߻���Ű�� ���� ���. �����ϸ� ������� Ʈ���Ű� ��.
    . 'WHEN ����' : ����� Ʈ���ſ����� ��� �����ϸ� Ʈ���Ű� �߻��� �� �� ��ü���� ������ ���
    . �ϳ��� Ʈ���Ű� �ϼ�(������ ����)�Ǳ� ���� �� �ٸ� Ʈ���� ȣ���� �����Ǹ� �̸� ���� �ش� ���̺��� 
      ������ ��� ���ܵ�
    
    (Ʈ���� �ǻ� ���ڵ�)
    :NEW => INSERT, UPDATE �̺�Ʈ�� ���Ǿ� ���� �ԷµǴ� �ڷḦ ��Ī�Ѵ�.
            DELETE �̺�Ʈ�� ���Ǹ� ��� �÷��� NULL������ ��ȯ��.
            ex) CART ���̺� INSERT �̺�Ʈ �߻��� Ʈ���Ű� ����ȴٸ�
                INSERT �� CART ���̺��� MEM_ID, CART_NO, PROD_ID, CART_QTY�� 
                :NEW.MEM_ID, :NEW.CART_NO, :NEW.PROD_ID, :NEW.CART_QTY�� ������ �� �ִ�.
                
    :OLD => DELETE, UPDATE �̺�Ʈ�� ���Ǿ� ����Ǿ� �ִ� �ڷḦ ��Ī�Ѵ�.
            INSERT �̺�Ʈ�� ���Ǹ� ��� �÷��� NULL������ ��ȯ��
            ex) CART ���̺� DELETE �̺�Ʈ �߻��� Ʈ���Ű� ����ȴٸ�
                DELETE�� CART ���̺��� MEM_ID, CART_NO, PROD_ID, CART_QTY��
                :OLD.MEM_ID, :OLD.CART_NO, :OLD.PROD_ID, :OLD.CART_QTY �� ������ �� �ִ�.
                
(Ʈ���� �Լ�-�̺�Ʈ�� �������� DML������� ������ ��� �̺�Ʈ�� ������ �����ϱ� ���ؼ� ���)
  . INSERTING : INSERT �̺�Ʈ�� �߻��� ���̸� ��(TRUE)�� ��ȯ
  . UPDATING : UPDATE �̺�Ʈ�� �߻��� ���̸� ��(TRUE)�� ��ȯ
  . DELETING : DELETE �̺�Ʈ�� �߻��� ���̸� ��(TRUE)�� ��ȯ
  
  
��뿹) �з����̺��� �з��ڵ� 'P501' �ڷḦ �����ϸ�, "�ڷ������ ���������� ����Ǿ����ϴ�."�� ����ϴ� 
       Ʈ���Ÿ� �����.
       
CREATE OR REPLACE TRIGGER tg_delall_lprod
AFTER DELETE ON LPROD
BEGIN
DBMS_OUTPUT.PUT_LINE('�ڷ������ ���������� ����Ǿ����ϴ�.');
END;


[����]
DELETE FROM LPROD WHERE LPROD_ID>=11; 


��뿹) EMP ���̺��� �ڷ� �� 2018�� 12�� 31�� ���� �Ի��ڸ� ����ó�� �ϱ�.
        ����ó�� : ������ ������ EMP���̺��� �����ϰ�, �� ��� ����-�����ȣ, �μ���ȣ, �Ի���, �����ڵ带 RETIRE ���̺� ������ ��.
        
    CREATE OR REPLACE TRIGGER  tg_retire_emp
    BEFORE DELETE ON EMP
    FOR EACH ROW
    BEGIN
    INSERT INTO RETIRE VALUES(:OLD.EMPLOYEE_ID,:OLD.DEPARTMENT_ID,:OLD.HIRE_DATE,:OLD.JOB_ID);
    END;
    
    DELETE FROM EMP WHERE HIRE_DATE<=TO_DATE('20181231');
    

    