2025-0808-01)이진자료
 - RAW,BFILE, BLOB 타입이 제공됨.
 - 이진형태로 저장된 자료는 오라클에서 절대로 해석하거나 변환하지 않음.

 1. RAW(크기)
   - 비교적 작은 크기의 이진자료 저장.
   - 최대 2000BYTE 이진자료를 2진수와 16진수 형태로 저장.
   - INDEX 처리가 가능.
   
   사용 형식 ) 
   컬럼명 RAW(크기)
   

사용예)
 CREATE TABLE TBL_RAW(
    COL1 RAW(100),
    COL2 RAW(2000)
  );
  
  INSERT INTO TBL_RAW(COL1, COL2) VALUES('1010010111111100', HEXTORAW('A5FC'));
  
  SELECT * FROM TBL_RAW;
  
  
2. BFILE 
  - 비교적 작은 크기의 이진자료 저장
  - 최대 4기가바이트 이진자료를 테이블 밖에 저장.
  - 테이블 안에는 경로와 파일명을 저장.
  - INDEX 처리가 가능
  - 자주 내용이 변하는 데이터를 관리하는데 용이함.


사용형태 )
    컬럼명 BFILE

사용예 ) 
    (1)테이블과 원본 데이터가 준비 되어 있어야 함.
    CREATE TABLE TBL_BFILE(
    COL1 BFILE 
    );
    
    (2)디렉토리객체 생성.
    CREATE [OR REPLACE] DIRECTORY 디렉토리별칭  AS '절대경로명'
    
    CREATE OR REPLACE DIRECTORY TEST_DIR AS 'D:\A_TeachingMaterial\02_Oracle\workspace';

    (3)삽입.
    
    INSERT INTO TBL_BFILE VALUES (BFILENAME ('TEST_DIR','PETIE.jpg'));
    
    SELECT * FROM TBL_BFILE;
    
    DROP TABLE TBL_BLOB;
    DROP SEQUENCE seq_blob;
  
3. BLOB
    - CHLEO 4기가바이트 이진자료를 테이블 내부에 저장.
    - 자주 변경되지 않는 ㅇ이진 정보 저장에 유리한 기억구조.
    - 자료 저장과 변경, 삭제에 PL/SQL명령이 요구됨

사용형식)
    컬럼명 BLOB;
    
사용예)
    (1) TABLE 생성.
    CREATE TABLE TBL_BLOB(
    FILE_ID NUMBER, 
    FILE_NAME BLOB
  );
  

    (2)시퀀스 생성
    CREATE SEQUENCE seq_blob
        START WITH 1;
    
    (3)디렉토리 객체 생성 - 생성된 객체 사용(TEST_DIR)
    
    (4)자료 삽입을 위한 프로시저 생성
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
  
[실행]
    EXECUTE blob_insert('PETIE.jpg');
    
    SELECT * FROM TBL_BLOB;
  