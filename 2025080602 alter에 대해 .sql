2025-0806-02) ALTER에 대해서
 - 객체의 구조 등을 변경하는 명령어.
 
1. 테이블명 변경
 ALTER TABLE old_table명 RENAME TO new_table명
 -테이블명만 바꾸는 것. 인덱스 및 데이터 변경 없음.
 -롤백의 대상이 아니라 다시 되돌리려면 한 번 더 리네임해야 함.
 
**
    CREATE TABLE C##CSC.EMP AS
        SELECT * FROM C##HR.EMPLOYEES;

사용예) HR 계정의 EMP테이블의 이름을 MEMBERS로 변경하시오.

ALTER TABLE EMP RENAME TO MEMBERS;

개체 삭제 명령은 DROP 객체종류 객체명 (드롭도 롤백 대상이 아님.)

    DROP TABLE MEMBERS;

ROLLBACK;

2. 테이블 수정 
  1)컬럼의 변경
    - 테이블 컬럼의 삽임,삭제 변경(자료타입이나 크기)을 수행.
    - ADD, MODIFY, DROP 연산자 사용.
사용형식)
    . ADD, MODIFY
      ALTER TABLE 테이블명 ADD|MODIFY (칼럼명 데이터 타입 [NOT NULL][DEFAULT 값]);
    
    . DROP 연산자
      ALTER TABLE 테이블명 DROP COLUMN 컬렴명;
      
사용예)HR계정의 EMPLOYEES테이블에 이름을 저장할 수 있는 EMP_NAME컬럼을 
      추가하시오. EMP_NAME은 VARCHAR2(45)크기를 가지고 있다.
      

ALTER TABLE EMPLOYEES ADD (EMP_NAME VARCHAR2(45));

사용예) EMP_NAME에 FIRST_NAME과 LAST_NAME의 데이터 중간에 ' '를 삽입하여 
       결합한 후 EMP_NAME에 삽입(UPDATE)하시오.
       
UPDATE EMPLOYEES
    SET EMP_NAME=FIRST_NAME||' '||LAST_NAME
    
        COMMIT;
        
        
사용예) EMPLOYEES 테이블에 LAST_NAME 컬럼을 삭제하세요.

    ALTER TABLE EMPLOYEES DROP COLUMN LAST_NAME;
    
    
  2)컬럼 이름의 변경
사용형식)
  ALTER TABLE 테이블명 RENAME COLUMN old_column명 TO new_column명;
  
  사용예)EMPLOYEES테이블에서 FIRST_NAME 컬럼을 'NAME'으로 변경하시오.
    ALTER TABLE EMPLOYEES RENAME COLUMN FIRST_NAME TO NAME;
    ALTER TABLE EMPLOYEES DROP COLUMN NAME;