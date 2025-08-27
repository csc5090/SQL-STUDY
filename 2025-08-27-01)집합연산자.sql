2025-08-27-01)집합연산자

   - UNION, UNION ALL, INTERSECT, MINUS 가 제공됨.
   . SELECT 절의 컬럼의 갯수, 기술순서, 자료타입이 동일해야함.
    (컬럼의 값이 같지 않으면 서로 다른 데이터로 간주됨)
    .ORDER BY 절은 맨 마지막 SELECT 문에만 사용 가능
    .컬럼의 별칭은 첫 번째 SELECT문의 것이 적용됨
    
1. UNION / UNION ALL
   - 합집합의 결과를 반환
   - 중복 배제(UNION), 중복 허용(UNION ALL)
   - 서로 다른 구조의 테이블을 하나로 결합하여 반환
   
사용예) 2020년 6월에 매입된 상품과 7월 매입된 모든 상품을 조회하시오.
        AS는 상품코드, 상품명, 매입단가, 매입거래처명
        
SELECT A.PROD_ID AS 상품코드,
       B.PROD_NAME AS 상품명,
       B.PROD_COST AS 매입단가,
       C.BUYER_NAME AS 매입거래처명
FROM BUYPROD A
INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
INNER JOIN BUYER C ON(B.BUYER_ID=C.BUYER_ID)
WHERE A.BUY_DATE BETWEEN TO_DATE('20200201') AND LAST_DAY(TO_DATE('20200201'))
ORDER BY 1;
UNION 
SELECT A.PROD_ID,
       B.PROD_NAME,
       B.PROD_COST,
       C. BUYER_NAME
FROM BUYPROD A
INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
INNER JOIN BUYER C ON(B.BUYER_ID=C.BUYER_ID)
WHERE A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')
ORDER BY 1;

SELECT PERIOD AS 기간,
       SUM(BUDGET_AMT) AS 목표치,
       SUM(SALE_AMT) AS 실적,
       ROUND(SUM(SALE_AMT)/SUM(BUDGET_AMT)*100) ||'%' AS 달성률
  FROM (SELECT PERIOD,
                BUDGET_AMT,
                0 AS "SALE_AMT"
                FROM BUDGET
                UNION ALL
                SELECT PERIOD,0,SALE_AMT
                FROM SALES
                ORDER BY 1)
GROUP BY PERIOD;


SELECT PERIOD AS 기간,
       BUDGET_AMT AS 계획,
       0 AS 실적
FROM BUDGET
UNION ALL
SELECT PERIOD, 0, SALE_AMT
FROM SALES
ORDER BY 1;



2. INTERSECT
  - 교집합의 결과를 반환
  - EXISTS 연산자로 구현 가능
  
사용예) 2020년 4월에 판매된 상품과 2020년 6월에 판매된 상품 중 두 달 모두
       판매된 상품의 상품번호, 상품명을 조회하기
(2020년 4월에 판매된 상품)

SELECT DISTINCT(A.PROD_ID) AS 상품번호,
       B.PROD_NAME AS 상품명
FROM CART A, PROD B
WHERE A.PROD_ID=B.PROD_ID
AND   A.CART_NO LIKE '202004%'
INTERSECT
SELECT DISTINCT(A.PROD_ID) AS 상품번호,
       B.PROD_NAME AS 상품명
FROM CART A, PROD B
WHERE A.PROD_ID=B.PROD_ID
AND   A.CART_NO LIKE '202006%'
ORDER BY 1;

EXISTS))
SELECT DISTINCT(A.PROD_ID) AS 상품번호,
       B.PROD_NAME AS 상품명
FROM CART A, PROD B
WHERE A.PROD_ID=B.PROD_ID
AND   A.CART_NO LIKE '202004%'
AND EXISTS(SELECT DISTINCT A.PROD_ID, B.PROD_NAME
             FROM CART C
            WHERE A.PROD_ID=C.PROD_ID
              AND C.CART_NO LIKE '202006%')
         ORDER BY 1;


3. MINUS
  - 차집합의 결과를 반환
  - 연산자 왼쪽에 어느 집합을 기술하느냐에 따라 결과가 달라짐.
  - NOT EXISTS 로 구현이 가능.
  
SELECT DISTINCT(A.PROD_ID) AS 상품번호,
               B.PROD_NAME AS 상품명
FROM CART A, PROD B
WHERE A.PROD_ID=B.PROD_ID
AND   A.CART_NO LIKE '202006%'
MINUS
SELECT DISTINCT(A.PROD_ID) AS 상품번호,
       B.PROD_NAME AS 상품명
FROM CART A, PROD B
WHERE A.PROD_ID=B.PROD_ID
AND   A.CART_NO LIKE '202004%'
ORDER BY 1;