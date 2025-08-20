2025082002) 순위함수
    - 순위를 반환해주는 함수.
    - RANK() OVER, DENSE_RANK() OVER, ROW_NUMBER() OVER
    - SELECT 절 전용 함수들.
사용형식)
SELECT RANK() |DENSE_RANK()|ROW_NUMBER()| OVER(ORDER BY 컬럼명 [ASC|DESC],...) AS 별칭
    . RANK() : 일반적인 순위 부여(같은 값이면 같은 순위를 부여하고 다음 순위는 "현재순위 + 같은 값의 갯수"로 부여)
    . DENSE_RANK() : 같은 값이면 같은 순위를 부여하고 다음 순위는 "현재순위+1"로 부여
    . ROW_NUMBER() : 순서화된 값이 나열된 순에 따라 차례대로 순서값을 부여

    EX)         9, 8, 8, 7, 7, 7, 7, 6, 5, 4
    RANK()      1  2  2  4  4  4  4  8  9  10
  DENSE_RANK()  1  2  2  3  3  3  3  4  5  6
  ROW_NUMBER()  1  2  3  4  5  6  7  8  9  10
  
  사용예) 회원테이블에서 마일리지가 많은 회원부터 순위를 부여하시오.
        AS는 회원번호, 회원명, 마일리지, 순위
        
        SELECT MEM_ID AS 회원번호,
               MEM_NAME AS 회원명,
               MEM_MILEAGE AS 마일리지,
               RANK() OVER(ORDER BY MEM_MILEAGE DESC, 
               EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) ASC) AS "순위(RANK())", 
               DENSE_RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS "순위(DENSE_RANK())",
               ROW_NUMBER() OVER(ORDER BY MEM_MILEAGE DESC) AS "순위(ROW_NUMBER())"
        FROM MEMBER;
        
2. 그룹별 순위
    - 특정 컬럼을 기준으로 그룹을 나누고 각 그룹내에서 순위를 결정함.
    - RANK(). DENSE_RANK(), ROW_NUMBER()가 사용됨.

사용형식)
SELECT RANK() | DENSE_RANK() | ROW_NUMBER() OVER(PARTITION BY 컬럼명 [,컬럼명,...]  ORDER BY 컬럼명 [ASC|DESC] [,...]) AS 컬럼명
        - PARTITION BY 컬럼명 : '컬럼명'을 기준으로 그룹을 구성
        

사용예) 사원테이블에서 각 부서별 사원들의 입사일에 따른 순위를 부여하시오
        AS는 사원번호, 사원명, 부서번호, 입사일, 순위
        
SELECT EMPLOYEE_ID AS 사원번호,
       EMP_NAME AS 사원명,
       DEPARTMENT_ID AS 부서번호,
       HIRE_DATE AS 입사일,
       RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY HIRE_DATE ASC) AS 순위
FROM   C##HR.EMPLOYEES;
        
사용예) 2020년 2월 상품별 매입수량합계에 따른 순위를 구하시오.
       AS는 상품코드, 상품명, 매입수량, 순위 
       
SELECT PROD_ID AS 상품코드,
       SUM(BUY_QTY) AS 매입수량,
       RANK() OVER(ORDER BY SUM(BUY_QTY) DESC) AS 순위
FROM BUYPROD
WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND LAST_DAY(TO_DATE('20200201'))
GROUP BY PROD_ID;

사용예)
1. 사원 테이블에서 부서별 급여순으로 순위를 부여하시오.

SELECT  DEPARTMENT_ID AS 부서,
        RANK() OVER(ORDER BY DEPARTMENT_ID ASC) AS 급여순위
FROM   C##HR.EMPLOYEES
GROUP BY DEPARTMENT_ID;


2. 회원테이블에서 연령대 별 마일리지순으로 순위를 부여하시오.


SELECT
TRUNC(TRUNC(MONTHS_BETWEEN(SYSDATE, MEM_BIR)/12)/10)*10 || '대' AS 연령대,
RANK() OVER (PARTITION BY TRUNC(TRUNC(MONTHS_BETWEEN(SYSDATE, MEM_BIR)/12)/10)*10 ORDER BY MEM_MILEAGE ASC) AS 마일리지순위
FROM MEMBER
ORDER BY 1, 2;

->

SELECT
TRUNC(TRUNC(MONTHS_BETWEEN(SYSDATE, MEM_BIR)/12)/10)*10 || '대' AS 연령대,
MAX(MEM_MILEAGE) AS 마일리지,
RANK() OVER(ORDER BY MAX(MEM_MILEAGE) DESC) AS 순위
FROM MEMBER
GROUP BY TRUNC(TRUNC(MONTHS_BETWEEN(SYSDATE, MEM_BIR)/12)/10)*10;