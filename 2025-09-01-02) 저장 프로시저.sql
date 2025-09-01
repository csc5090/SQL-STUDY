2025-09-01-02) 저장 프로시저(Stored procedure : Procedure)
 - 반환값이 없는 모듈
 - 특징과 장점은 PL/SQL의 BLOCK과 동일함
 
 사용형식)
 CREATE [OR REPLACE] PROCEDURE 프로시저명[(
    변수명 [IN|OUT|INOUT] 타입명,...)
    {AS|IS}
     선언영역
    BEGIN 
        실행영역
        
        [EXCEPTION
            예외처리;
        ]
        END;
        
    . 'IN|OUT|INOUT' : 변수의 성경(MODE)로 IN은 입력용이고, OUT은 출력용, INOUT은 입출력용으로 설정되며
                       생략하면 IN으로 간주됨
    . 반환 값이 없으나 OUT으로 일부 자료는 반환이 가능함
    . 주로 DML명령을 수행할 때(반환 값이 없을 때) 사용됨

[실행]
  . OUT 매개변수가 없을 때
    EXECUTE | EXEC 프로시저명[(값list...)];
    
  . OUT 매개변수가 있을 때 - 익명블록이나 다른 프로시저 또는 함수 내부에서 호출 해야 함.
    
    프로시저명[(값list...,변수list)];
      - 변수list : 반환하는 값을 보관할 변수list
      
      
사용예) 매입 자료(상품코드, 수량)를 입력받아 매입테이블에 저장하는 프로시저를 작성하시오.
        날짜는 시스템 날짜로 설정
    CREATE OR REPLACE PROCEDURE prod_insert_buyprod(
        P_PROD_ID  PROD.PROD_ID%TYPE, P_QTY IN NUMBER)
     AS
     BEGIN
        INSERT INTO BUYPROD VALUES(SYSDATE, P_PROD_ID,P_QTY);
        COMMIT;
    END;
    
    EXECUTE PROD_INSERT_BUYPROD(

