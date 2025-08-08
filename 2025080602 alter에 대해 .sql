2025-0806-02) ALTER�� ���ؼ�
 - ��ü�� ���� ���� �����ϴ� ��ɾ�.
 
1. ���̺�� ����
 ALTER TABLE old_table�� RENAME TO new_table��
 -���̺�� �ٲٴ� ��. �ε��� �� ������ ���� ����.
 -�ѹ��� ����� �ƴ϶� �ٽ� �ǵ������� �� �� �� �������ؾ� ��.
 
**
    CREATE TABLE C##CSC.EMP AS
        SELECT * FROM C##HR.EMPLOYEES;

��뿹) HR ������ EMP���̺��� �̸��� MEMBERS�� �����Ͻÿ�.

ALTER TABLE EMP RENAME TO MEMBERS;

��ü ���� ����� DROP ��ü���� ��ü�� (��ӵ� �ѹ� ����� �ƴ�.)

    DROP TABLE MEMBERS;

ROLLBACK;

2. ���̺� ���� 
  1)�÷��� ����
    - ���̺� �÷��� ����,���� ����(�ڷ�Ÿ���̳� ũ��)�� ����.
    - ADD, MODIFY, DROP ������ ���.
�������)
    . ADD, MODIFY
      ALTER TABLE ���̺�� ADD|MODIFY (Į���� ������ Ÿ�� [NOT NULL][DEFAULT ��]);
    
    . DROP ������
      ALTER TABLE ���̺�� DROP COLUMN �÷Ÿ�;
      
��뿹)HR������ EMPLOYEES���̺� �̸��� ������ �� �ִ� EMP_NAME�÷��� 
      �߰��Ͻÿ�. EMP_NAME�� VARCHAR2(45)ũ�⸦ ������ �ִ�.
      

ALTER TABLE EMPLOYEES ADD (EMP_NAME VARCHAR2(45));

��뿹) EMP_NAME�� FIRST_NAME�� LAST_NAME�� ������ �߰��� ' '�� �����Ͽ� 
       ������ �� EMP_NAME�� ����(UPDATE)�Ͻÿ�.
       
UPDATE EMPLOYEES
    SET EMP_NAME=FIRST_NAME||' '||LAST_NAME
    
        COMMIT;
        
        
��뿹) EMPLOYEES ���̺� LAST_NAME �÷��� �����ϼ���.

    ALTER TABLE EMPLOYEES DROP COLUMN LAST_NAME;
    
    
  2)�÷� �̸��� ����
�������)
  ALTER TABLE ���̺�� RENAME COLUMN old_column�� TO new_column��;
  
  ��뿹)EMPLOYEES���̺��� FIRST_NAME �÷��� 'NAME'���� �����Ͻÿ�.
    ALTER TABLE EMPLOYEES RENAME COLUMN FIRST_NAME TO NAME;
    ALTER TABLE EMPLOYEES DROP COLUMN NAME;