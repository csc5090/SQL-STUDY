2025-08-27-02) VIEW ��ü
  - ��� ������ ���̺�
  - SELECT ���� �������(PL/SQL������ CURSOR��� ��)
  - VIEW�� ����ϴ� ���� 
    .�ʿ��� ������ �� ���� ���̺� ���� �ʰ�, �������� ���̺� �л�Ǿ� �ִ� ���
    .���̺� ��� �ִ� �ڷ��� �Ϻκи� �ʿ��ϰ� �ڷ��� ��ü ROW�� COLUMN�� �ʿ����� ���� ���.
    .Ư���ڷῡ ���� ������ �����ϰ��� �� ���(����)
    
(���� ����)
 CREATE [OR REPLACE] [FORCE|NOFORCE] VIEW ���̸�[(�÷���,...)]
 AS
    SELECT ��
        [WITH CHECK OPTION]
        [WITH READ ONLY]
    .'OR REPLACE' : �̹� ������ �̸��� �䰡 �����Ѵٸ� ������, ���ٸ� ���Ӱ� ������.
    .FORCE : ������ ���̺�, �÷�, �Լ� ���� �Ϻ� �������� �ʾƵ� ��� ������(INVALID ����).(SELECT���� ������ �־ �� ��ü�� �������)
    .NOFORCE : ������ ���̺�, �÷�, �Լ� ���� ���������� �����ؾ߸� �並 ����(default).(SELECT���� ������ ����� �䰡 �������)
    .'���̸�[(�÷���,...)]' : �信�� ����� �÷��� ���. �����ϸ� SELECT���� ��Ī�� ���� �÷����� �ǰ�,
     ��Ī�� �����Ǹ� SELECT ���� �÷����� ���� �÷����� ��.
    .'WITH CHECK OPTION' : ������� ���� SELECT ���� WHERE ������ �����ϴ� DML�����
      �並 ������� ������ �� ����(���� ���̺��� ���Ѿ��� DML��� ��� ����)
    .'WITH READ ONLY' : �б� ���� �並 ����
    .WITH READ ONLY �� WITH CHECK OPTION�� ���� ����� �� ����.
    
    -�� ���� ���ǻ���
      .�並 ������ �� ��������(WITH)�� �ִ� ���, ORDER BY �� ����� �Ұ�����.
      .�䰡 �����Լ�, GROUP BY ��, DISTINCT�� ����Ͽ� ������� ��� INSERT, UPDATE, DELETE ������ ����� �� ����.
      .��� �÷��� ǥ����, �Ϲ��Լ��� ���Ͽ� ������� ��� �ش� �÷��� �߰� �� �����Ұ���
      .CURRVAL, NEXTVAL �ǻ��÷�(pseudo column) ��� �Ұ�
      .ROWID, ROWNUM, LEVEL �ǻ��÷��� ��� �� ��� AS�� ����ؾ� ��.
      

        
��뿹) ȸ�����̺��� ���ϸ����� 10000����Ʈ �̻��� ȸ���� ȸ����ȣ, ȸ����, ���ϸ�����
       ��ȸ�Ͽ� �並 �����Ͻÿ�.
      
CREATE OR REPLACE VIEW view_mileage(MID,NAME,MILEAGE)
AS 
  SELECT MEM_ID AS ȸ����ȣ,
         MEM_NAME AS ȸ����,
         MEM_MILEAGE AS ���ϸ���
  FROM MEMBER
  WHERE MEM_MILEAGE >= 10000;

SELECT * FROM VIEW_MILEAGE;

1) ȸ�����̺��� �ڷ� �� 'u001'ȸ���� ���ϸ���(6564)�� 10500���� �����Ͻÿ�

  UPDATE MEMBER
  SET MEM_MILEAGE=10500
  WHERE MEM_ID='u001';
  
  
2) VIEW_MILEAGE���̺��� 'u001'ȸ�� ������ �����Ͻÿ�.

SELECT * FROM VIEW_MILEAGE;

DELETE FROM VIEW_MILEAGE 
WHERE MEM_ID='u001';

3) VIEW_MILEAGE ���� 'u001'���ϸ����� 1000���� �����ϱ�

CREATE OR REPLACE VIEW view_mileage
AS
SELECT MEM_ID AS ȸ����ȣ,MEM_NAME AS ȸ����, MEM_MILEAGE AS ���ϸ���
FROM MEMBER
WHERE MEM_MILEAGE>=10000
WITH CHECK OPTION;

UPDATE VIEW_MILEAGE
SET ���ϸ���=1000
WHERE ȸ����ȣ='u001';


-- f001 �ſ��� 16506
4) �� VIEW_MILEAGE���� 'f001' ȸ���� ���ϸ���(16506)�� 9000����Ʈ�� �����Ͻÿ�.

SELECT * FROM VIEW_MILEAGE;

UPDATE VIEW_MILEAGE
SET ���ϸ���=9000
WHERE ȸ����ȣ='f001';

INSERT INTO VIEW_MILEAGE VALUES('a002','�����ֿ�ȿ',12000);

5) MEMBER ���̺��� 'a002' ȸ���� ���ϸ����� 1200���� �����Ͻÿ�.

UPDATE MEMBER 
SET MEM_MILEAGE=1200
WHERE MEM_ID='a002';


**�÷����� �����ϰ� WITH READ ONLY�� ����� �並 �����ϱ�.

CREATE OR REPLACE VIEW VIEW_MILEAGE
AS
SELECT MEM_ID AS ȸ����ȣ,MEM_NAME AS ȸ����,MEM_MILEAGE AS ���ϸ���
FROM MEMBER
WHERE MEM_MILEAGE>=10000
WITH READ ONLY;

SELECT * FROM VIEW_MILEAGE;

6) �� VIEW_MILEAGE���� 'f001' ȸ���� ���ϸ���(16506)�� 9000����Ʈ�� �����Ͻÿ�.

UPDATE VIEW_MILEAGE
SET MEM_MILEAGE=9000
WHERE MEM_ID='f001';

4-1) �� ���̸������� f001 ȸ���� ���ϸ����� 19000����Ʈ�� �����Ͻÿ�.

UPDATE VIEW_MILEAGE
SET ���ϸ���=16506
WHERE ȸ����ȣ='f001';

UPDATE MEMBER
SET MEM_MILEAGE=16506
WHERE MEM_ID='f001';