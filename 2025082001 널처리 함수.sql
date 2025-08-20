2025-08-20-01) NULL 처리 함수
    - 오라클에서 사용자가 컬럼을 생성하고 값을 저장하지 않으면 기본적으로 NULL값이 배정됨.
    - 연산시 어느 한 쪽이 NULL이면 결과는 반드시 NULL이 됨.
    - 오라클의 NULL처리 함수로는 NVL, NVL2, NULLIF, COALESCE 등이 제공 됨.

1. IS NULL과 IS NOT NULL
    - 연산자임
    - 특정 컬럼의 값이 NULL인지를 판단할 때 '='연산자로는 동등성 평가를 할 수 없음.
    - 이 때 사용되는 연산자가 IS NULL/IS NOT.
    
    사용예) 상품테이블에서 색상정보에 값이 없는 상품을 조회하시오.
           상품코드, 상품명, 색상
           
           SELECT PROD_ID AS 상품코드,
                  PROD_COLOR AS 색상,
                  PROD_NAME AS 상품명
           FROM PROD
           WHERE PROD_COLOR IS NOT NULL;
           
           
2. NVL(col,value)
    - col의 값이 NULL이면 value를 반환하고 NULL이 아니면 col값을 반환함.
    - col의 데이터 타입과 value의 데이터 타입은 반드시 일치해야 함.
    
사용예) 상품테이블에서 크기정보(PROD_SIZE)를 조회하여 그 값이 NULL이면 '크기 정보 없음'을 출력하고,
        NULL이 아니면 크기를 출력하시오.
        
SELECT  PROD_ID AS 상품코드,
        PROD_NAME AS 상품명,
        NVL(LPAD(PROD_SIZE,8),'정보 없음') AS 크기
FROM PROD;
        
        
사용예) 2020년 2월 모든 상품별 매입수량을 조회하시오.
        상품코드,상품명,매입수량
        
SELECT B.PROD_ID AS 상품코드,
       B.PROD_NAME AS 상품명,
       NVL(SUM(A.BUY_QTY),0) AS 매입수량
FROM BUYPROD A
RIGHT OUTER JOIN PROD B ON(A.PROD_ID=B.PROD_ID AND A.BUY_DATE
         BETWEEN TO_DATE('20200201') AND LAST_DAY(TO_DATE('20200201')))
GROUP BY B.PROD_ID, B.PROD_NAME
ORDER BY 1;

        
**상품테이블에서 분류코드 'P301'에 속한 상품의 매출단가를 매입단가로 변경하시오.

UPDATE PROD 
SET PROD_PRICE=PROD_COST
WHERE LPROD_GU='P301';

SELECT *
FROM PROD
WHERE LPROD_GU='P301';
        
3. NVL2(col, value1, value2)
    - col 값을 평가하여 그 값이 NULL이면 value2를, NULL이 아니면 value1를 반환.
    - value1과 value2의 데이터 타입은 동일 해야 함.
    
    SELECT NVL2(PROD_DETAIL, '널뛰기임ㅋㅋ', '안널뛰기임ㅋㅋ') AS 널뛰기인가
    FROM PROD;
    
사용예) 사원테이블에서 사원들의 영업실적을 조회하여 보너스를 계산하여 출력하시오.
        영업실적이 없다면 '영업실적 없음'으로, 있으면 기본급의 50%를 보너스로 지급.

SELECT EMPLOYEE_ID AS 사원번호,
       EMP_NAME AS 사원명,
       NVL2(COMMISSION_PCT,TO_CHAR(ROUND(SALARY*0.5),'99,999'), '영업실적 없음') AS 보너스
FROM C##HR.EMPLOYEES;

