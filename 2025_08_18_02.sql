2025-0818-02) 집계함수
 - SUM, AVG, COUNT, MAX, MIN
 - 그룹을 나누고 그룹별로 집계의 결과를 반환
 - 그룹함수는 그룹함수를 포함할 수 없다(단, 일반함수는 그룹함수를 포함할 수 있고, 반대로
   그룹함수는 일반함수를 포함할 수 있다)
   
사용형식)
    SELECT [컬럼,...,]
            SUM(col| expr) | AVG(col| expr) | COUNT(*| expr) | MAX(col| expr) | MIN(col| expr)
    FROM 테이블명
    
    [WHERE 조건]
    
    [GROUP BY 컬럼명[,컬럼명,....]
    [HAVING 조건 ]
    [ORDER BY 컬럼명 | 컬럼인덱스[ASC | DESC] [,컬럼명|컬럼인덱스[ASC | DESC],...]];
    
    SELECT 절에 집계함수만 사용된 경우 GROUP BY절 생략(테이블전체가 하나의 그룹)
    SELECT 절에 집계함수가 아닌 일반컬럼이 기술되고 집계 함수가 사용되면 반드시 GROUP BY절이 기술되어야 하며
    SELECT 절에 사용된 일반컬럼은 GROUP BY 절에 모두 기술해야함
    
    집계함수에 조건이 부여되는 경우 HAVING절을 사용해야함
    
사용예)
    1) 회원테이블에서 모든 회원들의 마일리지 합계와, 평균마일리지, 인원수, 최대마일리지, 최소마일리지를 구하시오
    
    SELECT SUM(MEM_MILEAGE) AS 마일리지합계,
           TRUNC(AVG(MEM_MILEAGE),0) AS 평균마일리지,
           COUNT(*) AS 인원수,
           MAX(MEM_MILEAGE) AS 최대마일리지,
           MIN(MEM_MILEAGE) AS 최소마일리지
    FROM MEMBER;
    
    2) 상품테이블에서 상품의 수, 최대판매가, 최소 판매가를 구하시오.
    
    SELECT 
       COUNT(*) AS 상품의수,         
       MAX(PROD_PRICE) AS 최대판매가,
       MIN(PROD_PRICE) AS 최소판매가 
    FROM PROD;
    
    3) 2020년 4월 판매수량 합계를 구하시오.
    
    SELECT
        SUM(CART_QTY) AS "판매수량 합계"
      FROM CART
     WHERE CART_NO LIKE '202004%';
     
    4) 상품테이블에서 분류별 상품의수와 ,평균판매가, 최대판매가, 최소판매가 조회하시오.
    
    SELECT LPROD_GU AS 분류코드,
           COUNT(*) AS 상품의수,
           TRUNC(AVG(PROD_PRICE)) AS 평균판매가,
           MAX(PROD_PRICE) AS 최대판매가,
           MIN(PROD_PRICE) AS 최소판매가
    FROM PROD
    GROUP BY LPROD_GU
    ORDER BY 1;
    
    5) 사원테이블에서 부서별 평균급여와 인원수를 조회하시오.
    
    SELECT DEPARTMENT_ID AS 부서,
           TRUNC(AVG(SALARY)) AS 평균급여,
           COUNT(*) AS 인원수
    FROM C##HR.EMPLOYEES
    GROUP BY DEPARTMENT_ID
    ORDER BY 1;
    
    6) 상품테이블에서 분류별 상품의 수 평균 판매가를 조회하되 상품의수가 10가지 이상인 분류만 조회하시오.
    
    SELECT LPROD_GU AS 분류코드,
        COUNT(*) AS 상품의수,
        TRUNC(AVG(PROD_PRICE)) AS 평균판매가,
        MAX(PROD_PRICE) AS 최대판매가,
        MIN(PROD_PRICE) AS 최소판매가
    FROM PROD
    GROUP BY LPROD_GU
    HAVING COUNT(*) >= 10
    ORDER BY 1;
    
7)매입 테이블에서 2020년 월별 매입수량합계를 조회하시오.
    SELECT
        EXTRACT(MONTH FROM BUY_DATE) AS 월,
        SUM(BUY_QTY) AS 매입수량합계
      FROM BUYPROD
    WHERE EXTRACT(YEAR FROM BUY_DATE) = 2020
    GROUP BY EXTRACT(MONTH FROM BUY_DATE)
    ORDER BY 1;
8)매입 테이블에서 2020년 상품별 매입수량 합계를 조회하시오.

    SELECT
        PROD_ID AS 상품별,
        SUM(BUY_QTY) AS 매입수량합계
    FROM BUYPROD
    WHERE EXTRACT(YEAR FROM BUY_DATE) = 2020
    GROUP BY PROD_ID
    ORDER BY 1;
8-1) 매입테이블에서 2020년 상품별 매입수량 합계를 조회하되 매입수량 합계가 100개 이상인 상품의 상품번호 상품명 매입수량합계를 출력하시오.
    
    SELECT A.PROD_ID AS 상품번호,
           B.PROD_NAME AS 상품명,
           SUM(A.BUY_QTY) AS 매입수량합계
    FROM BUYPROD A
    INNER JOIN PROD B ON(A.PROD_ID = B.PROD_ID AND EXTRACT(YEAR FROM BUY_DATE) = 2020)
    GROUP BY A.PROD_ID,B.PROD_NAME
    HAVING SUM(A.BUY_QTY) >= 100
    ORDER BY 1;

9)매출테이블에서 2020년 월별, 상품별, 상품수량합계를 조회하시오
    SELECT  SUBSTR(CART_NO,5,2) AS 월,
            PROD_ID AS 상품번호,
            SUM(CART_QTY) AS 판매수량합계
    FROM CART
    WHERE CART_NO LIKE '2020%'
    GROUP BY SUBSTR(CART_NO,5,2),PROD_ID
    HAVING SUM(CART_QTY) BETWEEN 15 AND MAX(CART_QTY)
    ORDER BY 1, 2;
    
10)사원테이블에서 부서별, 년도별 입사한 사원수를 조회하시오.
    SELECT DEPARTMENT_ID AS 부서별,
           EXTRACT (YEAR FROM HIRE_DATE) AS 년도,
           COUNT(*) AS "입사한 사원수"
    FROM C##HR.EMPLOYEES
    GROUP BY DEPARTMENT_ID,EXTRACT (YEAR FROM HIRE_DATE)
    ORDER BY 1;
11)회원테이블에서 거주지별 평균마일리지와 회원수를 조회하시오.
    
    SELECT 
           SUBSTR(MEM_ADD1,1,2) AS 거주지,
           TRUNC(AVG(MEM_MILEAGE)) AS 평균마일리지,
           COUNT(MEM_ID) AS 회원수
    FROM MEMBER
    GROUP BY SUBSTR(MEM_ADD1,1,2)
    ORDER BY 3 DESC;

-------------------------------------------------------------------------숙제

12)회원테이블에서 성별 평균마일리지를 조회하시오.
    
13)회원테이블에서 연령대별 회원수와 평균마일리지를 조회하시오.

14)상품테이블에서 매입거래처별 상품의 수와 최고매입가, 최저매입가를 조회하시오.

