2025-08-26-01) DML 문과 서브쿼리

1. INSERT 문과 SUBQUERY
   - INSERT 문에 SUBQUERY를 사용하는 경우 VALUES절이 생략됨.
   - 사용되는 서브쿼리는 '()'를 사용하지 않음.
   - INTO 절의 컬럼의 갯수와 순서는 서브쿼리 SELECT문의 컬럼의 갯수 및 순서와 일치해야 함.
   
사용예) ORDERS 테이블을 생성하고 CART테이블의 자료를 이용하여 장바구니번호, 회원번호를 입력하시오
  ORDERS 테이블
  ----------------
  컬럼명         데이터타입        기본값        PK/FK
  ORDER_NUM     CHAR(13)                      PK
  ORDER_DATE    DATE                         
  MEM_ID        VARCHAR2(15)                  FK
  ORDER_AMT     NUMBER(9)        0              
  -----------------------
  - CART 테이블의 자료에서 날짜별, 회원별로 하나의 주문번호 저장
  - 장바구니번호에서 날짜추출
  - 주문금액(ORDER_AMT)는 0으로 설정
  
  (서브쿼리)
  SELECT DISTINCT CART_NO, TO_DATE(SUBSTR(CART_NO,1,8)), MEM_ID
  FROM CART
  ORDER BY 1;
  
  (메인쿼리)
  INSERT INTO ORDERS(ORDER_NUM,ORDER_DATE,MEM_ID)
  SELECT DISTINCT CART_NO, TO_DATE(SUBSTR(CART_NO,1,8)), MEM_ID
  FROM CART;
  
  SELECT * FROM ORDERS
  ORDER BY 1;
  
2. UPDATE 문과 SUBQUERY
  - SET 절에 서브쿼리 적용
  - 만약 SET절에 하나 이상의 컬럼을 기술할 때에는 '(  )'  를 사용. -> 컬럼의 갯수 및 순서는
    서브쿼리의 SELECT 문의 컬럼의 갯수 및 순서와 일치해야한다.

사용형식) 
 UPDATE 테이블명 [별칭]
 SET (컬럼명,컬럼명,...)=(서브쿼리)
 WHERE 조건;
 
 사용예) 2020 1~3월 상품별 매입수량을 조회해서 재고수불테이블을 갱신하시오.
        갱신 일자는 2020/03/31
  
  (서브쿼리 : 2020년 1~3월 상품별 매입수량)
  SELECT PROD_ID, SUM(BUY_QTY) AS AQTY
  FROM BUYPROD
  WHERE BUY_DATE BETWEEN TO_DATE('2020-01-01') AND TO_DATE('2020-03-31')
  GROUP BY PROD_ID;
 
 COMMIT;
 
 메인쿼리
 UPDATE REMAIN A 
    SET (A.REMAIN_I,A.REMAIN_J_99,A.REMAIN_DATE)=
        (SELECT A.REMAIN_I+AQTY,A.REMAIN_J_99+AQTY, TO_DATE('20200331')
         FROM  ( SELECT PROD_ID, SUM(BUY_QTY) AS AQTY
                 FROM BUYPROD
                 WHERE BUY_DATE BETWEEN TO_DATE('2020-01-01') AND TO_DATE('2020-03-31')
                 GROUP BY PROD_ID ) B                 
        WHERE A.PROD_ID=B.PROD_ID
          AND A.REMAIN_YEAR='2020')
  WHERE A.PROD_ID IN(SELECT DISTINCT PROD_ID
                              FROM BUYPROD
                             WHERE BUY_DATE BETWEEN TO_DATE('2020-01-01') AND TO_DATE('2020-03-31'))


ROLLBACK;

UPDATE REMAIN A 
    SET (A.REMAIN_I,A.REMAIN_J_99,A.REMAIN_DATE)=
        (SELECT A.REMAIN_I+NVL(SUM(B.BUY_QTY),0),A.REMAIN_J_99+NVL(SUM(B.BUY_QTY),0),TO_DATE('20200331')
                                FROM BUYPROD B
                                WHERE A.PROD_ID=B.PROD_ID
                                AND B.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200331'))
                                
                                

--PROD테이블의 PROD_MILEAGE컬럼값을 다음 수식의 결과 값으로 갱신하시오.

서브쿼리 매입단가의 0.2%의 정수 첫자리에서 반올림 한 값
  ROUND(SELECT PROD_COST*0.002,-1)
  FROM PROD
  
  메인쿼리
  UPDATE PROD
  SET PROD_MILEAGE=ROUND(PROD_COST*0.002,-1);
COMMIT;


MEMBER 테이블의 마일리지를 초기화하고 구매정보를 이용하여 마일리지를 갱신하시오.

서브쿼리 : 2020년 4-7월까지 회원별 구매정보를 이용한 마일리지 조회

    SELECT A.MEM_ID AS AMID,
           1000+SUM(A.CART_QTY*B.PROD_MILEAGE)*0.2 AS AMT
      FROM CART A
INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
     WHERE SUBSTR(A.CART_NO,1,6) BETWEEN '202004' AND '202007'
  GROUP BY A.MEM_ID  
  ORDER BY 1;
  
메인쿼리

UPDATE MEMBER M
SET M.MEM_MILEAGE=(SELECT C.AMT
                     FROM (SELECT A.MEM_ID AS AMID,
                                  1000+SUM(A.CART_QTY*B.PROD_MILEAGE)*0.2 AS AMT
                                  FROM CART A
                                  INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
                                  WHERE SUBSTR(A.CART_NO,1,6) BETWEEN '202004' AND '202007'
                                  GROUP BY A.MEM_ID)C
                          WHERE M.MEM_ID=C.AMID)
   WHERE M.MEM_ID IN (SELECT DISTINCT MEM_ID
                        FROM CART
                       WHERE SUBSTR(CART_NO,1,6) BETWEEN '202004' AND '202007')
                       
                       COMMIT;
                       
                       
3. DELETE 문과 서브쿼리
  자료삭제에 적용될 조건을 서브쿼리로 구현
  사용형식) 
  DELETE FROM 테이블명
  WHERE 컬럼명=(서브쿼리)
  
  
사용예) 사원테이블에서 사원번호, 사원명, 부서번호, 입사일, 직책코드, 급여를 조회하고 이를 
       테이블로 구성하시오.

CREATE TABLE C##HR.EMP2(EMP_ID,EMP_NAME,DEPT_ID,HIRE_DATE,JOB_ID,SALARY)
AS
    SELECT EMPLOYEE_ID,EMP_NAME,DEPARTMENT_ID,HIRE_DATE,JOB_ID,SALARY
      FROM C##HR.EMPLOYEES;

사용예) EMP테이블에서 입사일이 2018년 이전의 사원을 삭제하시오
서브쿼리 : 입사일이 2018년 이전의 사원의 사원번호

SELECT EMP_ID
FROM C##HR.EMP2 WHERE EXTRACT(YEAR FROM HIRE_DATE)<2018

DELETE FROM C##HR.EMP2
WHERE EMP_ID =ANY(SELECT EMP_ID
FROM C##HR.EMP2 WHERE EXTRACT(YEAR FROM HIRE_DATE)<2018)
