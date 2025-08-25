2025-08-25-01) SUBQUERY
  - 쿼리문 안에 포함된 또 다른 쿼리.
  - ( )안에 기술
  - 알려지지 않은 조건을 기반으로 검색하는 경우 사용
  - 일반 서브쿼리/INLINE 서브쿼리/중첩서브쿼리, 상관/비상관 서브쿼리 등으로 구분
  
사용예)
 1) 사원테이블에서 모든 사원의 평균 급여보다 더 많은 급여를 받는 사원의 사원번호, 사원명, 부서번호, 급여를 조회하기.
 
 
 중첩서브쿼리(WHERE절에 서브쿼리가 있음)로 작성.
 
 
SELECT  EMPLYEE_ID AS 사원번호,
        EMP_NAME AS 사원명,
        DEPARTMENT_ID AS 부서번호,
        SALARY AS 급여
FROM C##HR.EMPLOYEES 
WHERE SALARY > (평균급여:서브쿼리)
ORDER BY 3;

서브쿼리 : 평균 급여)

SELECT AVG(SALARY)
FROM C##HR.EMPLOYEES;

결합)

SELECT  EMPLOYEE_ID AS 사원번호,
        EMP_NAME AS 사원명,
        DEPARTMENT_ID AS 부서번호,
        SALARY AS 급여,
        (SELECT ROUND(AVG(SALARY)) FROM C##HR.EMPLOYEES) AS 평균급여
FROM C##HR.EMPLOYEES 
WHERE SALARY > (SELECT AVG(SALARY) FROM C##HR.EMPLOYEES)
ORDER BY 4;


INLINE 서브쿼리로 작성.

SELECT  A.EMPLOYEE_ID AS 사원번호,
        A.EMP_NAME AS 사원명,
        A.DEPARTMENT_ID AS 부서번호,
        A.SALARY AS 급여,
        ROUND(B.ASAL) AS 평균급여
FROM C##HR.EMPLOYEES A, (SELECT AVG(SALARY) AS ASAL FROM C##HR.EMPLOYEES) B
WHERE A.SALARY > B.ASAL
ORDER BY 4;

사용예) 사원테이블에서 50번 부서에서 가장 먼저 입사한 사원보다 입사일이 빠른 사원의
       사원번호, 사원명, 부서번호, 부서명, 직무코드를 조회하시오.
       
메인쿼리)

SELECT A.EMPLOYEE_ID AS 사원번호,
       A.EMP_NAME AS 사원명,
       A.DEPARTMENT_ID AS 부서번호,
       B.DEPARTMENT_NAME AS 부서명,
       A.JOB_ID AS 직무코드
FROM C##HR.EMPLOYEES A
INNER JOIN C##HE.DEPARTMENTS B ON(A.DEPARTMENT_ID=B.DEPARTMENT_ID)
WHERE A.HIRE_DATE<(SELECT MIN(HIRE_DATE)
                   FROM C##HR.EMPLOYEES
                   WHERE DEPARTMENT_ID=50;)
ORDER BY 3;


서브쿼리)

SELECT MIN(HIRE_DATE)
FROM C##HR.EMPLOYEES
WHERE DEPARTMENT_ID=50;

SELECT HIRE_DATE
FROM (SELECT HIRE_DATE
      FROM C##HR.EMPLOYEES
      WHERE DEPARTMENT_ID=50
      ORDER BY 1)
WHERE ROWNUM=1;

결합)

SELECT A.EMPLOYEE_ID AS 사원번호,
       A.EMP_NAME AS 사원명,
       A.DEPARTMENT_ID AS 부서번호,
       B.DEPARTMENT_NAME AS 부서명,
       A.HIRE_DATE AS 입사일,
       A.JOB_ID AS 직무코드
FROM C##HR.EMPLOYEES A
INNER JOIN C##HR.DEPARTMENTS B ON(A.DEPARTMENT_ID=B.DEPARTMENT_ID)
WHERE A.HIRE_DATE<(SELECT HIRE_DATE
                   FROM (SELECT HIRE_DATE
                         FROM C##HR.EMPLOYEES
                         WHERE DEPARTMENT_ID=50
                         ORDER BY 1)
                         WHERE ROWNUM=1)
ORDER BY 5;

사용예) 2020년 5월 구매금액이 가장 많은 회원의 회원번호,회원명,직업,마일리지를 조회하시오.

메인쿼리 :

