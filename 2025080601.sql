2025-0808-01)�����ڷ�
 - RAW,BFILE, BLOB Ÿ���� ������.
 - �������·� ����� �ڷ�� ����Ŭ���� ����� �ؼ��ϰų� ��ȯ���� ����.

 1. RAW(ũ��)
   - ���� ���� ũ���� �����ڷ� ����.
   - �ִ� 2000BYTE �����ڷḦ 2������ 16���� ���·� ����.
   - INDEX ó���� ����.
   
   ��� ���� ) 
   �÷��� RAW(ũ��)
   

��뿹)
 CREATE TABLE TBL_RAW(
    COL1 RAW(100),
    COL2 RAW(2000)
  );
  
  INSERT INTO TBL_RAW(COL1, COL2) VALUES('1010010111111100', HEXTORAW('A5FC'));
  
  SELECT * FROM TBL_RAW;
  
  
2. BFILE 
  - ���� ���� ũ���� �����ڷ� ����
  - �ִ� 4�Ⱑ����Ʈ �����ڷḦ ���̺� �ۿ� ����.
  - ���̺� �ȿ��� ��ο� ���ϸ��� ����.
  - INDEX ó���� ����
  - ���� ������ ���ϴ� �����͸� �����ϴµ� ������.


������� )
    �÷��� BFILE

��뿹 ) 
    (1)���̺�� ���� �����Ͱ� �غ� �Ǿ� �־�� ��.
    CREATE TABLE TBL_BFILE(
    COL1 BFILE 
    );
    
    (2)���丮��ü ����.
    CREATE [OR REPLACE] DIRECTORY ���丮��Ī  AS '�����θ�'
    
    CREATE OR REPLACE DIRECTORY TEST_DIR AS 'D:\A_TeachingMaterial\02_Oracle\workspace';

    (3)����.
    
    INSERT INTO TBL_BFILE VALUES (BFILENAME ('TEST_DIR','PETIE.jpg'));
    
    SELECT * FROM TBL_BFILE;
    
    DROP TABLE TBL_BLOB;
    DROP SEQUENCE seq_blob;
  
3. BLOB
    - CHLEO 4�Ⱑ����Ʈ �����ڷḦ ���̺� ���ο� ����.
    - ���� ������� �ʴ� ������ ���� ���忡 ������ ��ﱸ��.
    - �ڷ� ����� ����, ������ PL/SQL����� �䱸��

�������)
    �÷��� BLOB;
    
��뿹)
    (1) TABLE ����.
    CREATE TABLE TBL_BLOB(
    FILE_ID NUMBER, 
    FILE_NAME BLOB
  );
  

    (2)������ ����
    CREATE SEQUENCE seq_blob
        START WITH 1;
    
    (3)���丮 ��ü ���� - ������ ��ü ���(TEST_DIR)
    
    (4)�ڷ� ������ ���� ���ν��� ����
    CREATE OR REPLACE PROCEDURE blob_insert(V_FILE_NAME IN VARCHAR2)
    IS
        V_LOCATOR_BLOB BLOB;
        V_SOURCE_DATAFILE  BFILE := BFILENAME('TEST_DIR', V_FILE_NAME);
        V_DEST_OFFSET NUMBER:=1;
        V_SRC_OFFSET NUMBER:=1;
    BEGIN
        INSERT INTO TBL_BLOB(FILE_ID,FILE_NAME) VALUES(seq_blob,NEXTVAL,EMPTY_BLOB())
            RETURNING FILE_NAME INTO V_LOCATOR_BLOB;
            
            
        DBMS_LOB.OPEN(V_SOURCE_DATAFILE, DBMS_LOB.LOB_READONLY);
        DBMS_LOB.LOADBLOBFROMFILE(V_LOCATOR_BLOB,
                                  V_SOURCE_DATAFILE,
                                  DBMS_LOB.GETLENGTH(V_SOURCE_DATAFILE),
                                  V_DEST_OFFSET,
                                  V_SRC_OFFSET);
    DBMS_LOB.CLOSE(V_SOURCE_DATAFILE);
    COMMIT; 
    END;
  
[����]
    EXECUTE blob_insert('PETIE.jpg');
    
    SELECT * FROM TBL_BLOB;
  