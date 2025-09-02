2025-09-02-01) 저장 프로시저(Stored procedure : Procedure)
 - 반환값이 없는 모듈
 - 특징과 장점은 PL/SQL의 BLOCK과 동일함
 
 사용형식)
 CREATE [OR REPLACE] PROCEDURE 프로시저명[(
    변수명 [IN|OUT|INOUT] 타입명,...)
    RETURN 변수명
    {AS|IS}
     선언영역
    BEGIN 
        실행영역
        RETURN 값|변수명; -- 실제 값을 반환.
        [EXCEPTION
            예외처리;
        ]
        END;
        
    . 'IN|OUT|INOUT' : 변수의 성경(MODE)로 IN은 입력용이고, OUT은 출력용, INOUT은 입출력용으로 설정되며
                       생략하면 IN으로 간주됨
    . 반환 값이 존재하며 보통 OUT 매개변수는 사용되지 않음
    . 주로 SELECT명령 등 반환값이 있는 명령에 사용됨
    
    사용예) 상품코드를 입력받아 2020년 6월 매출 합계와 매입합계를 구하는 함수를 작성하시오.
    
    CREATE OR REPLACE FUNCTION fn_sum_maeib(P_PROD_ID PROD.PROD_ID%TYPE)
      RETURN NUMBER
      AS
      L_MSUM NUMBER:=0; -- 매입금액합계 / 반환할 데이터 저장
      BEGIN
      SELECT SUM(A.BUY_QTY*B.PROD_COST) INTO L_MSUM
      FROM BUYPROD A 
      INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
      WHERE A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')
        AND A.PROD_ID=P_PROD_ID;
        RETURN L_MSUM;
        
        EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('오류 발생 : '||SQLERRM);
      END;
    
    
    
    
    매출은?
    
     CREATE OR REPLACE FUNCTION fn_sum_maechul(P_PROD_ID PROD.PROD_ID%TYPE)
      RETURN NUMBER
      AS
      L_CSUM NUMBER:=0; -- 매출금액합계 / 반환할 데이터 저장
      BEGIN
      SELECT SUM(A.CART_QTY*B.PROD_COST) INTO L_CSUM
      FROM CART A 
      INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
      WHERE A.CART_NO LIKE '202006%'
        AND A.PROD_ID=P_PROD_ID;
        RETURN L_CSUM;
        
        EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('오류 발생 : '||SQLERRM);
      END;
    
    --실행
    
    SELECT PROD_ID AS 상품코드,
           PROD_NAME AS 상품명,
           TO_CHAR(NVL(fn_sum_maeib(PROD_ID),0),'999,999,999') AS 매입금액합계,
           TO_CHAR(NVL(fn_sum_maechul(PROD_ID),0),'999,999,999') AS 매입합계
      FROM PROD
      ORDER BY 1;
      
      
      
      
함수만들기3) 장바구니번호를 생성하는 함수를 만들어보자.

CREATE OR REPLACE FUNCTION fn_create_cart_no(
    P_DATE IN DATE, P_MEM_ID IN MEMBER.MEM_ID%TYPE)
    RETURN CHAR
    AS
    L_CNT NUMBER:=0; -- 해당일자의 자료의 수
    L_CART_NO CART.CART_NO%TYPE; -- 임시 장바구니 번호 저장/반환할 자료(데이터,타입)
    L_MEM_ID MEMBER.MEM_ID%TYPE; -- 해당일자의 가장 큰 장바구니번호를 보유한 회원번호
    L_DATE CHAR(8):=TO_CHAR(P_DATE,'YYYYMMDD');
    BEGIN
     -- 해당 일자의 행의 수 계산
     SELECT COUNT(*) INTO L_CNT
     FROM CART
     WHERE CART_NO LIKE L_DATE||'%';
     IF L_CNT=0 THEN
        L_CART_NO:=L_DATE||TRIM('00001');
        ELSE
        --해당일자의 가장 큰 장바구니 번호 
        SELECT MAX(CART_NO) INTO L_CART_NO
        FROM CART
        WHERE SUBSTR(CART_NO,1,8)=L_DATE;
        -- 가장 큰 장바구니 번호를 보유한 회원번호 
        SELECT DISTINCT MEM_ID INTO L_MEM_ID
        FROM CART
        WHERE CART_NO=L_CART_NO;
        
        IF L_MEM_ID != P_MEM_ID THEN
            L_CART_NO:=L_CART_NO+1;
            END IF;
        END IF;
        RETURN L_CART_NO;
    END;


      
      SELECT fn_create_cart_no(TO_DATE('20200409'),'k001') FROM DUAL;
      
      
      사용예) 2020년 4월 8일 't001' 회원이 'P20100007' 상품 2개를 구입한 것을 처리하시오.
      
      CREATE OR REPLACE PROCEDURE proc_cart_insert(
    P_DATE    IN DATE,
    P_MEM_ID  IN MEMBER.MEM_ID%TYPE,
    P_PROD_ID IN VARCHAR2,
    P_QTY     IN NUMBER
) AS
  L_MILEAGE NUMBER := 0; -- 마일리지 계산 보관
BEGIN
  -- CART INSERT
  INSERT INTO CART (MEM_ID, CART_NO, PROD_ID, CART_QTY)
  VALUES (
    P_MEM_ID,
    fn_create_cart_no(TO_DATE('20200408','YYYYMMDD'), P_MEM_ID),
    P_PROD_ID,
    P_QTY
  );

  -- REMAIN UPDATE
  UPDATE REMAIN
     SET REMAIN_O    = REMAIN_O + P_QTY,
         REMAIN_J_99 = REMAIN_J_99 - P_QTY,
         REMAIN_DATE = P_DATE
   WHERE PROD_ID = P_PROD_ID;

  -- MEMBER 마일리지 적립
  SELECT PROD_MILEAGE * P_QTY
    INTO L_MILEAGE
    FROM PROD
   WHERE PROD_ID = P_PROD_ID;

  UPDATE MEMBER
     SET MEM_MILEAGE = MEM_MILEAGE + L_MILEAGE
   WHERE MEM_ID = P_MEM_ID;

  COMMIT;
END;

      실행)
      EXECUTE proc_cart_insert(TO_DATE('20200408'),'t001','P201000007',2);
      