2025-08-28-03) PL/SQL)

 - Procedural Language SQL
 - 서버에서 절차적 처리를 위해 표준 SQL을 확장한 언어
 - 미리 작성된 것을 컴파일하여 실행 가능한 상태로 서버에 보관하고 필요시 실행 명령만 불러 사용
   => 내부 데이터 버스를 이용하는 자료의 양이 작아져서 실행의 효율성을 확보할 수 있음
      (내부 네트워크의 트래픽을 감소 시킴)
 - 기본은 block으로 구성되며 복수개의 SQL문을 일괄 실행 가능
 - 모듈화 캡슐화가 가능
 - Anonymous Block, Stored Procedure, User defined Function, Trigger, Package
 
 
1. PL/SQL의 구조
  DECLARE
    선언영역 : 변수,상수,커서 선언
  
  BEGIN
  실행영역 : 비지니스 로직을 sql문, 반복문, 조건문 등을 이용하여 처리
  
     [EXCEPTION
          예외처리          ]
    
    END;
    

1)변수
  - 자료가 저장되는 기억장소의 이름(기호번지)
  - SCLAR, REFERENCES, COMPOSITE, BIND 변수로 구분됨
  
    (1) SCLAR 변수
      . 일반적인 변수
      . 한 순간 단일 값만을 저장하며 새로운 값이 입력되면 기존의 값은 없어짐
      
    선언형식)
    변수명  [CONSTANT] 데이터타입 [NOT NULL] [:= 초기값];
    
    
    (2) 참조형 변수
       - 열참조형 변수
       (사용형식)
       변수명 테이블명.컬럼명%type
       . '변수명'의 자료 타입이 '테이블명.컬럼명'의 자료 타입과 크기로 설정됨
       
사용예) 2020년 5월 가장 많이 판매된 상품 5개의 상품번호, 상품명, 판매수량을 출력하시오.

SELECT A.PROD_ID AS 상품번호,
       P.PROD_NAME AS 상품명,
       A.SQTY AS 판매수량
FROM PROD P
INNER JOIN (SELECT PROD_ID, SUM(CART_QTY) AS SQTY
              FROM CART
              WHERE CART_NO LIKE '202005%'
              GROUP BY PROD_ID
              ORDER BY 2 DESC)A ON(A.PROD_ID=P.PROD_ID)
WHERE ROWNUM<=5;


PL/SQL))

DECLARE
  l_prod_id   prod.prod_id%TYPE;
  l_prod_name prod.prod_name%TYPE;
  l_sqty      NUMBER;

  CURSOR cur_cart_top5 IS
    SELECT prod_id, prod_name, sqty
    FROM (
      SELECT p.prod_id,
             p.prod_name,
             SUM(c.cart_qty) AS sqty,
             ROW_NUMBER() OVER (ORDER BY SUM(c.cart_qty) DESC) AS rn
      FROM prod p
      JOIN cart c ON c.prod_id = p.prod_id
      WHERE c.cart_no LIKE '202005%'
      GROUP BY p.prod_id, p.prod_name
    )
    WHERE rn <= 5;
BEGIN
  OPEN cur_cart_top5;
  LOOP
    FETCH cur_cart_top5 INTO l_prod_id, l_prod_name, l_sqty;
    EXIT WHEN cur_cart_top5%NOTFOUND;

    DBMS_OUTPUT.PUT_LINE('상품코드 : ' || l_prod_id);
    DBMS_OUTPUT.PUT_LINE('상품명   : ' || l_prod_name);
    DBMS_OUTPUT.PUT_LINE('판매수량 : ' || l_sqty);
    DBMS_OUTPUT.PUT_LINE('---------------------------');
  END LOOP;
  CLOSE cur_cart_top5;
END;


- 행참조형 변수
 (사용형식)
    변수명 테이블명%ROWTYPE
    . '변수명'의 자료 타입이 '테이블명'의 하나의 행과 동일한 복수개의 열을 나타내는 타입으로 선언
    . 해당테이블의 특정열을 참조하려면 '변수명.컬럼명'을 기술
    
    
사용예) 익명 블록을 사용하여 LPROD 테이블의 모든 자료를 출력하시오.


DECLARE
L_LPROD LPROD%ROWTYPE;
CURSOR cur_lprod_all IS 
SELECT * FROM LPROD;
BEGIN
OPEN cur_lprod_all; 
LOOP
FETCH cur_lprod_all
INTO L_LPROD;
EXIT WHEN cur_lprod_all%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(L_LPROD.LPROD_ID||'  '||L_LPROD.LPROD_GU||'  '||L_LPROD.LPROD_NAME);
DBMS_OUTPUT.PUT_LINE('-----------------------------------');
END LOOP;
CLOSE cur_lprod_all;
END;


 (3) BIND 변수
     - 매개변수 사용되는 변수를 BIND 변수라 함
     - IN(입력용), OUT(출력용) INOUT(입출력 공용)
     - 크기를 지정하면 오류가 남.
     
사용예) 기간과 상품코드를 입력 받아 해당 상품의 판매수량 합을 반환하는 함수를 작성하시오.

CREATE OR REPLACE FUNCTION fn_sum_qty(P_PERIOD IN VARCHAR2, P_PID IN PROD.PROD_ID%TYPE)
RETURN NUMBER
IS
L_SUM_QTY NUMBER:=0;
BEGIN
SELECT SUM(CART_QTY) INTO L_SUM_QTY
FROM CART
WHERE PROD_ID=P_PIP
AND CART_NO LIKE P_PERIOD||'%';
RETURN L_SUM_QTY;
END;

SELECT PROD_ID,PROD_NAME,NVL(fn_sum_qty('202006',PROD_ID),0)
FROM PROD
ORDER BY 1;