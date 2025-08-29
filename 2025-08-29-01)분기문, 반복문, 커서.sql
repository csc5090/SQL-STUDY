2025-08-29-01)분기문, 반복문, 커서

1. 분기문
  - IF문(단일 분기)과 CASE WHEN(다중분기) 명령이 제공됨.
  
  1)IF 문
   - 개발언어의 IF와 같은 기능 제공 
   
  사용형식 -1)
  
  IF 조건 THEN
     명령1;
    [ELSE
        명령2;]
    END IF;
    
  사용형식-2)
  
  IF 조건1 THEN
     명령1;
     ELS IF 조건2 THEN
              명령2;
              :
              :
     ELSE 
        명령N;
        END IF;
        
        
사용형식3)
IF 조건1 THEN
    IF 조건2 THEN
        IF 조건3 THEN
            명령1;
            ELSE 
                명령2;
                END IF;
             ELSE 
                명령3;
            END IF;
        ELSE
            명령n;
        END IF;
        
        
        
        
사용예) 오늘이 2020년 7월 28일이라고 가정하고 날짜를 입력 받아 장바구니 번호를 생성하는 함수를 작성

CREATE OR REPLACE FUNCTION fn_create_cart_no(P_DATE IN DATE) 
    RETURN VARCHAR2 
        IS 
            L_CART_NO   CART.CART_NO%TYPE;
            L_CNT   NUMBER:=0;  --CART 테이블에 존재하는 해당일의 행의 수
        BEGIN
            SELECT COUNT(*) INTO L_CNT
            FROM CART
           WHERE TO_DATE(SUBSTR(CART_NO,1,8))=P_DATE;
            
            
           IF L_CNT=0 THEN 
              L_CART_NO:=TO_CHAR(P_DATE,'YYYYMMDD')||TRIM('00001');
          ELSE 
            SELECT MAX(CART_NO)+1  INTO L_CART_NO
                FROM CART
                WHERE TO_DATE(SUBSTR(CART_NO,1,8)) = P_DATE;
          END IF;
          RETURN L_CART_NO;
        END;
        
2. 커서 
  - 넓은 의미의 커서는 SQL명령의 영향을 받은 행들의 집합이며, 좁은의미(협의)의 커서는 SELECT문의
    결과 집합을 의미함
  
  1) 묵시적 커서
    - 이름이 부여되지 않은 커서(우리가 산출하는 보통의 SELECT문의 결과)
    - 커서 속성
    ----------------------------------------------
    커서속성                 의미
    ----------------------------------------------
    SQL%ISOPEN               커서가 OPEN상태이면 참(true)을 닫혀있는 상태이면false를
                             반환하며 묵시적 커서는 항상 false임
    SQL%FOUND                커서에 1행의 결과가 존재하면 참(true)을 없으면 거짓(false)를 반환.
    SQL%NOTFOUND             커서에 1행의 결과가 존재하면 거짓, 없으면 참을 반환
    SQL%ROWCOUNT             커서에 존재하는 행의 수 
    
     2) 명시적 커서
    - 이름이 부여된 커서
    - PL/SQL문 내부에 사용되는 SELECT 문에 INTO 절을 기술해야 하기 때문에 커서가 요구됨
    -개발자가 결과 집합 내부를 직접 제어 할 수 있음.

커서 사용 형식)
    CURSOR 커서명[(변수명 타입명,...)] IS
    SELECT 문;
    
    
    
    .선언부에 기술
    .'변수명 타입명' : OPEN 문에서 전달하는 데이터를 받아들이는 매개변수
    -커서 속성
    ----------------------------------------------
    커서속성                 의미
    ----------------------------------------------
    SQL%ISOPEN               커서가 OPEN상태이면 참(true)을 닫혀있는 상태이면false를
                             반환하며 묵시적 커서는 항상 false임
    SQL%FOUND                커서에 1행의 결과가 존재하면 참(true)을 없으면 거짓(false)를 반환.
    SQL%NOTFOUND             커서에 1행의 결과가 존재하면 거짓, 없으면 참을 반환
    SQL%ROWCOUNT             커서에 존재하는 행의 수 
    
    ** 커서명%FOUND/커서명%NOTFOUND 값은 FETCH문이 수행 된 후에 SETTING 됨
    *** 커서는 일반적으로 선언(선언부) => OPEN문 => FETCH 문으로 수행되며
        이 중 FETCH 문을 반복문 내부에 기술 
    (1) OPEN 문
        . 생성된 커서를 사용하도록 설정하는 명령
        . 실행영역 내부에 반복문 밖에서 기술
    (사용형식)
        OPEN 커서명[(값,...)];
        . '값' : 커서 선언문에 전달할 값
        
    (2) FETCH 문
      . 커서에서 행 단위로 자료를 읽어오는 명령
      . 실행영역 내부에 반복문 밖에서 기술
    (사용형식)
      FETCH 커서명 INTO 변수list;
      . 변수list : 커서에 있는 컬럼의 값을 할당받을 변수로 커서 내부의 컬럼수,타입,순서와 일치해야 함
      
     (3)