SELECT MEM_ID AS 회원번호,
       MEM_NAME AS 회원명,
       MEM_JOB AS 직업,
       MEM_MILEAGE AS 마일리지
FROM MEMBER A
WHERE MEM_ID
 
서브쿼리 :  2020년 5월 구매금액이 가장 많은 회원의 회원번호

SELECT AMID, ASUM
FROM (SELECT A.MEM_ID AS AMID,
       SUM(A.CART_QTY*B.PROD_PRICE) AS ASUM
FROM CART A
INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID AND A.CART_NO LIKE '202005%')
GROUP BY A.MEM_ID
ORDER BY 2 DESC)
WHERE ROWNUM=1

(결합)

SELECT MEM_ID AS 회원번호,
       MEM_NAME AS 회원명,
       MEM_JOB AS 직업,
       MEM_MILEAGE AS 마일리지
FROM MEMBER
WHERE MEM_ID=(SELECT AMID
              FROM (SELECT A.MEM_ID AS AMID,
                           SUM(A.CART_QTY * B.PROD_PRICE) AS ASUM
                      FROM CART A
                      INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID AND A.CART_NO LIKE '202005%')
                      GROUP BY A.MEM_ID
                      ORDER BY 2 DESC)
                      WHERE ROWNUM=1);
                      
                      
사용예) 사원테이블에서 자신 부서의 평균급여보다 더 적은 급여를 받는 사원의 사원번호,사원명,부서번호,부서평균급여를 조회하시오.
메인쿼리 : 사원테이블에서 조건에 맞는 사원의 사원번호, 사원명, 부서번호, 급여, 부서평균급여

SELECT A.EMPOYEE_ID AS 사원번호,
       A.EMP_NAME AS 사원명,
       A.DEPARTMENT_ID AS 부서번호,
       A.SALARY AS 급여,
       (SELECT ROUND(AVG(B.SALARY))
       FROM C##HR.EMPLOYEES B
       WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID) AS 부서평균급여
FROM C##HR.EMPLOYEES A
WHERE A.SALARY<(서브쿼리:부서 평균급여)

서브쿼리 : 부서별 평균급여)
SELECT DEPARTMENT_ID,
       AVG(SALARY)
FROM C##HR.EMPLOYEES
GROUP BY DEPARTMENT_ID;

결합
SELECT A.EMPLOYEE_ID AS 사원번호,
       A.EMP_NAME AS 사원명,
       A.DEPARTMENT_ID AS 부서번호,
       A.SALARY AS 급여,
       (SELECT ROUND(AVG(B.SALARY))
       FROM C##HR.EMPLOYEES B
       WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID) AS 부서평균급여
FROM C##HR.EMPLOYEES A, (SELECT DEPARTMENT_ID, AVG(SALARY) AS ASAL
                         FROM C##HR.EMPLOYEES
                         GROUP BY DEPARTMENT_ID) B
WHERE A.SALARY<B.ASAL
AND B.DEPARTMENT_ID=A.DEPARTMENT_ID
        ORDER BY 3, 4 DESC;

사용예) 마일리지가 많은 3명의 2020년 4-6월 구매현황을 조회하시오.
        AS는 회원번호, 회원명, 구매금액합계
        
        
---------

재고 수불 테이블  생성

테이블명 : REMAIN

컬렴명           타입          기본값          PK/FK           설명

REMAIN_YEAR   CHAR(4)                        PK             재고수불년도
PROD_ID       VARCHAR2(10)                 PK & FK          상품코드
REMAIN_J_00   NUMBER(5)                                     기초재고
REMAIN_I      NUMBER(5)        0                            매입수량
REMAIN_O      NUMBER(5)        0                            매출수량
REMAIN_J_99   NUMBER(5)        0                            현재고
REMAIN_DATE   DATE           SYSDATE                        갱신일자

위 테이블에 다음의 자료를 삽입하시오

재고수불년도 : 2020
PROD_ID : PROD테이블의 모든 PROD_ID
기초재고 : PROD테이블의 적정재고(PROD_PROPERSTOCK)
매입/매출수량 : 0
현재고 : PROD테이블의 적정재고(PROD_PROPERSTOCK)
갱신일자 : 2020-01-01

INSERT INTO REMAIN(REMAIN_YEAR,PROD_ID,REMAIN_J_00,REMAIN_J_99,REMAIN_DATE)
SELECT '2020',PROD_ID,PROD_PROPERSTOCK,PROD_PROPERSTOCK,TO_DATE('20200101')
FROM PROD;

COMMIT;