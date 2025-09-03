2025-09-02-02) 트리거(TRIGGER)
  - 특정 테이블에 발생된 이벤트에 의해 다른 테이블이 자동으로 변경되도록 하기위해
    사용되는 특수 프로시저
사용형식)
    CREATE [OR REPLACE] TRIGGER 트리거 이름 
    {AFTER|BEFORE} {INSERT | UPDATE | DELETE} ON 테이블명
    [FOR EACH ROW]
    [WHEN 조건]
    [DECLARE]
    선언영역
    BEGIN
    트리거 본문
    
    END;
    . 'AFTER|BEFORE' : 트리거 타이밍으로 '트리거 본문'이 이벤트('INSERT | UPDATE | DELETE')
      발생 후(AFTER), 발생 전(BEFORE)에 실행 되어야 하는지 결정.
    . 'INSERT | UPDATE | DELETE':이벤트로 OR 연산자로 조합도 가능함
    . 'FOR EACH ROW': 행단위 트리거를 발생시키기 위해 기술. 생략하면 문장단위 트리거가 됨.
    . 'WHEN 조건' : 행단위 트리거에서만 사용 가능하며 트리거가 발생될 좀 더 구체적인 조건을 명시
    . 하나의 트리거가 완성(완전히 실행)되기 전에 또 다른 트리거 호출은 금지되며 이를 어기면 해당 테이블의 
      접근이 모두 차단됨
    
    (트리거 의사 레코드)
    :NEW => INSERT, UPDATE 이벤트에 사용되어 새로 입력되는 자료를 지칭한다.
            DELETE 이벤트에 사용되면 모든 컬럼이 NULL값으로 반환됨.
            ex) CART 테이블에 INSERT 이벤트 발생시 트리거가 수행된다면
                INSERT 된 CART 테이블의 MEM_ID, CART_NO, PROD_ID, CART_QTY는 
                :NEW.MEM_ID, :NEW.CART_NO, :NEW.PROD_ID, :NEW.CART_QTY로 참조할 수 있다.
                
    :OLD => DELETE, UPDATE 이벤트에 사용되어 저장되어 있던 자료를 지칭한다.
            INSERT 이벤트에 사용되면 모든 컬럼이 NULL값으로 반환됨
            ex) CART 테이블에 DELETE 이벤트 발생시 트리거가 수행된다면
                DELETE된 CART 테이블의 MEM_ID, CART_NO, PROD_ID, CART_QTY는
                :OLD.MEM_ID, :OLD.CART_NO, :OLD.PROD_ID, :OLD.CART_QTY 로 참조할 수 있다.
                
(트리거 함수-이벤트가 여러개의 DML명령으로 구성된 경우 이벤트의 종류를 구별하기 위해서 사용)
  . INSERTING : INSERT 이벤트가 발생된 것이면 참(TRUE)을 반환
  . UPDATING : UPDATE 이벤트가 발생된 것이면 참(TRUE)을 반환
  . DELETING : DELETE 이벤트가 발생된 것이면 참(TRUE)을 반환
  
  
사용예) 분류테이블에서 분류코드 'P501' 자료를 삭제하면, "자료삭제가 성공적으로 수행되었습니다."를 출력하는 
       트리거를 만들기.
       
CREATE OR REPLACE TRIGGER tg_delall_lprod
AFTER DELETE ON LPROD
BEGIN
DBMS_OUTPUT.PUT_LINE('자료삭제가 성공적으로 수행되었습니다.');
END;


[실행]
DELETE FROM LPROD WHERE LPROD_ID>=11; 


사용예) EMP 테이블의 자료 중 2018년 12월 31일 이전 입사자를 퇴직처리 하기.
        퇴직처리 : 퇴직자 정보를 EMP테이블에서 삭제하고, 그 사원 정보-사원번호, 부서번호, 입사일, 직무코드를 RETIRE 테이블에 보관할 것.
        
    CREATE OR REPLACE TRIGGER  tg_retire_emp
    BEFORE DELETE ON EMP
    FOR EACH ROW
    BEGIN
    INSERT INTO RETIRE VALUES(:OLD.EMPLOYEE_ID,:OLD.DEPARTMENT_ID,:OLD.HIRE_DATE,:OLD.JOB_ID);
    END;
    
    DELETE FROM EMP WHERE HIRE_DATE<=TO_DATE('20181231');
    


사용예)


트리거 생성
    CREATE OR REPLACE TRIGGER tg_change_cart
    AFTER INSERT OR UPDATE OR DELETE ON CART
    FOR EACH ROW
    DECLARE
    L_MEM_ID MEMBER.MEM_ID%TYPE;
    L_PROD_ID PROD.PROD_ID%TYPE;
    L_QTY NUMBER:=0;
    L_DATE DATE;
    L_MILEAGE NUMBER:=0;
    
    BEGIN
    
    IF INSERTING THEN
        L_QTY:=(:NEW.CART_QTY);
        L_PROD_ID:=(:NEW.PROD_ID);
        L_DATE:=TO_DATE(SUBSTR(:NEW.CART_NO,1,8));
        L_MEM_ID:=(:NEW.MEM_ID);
    ELSIF UPDATING THEN 
        L_QTY:=(:NEW.CART_QTY)-(:OLD.CART_QTY);
        L_PROD_ID:=(:NEW.PROD_ID);
        L_DATE:=TO_DATE(SUBSTR(:NEW.CART_NO,1,8));
        L_MEM_ID:=(:NEW.MEM_ID);
    ELSIF DELETING THEN
        L_QTY:=-(:OLD.CART_QTY);
        L_PROD_ID:=(:OLD.PROD_ID);
        L_DATE:=TO_DATE(SUBSTR(:OLD.CART_NO,1,8));
        L_MEM_ID:=(:OLD.MEM_ID);
    END IF;
    
    --REMAIN TABLE UPDATE 
    UPDATE REMAIN
        SET REMAIN_O=REMAIN_O+L_QTY,
            REMAIN_J_99=REMAIN_J_99 - L_QTY,
            REMAIN_DATE=L_DATE
        WHERE PROD_ID=L_PROD_ID
        AND REMAIN_YEAR=TO_CHAR(EXTRACT(YEAR FROM L_DATE));
        
    --MEMBER TABLE UPDATE 
    SELECT PROD_MILEAGE * L_QTY INTO L_MILEAGE
    FROM PROD
    WHERE PROD_ID=L_PROD_ID;
    
    UPDATE MEMBER
    SET MEM_MILEAGE=MEM_MILEAGE+L_MILEAGE
    WHERE MEM_ID=L_MEM_ID;
    
    
    END;
    
    INSERT INTO CART VALUES('b001',fn_create_cart_no(TO_DATE('20200719'),'b001'),'P202000004',10);
    
    UPDATE CART 
    SET CART_QTY=7
    WHERE PROD_ID='P202000004'
    AND MEM_ID='b001'
    AND CART_NO LIKE '20200719%';
    
    DELETE FROM CART
    WHERE PROD_ID='P202000004'
    AND MEM_ID='b001'
    AND CART_NO LIKE '20200719%';