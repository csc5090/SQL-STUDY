2025_0805_
���ڿ�, ����, ��¥, ��Ÿ (2�� �ڷ�)
1. ���� �ڷ�
  - ' ' �ȿ� ����� �ڷ�
  - ���� ���� : char, nchar
  - ���� ���� : varchar2, varchar, long, clob, , nvarchar, nvarchar2, nclob
  
  ��뿹)
   CREATE TABLE TBL_CHAR(
     COL1 CHAR(20),
     COL2 CHAR(20 BYTE),
     COL3 CHAR(20 CHAR)
);

 INSERT INTO TBL_CHAR(COL1, COL2, COL3) VALUES ('������ �߱�', '������ �߱� ','������ �߱� ���� 846')

 SELECT * FROM TBL_CHAR;

 SELECT LENGTHB (COL1),
        LENGTHB (COL2),
        LENGTHB (COL3)
    FROM TBL_CHAR;

��뿹)
 CREATE TABLE TBL_VARCHAR2(
    COL1 VARCHAR2(50),
    COL2 VARCHAR2(50),
    COL3 VARCHAR2(4000 CHAR)
  );
  
  INSERT INTO TBL_VARCHAR2  VALUES('������ �߱� ���� 846','������ �߱� ���� 846',
                                   '������ �߱� ���� 846');
                                   
  SELECT * FROM TBL_VARCHAR2;
--*�� ��� ��(ALL)�� �ǹ�.


 SELECT LENGTHB (COL1),
        LENGTHB (COL2),
        LENGTHB (COL3)
    FROM TBL_CHAR;
    
    
    
    
    
��뿹)
  CREATE TABLE TBL_LOB(
    COLI LONG,
   -- COL2 LONG,
    COL3 CLOB,
    COL4 CLOB,
    COL5 CLOB
 );
 
  SELECT  --LENGTHB (COL1),
        LENGTH (COL3),
        DBMS_LOB.GETLENGTH (COL4)
    FROM TBL_LOB;
 
  INSERT INTO TBL_LOB(COLI, COL3, COL4) VALUES('������ �߱� ���� 846','������ �߱� ���� 846',
                                               'IL POSTINO BOYHOOD');
                                               
                                
                        
2. ���� �ڷ���

  - NUMBER[(*|P [,S])]
  - INTEGER, BINARY_FLOAT, BINARY_DOUBLE, ���� ������.
  
1) NUMBER [(*|P [,S])]
  . �⺻ �����ڷ���
  . P(PRECISION) : ��ü �ڸ����� ���ϴ� ��. 1~38 ������ ���� ���
  . S(SCALE) : ��� �Ҽ��� ������ �ڸ����� S+1��° �ڸ����� �ݿø��Ͽ� ����
               ���� : �ش� ���� �ڸ����� �ݿø��Ǿ� ����
  . P ��� *�� ����ϸ� ��ü �ڸ��� �ý��ۿ��� �Ƿ� 
  . '(*|F[,S])' �����Ǹ� ����ڰ� �Է��� �����͸� ���� ���� ������

��뿹)
           CREATE TABLE TBL_NUMBER(
        COL1 NUMBER,
        COL2 NUMBER(3),
        COL3 NUMBER(3,2),
        COL4 NUMBER(5,2),
        COL5 NUMBER(7,1),
        COL6 NUMBER(7,-1),
        COL7 NUMBER(7,-2),
        COL8 NUMBER(*,2),
        COL9 NUMBER(4,5),
        COL10 NUMBER(4,7),
        COL11 NUMBER(3,4),
        COL12 NUMBER(4,6)
    );
    
    INSERT INTO TBL_NUMBER
        VALUES(
            456.73, --COL1
            456.73, --COL2
            6.73, --COL3 NUMBER (3,2)
            456.73, --COL4
            456.77, --COL5
            50456.73, --COL6
            12456.73, --COL7
            12456.7393, --COL8
            0.01234,--COL9
            0.0001234, --COL10
            0.0012, --COL11
            0.00123789 --COL12
            );
           

3. ��¥ Ÿ��
  - DATE, TIMESTAMP, TIMESTAMP WITH TIME ZONE, TIMESTAMP WITH LOCAL TIME ZONE
  - ������ Ÿ������ ������ �÷��� '+', '-'�� ����� ��.
  
  
  
  
  ��뿹)
   CREATE TABLE TBL_DATE(
     COL1 DATE,
     COL2 DATE,
     COL3 DATE
);

  INSERT INTO TBL_DATE VALUES(SYSDATE, SYSDATE-5, SYSDATE+26);
  
  SELECT * FROM TBL_DATE;
  
  (�ð�ǥ�� ��� : ���� �Ӽ� ����)
   ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
   
   SELECT * FROM TBL_DATE;
   
   
   
   (�ð�ǥ�� ��� : ��ȯ�Լ� ���)
   
   SELECT TO_CHAR(COL1, 'YYYY/MM/DD HH24:MI:SS'),
          TO_CHAR(COL2, 'YYYY/MM/DD HH24:MI:SS'),
          TO_CHAR(COL3, 'YYYY/MM/DD HH24:MI:SS')
     FROM TBL_DATE;
     
    SELECT '1992�� 2�� 17����' ||
        CASE MOD((TO_DATE('1992-02-17') - TO_DATE('00010101')-1),7) 
           WHEN 0 THEN '�Ͽ���'
           WHEN 1 THEN '������'
           WHEN 2 THEN 'ȭ����'
           WHEN 3 THEN '������'
           WHEN 4 THEN '�����'
           WHEN 5 THEN '�ݿ���'
           ELSE '�����'
        END AS ����
    FROM TBL_DATE;
      
    
    
    
��뿹 )
   CREATE TABLE TBL_TIMESTAMP (
     COL1 TIMESTAMP,
     COL2 TIMESTAMP WITH TIME ZONE,
     COL3 TIMESTAMP WITH LOCAL TIME ZONE
  );
  
  
    INSERT INTO TBL_TIMESTAMP VALUES(SYSDATE, SYSDATE, SYSDATE);
    INSERT INTO TBL_TIMESTAMP VALUES(SYSTIMESTAMP, SYSTIMESTAMP, SYSTIMESTAMP);
    
    SELECT * FROM TBL_TIMESTAMP;
    
    