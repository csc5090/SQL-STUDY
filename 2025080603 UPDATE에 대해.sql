2025-0806-03) UPDATE�� ����

    - ���̺� ������ �ڷḦ ����
�������)
    UPDATE ���̺�� 
        SET �÷���=��
            �÷���=��[,]
            �÷���=��[,]
             :
             :
            �÷���=��
    (WHERE ����);
 
     . WHERE���� �����ȴٸ� ���̺��� ��� �ڷᰡ ������.
       WHERE ���� ��� "��"�� ����.
       

��뿹) HR ������ EMPLOYEES ���̺��� �Ի����� 5�� �ķ� �����Ͻÿ�.

    UPDATE C##HR.EMPLOYEES
        SET HIRE_DATE=ADD_MONTHS(HIRE_DATE,24);
        

COMMIT;


** CUSTOMERS ���̺� ����

    CREATE TABLE CUSTOMERS
    AS
        SELECT * FROM MEMBER;
        
        
��뿹)CUSTOMERS ���̺��� 1000�̸��� ȸ���� MEM_DELETE �÷��� ����
      'Y'�� �����ϰ� MEM_PASS�÷��� NULL���� �Է��Ͻÿ�.
      
      UPDATE CUSTOMERS
        SET MEM_DELETE='Y',
            MEM_PASS=NULL
        WHERE MEM_MILEAGE<1000;
        

ROLLBACK;


