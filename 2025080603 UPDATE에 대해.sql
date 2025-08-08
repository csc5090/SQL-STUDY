2025-0806-03) UPDATE에 대해

    - 테이블 내부의 자료를 수정
사용형식)
    UPDATE 테이블명 
        SET 컬럼명=값
            컬럼명=값[,]
            컬럼명=값[,]
             :
             :
            컬럼명=값
    (WHERE 조건);
 
     . WHERE절이 생략된다면 테이블의 모든 자료가 수정됨.
       WHERE 절은 대상 "행"을 결정.
       

사용예) HR 계정의 EMPLOYEES 테이블의 입사일을 5년 후로 변경하시오.

    UPDATE C##HR.EMPLOYEES
        SET HIRE_DATE=ADD_MONTHS(HIRE_DATE,24);
        

COMMIT;


** CUSTOMERS 테이블 생성

    CREATE TABLE CUSTOMERS
    AS
        SELECT * FROM MEMBER;
        
        
사용예)CUSTOMERS 테이블에서 1000미만인 회원은 MEM_DELETE 컬럼의 값을
      'Y'로 변경하고 MEM_PASS컬럼은 NULL값을 입력하시오.
      
      UPDATE CUSTOMERS
        SET MEM_DELETE='Y',
            MEM_PASS=NULL
        WHERE MEM_MILEAGE<1000;
        

ROLLBACK;


