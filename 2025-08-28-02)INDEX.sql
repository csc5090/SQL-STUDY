2025-08-28-02)INDEX

�������)
  CREATE [OR REPLACE] [BITMAP|UNIQUE] INDEX �ε����� 
  ON ���̺��(�÷���,...) [ASC|DESC]
  .ASC|DESC : �������� �Ǵ� �������� �ε��� ���� �⺻�� ����������
  .BITMAP|UNIQUE : �⺻�� NONUNIQUE INDEX ��
  
  
��뿹) ������̺��� ����� 'James Landry'�� �ڷḦ ��ȸ
 SELECT *
 FROM C##HR.EMPLOYEES
 WHERE EMP_NAME = 'James Landry'

��������� �ε��� ����
CREATE INDEX C##HR.idx_emp_name
  ON C##HR.EMPLOYEES(EMP_NAME);
  
  SELECT *
  FROM C##HR.EMPLOYEES
  WHERE EMP_NAME = 'James Landry';
  
  
  
  ** INDEX�� �籸��
  - �ڷ��� ����/������ �뷮 �߻��� ��.
  - ���̺����̽��� ����� ��.
  
�������)
  ALTER INDEX �ε����� REBUILD
  
  ALTER INDEX C##HR.idx_emp_name REBUILD;