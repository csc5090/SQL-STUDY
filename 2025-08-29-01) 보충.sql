2025-08-29-01) 집계함수 2

    - HAVING 절 : SELECT 절에서 사용된 집계함수에 조건을 부여할 때 사용
    
사용예) HR계정에서 사원의 수가 10명 이상인 부서를 조회하시오.
        AS는 부서번호, 사원수

SELECT DEPARTMENT_ID AS 부서번호,
       COUNT(*) AS 사원수
FROM C##HR.EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 10
ORDER BY 1;


사용예) 2020년 5월 회원 별 구매수량과 구매횟수를 조회하고, 구매횟수가 2회 이상인 회원의 정보를 조회하시오.

SELECT B.MEM_ID AS 회원코드,
       A.MEM_NAME AS 회원명,
       SUM(B.CART_QTY) AS 구매수량,
       COUNT(DISTINCT B.CART_NO) AS 구매횟수
FROM MEMBER A
INNER JOIN CART B ON(A.MEM_ID=B.MEM_ID)
WHERE CART_NO LIKE '202005%'
HAVING COUNT(DISTINCT B.CART_NO) >= 2
GROUP BY A.MEM_NAME, B.MEM_ID
ORDER BY 1;




SELECT B.MEM_ID AS 회원코드,
       A.MEM_NAME AS 회원명,
       SUM(B.CART_QTY) AS 구매수량,
       COUNT(B.CART_QTY) AS 구매횟수
FROM MEMBER A
INNER JOIN CART B ON(A.MEM_ID=B.MEM_ID)
WHERE CART_NO LIKE '202005%'
HAVING COUNT(B.CART_QTY) >= 2
GROUP BY A.MEM_NAME, B.MEM_ID
ORDER BY 1;

SELECT MEM_ID,
       COUNT(MEM_ID)
  FROM CART
WHERE MEM_ID IN ('a001') AND CART_NO LIKE '202005%'
GROUP BY MEM_ID
HAVING COUNT(MEM_ID) >= 2


사용예) 상품테이블에서 분류별 상품의 수를 조회하고 상품의 가지수가 5개 이상인 분류를 출력하시오.

SELECT LPROD_GU AS 분류,
       AS "상품의 가지수"
       COUNT(*) AS "상품의 수"
FROM PROD
GROUP BY LPROD_GU
HAVING COUNT(*)>=10
ORDER BY 1;