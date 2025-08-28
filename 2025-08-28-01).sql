2025-08-28-01) ������(sequence)
  - �ڵ����� ��ȣ�� �����ϱ� ���� ��ü.
  - Sequence ��ü�� ���̺�� �������̹Ƿ� ���������� ��� ����.
  - Sequence�� �̿��ϴ� ���
  1.Primary Key�� ������ �ĺ�Ű�� ���ų� PK�� Ư���� �ǹ��ְ� ������ �ʾƵ� �Ǵ� ���.
  2.�ڵ����� �������� ��ȣ�� �ʿ��� ���
  
�������(����)
  CREATE SEQUENCE ��������
    START WITH n    -- ���� �� ���� �����ϸ� MINVALUE�� ������.
    INCREMENT BY n   -- ������
    MAXVALUE n | NOMAXVALUE  -- �ִ밪 default�� NOMAXVALUE�� 10^27
    MINVALUE n | NOMINVALUE  -- �ּҰ� default�� NOMINVALUE�� 1
    CYCLE  |  NOCYCLE  -- �ִ� �Ǵ� �ּ� ������ ������ �� �ٽ� �������� �����ϴ� ���� CYCLE��. default NOCYCLE
    CACHE n  |  NOCACHE  -- ������ ���� ĳ�� �޸𸮿� �������� ���� default�� CACHE
    ORDER | NOORDER  -- �����Ѵ�� ������ ������ �㺸�ϸ� ORDER, default�� NOORDER
    
    
** ������ �� ������ �ǻ��÷�(Pseudo Column)
   ��������.NEXTVAL : ������ ��ü�� ���� �� �����Ͽ� ��ȯ
   ��������.CURRVAL : ������ ��ü�� ���� �� �����Ͽ� ��ȯ

*** �������� ������ �� ���� ���� ����ϴ� ����� ��������.NEXTVAL �̾�� ��
   
    
    
��뿹) �����ڷḦ LPROD ���̺� �����Ͻÿ�.

--------------------------------------------------------
  LPROD_ID            LPROD_GU             LPROD_NAME
-------------------------------------------------------- 
     10                 P501                 ��깰
     INSERT INTO LPROD(LPROD_ID,LPROD_GU,LPROD_NAME) VALUES(seq_lprod_id.NEXTVAL, 'P501', '��깰');
     SELECT * FROM LPROD;
     11                 P502                 �ӻ깰
     SELECT seq_lprod_id.CURRVAL FROM DUAL;
     INSERT INTO LPROD(LPROD_ID,LPROD_GU,LPROD_NAME) VALUES(seq_lprod_id.NEXTVAL, 'P502', '�ӻ깰');
     SELECT * FROM LPROD;
     12                 P503                 ���깰
     INSERT INTO LPROD(LPROD_ID,LPROD_GU,LPROD_NAME) VALUES(seq_lprod_id.NEXTVAL, 'P503', '���깰');
     SELECT * FROM LPROD;

 CREATE SEQUENCE seq_lprod_id 
 START WITH 10;
 
 SELECT seq_lprod_id.NEXTVAL FROM DUAL;
 
 INCREMENT BY