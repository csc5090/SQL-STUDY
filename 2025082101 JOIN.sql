2025-0821-01)JOIN
- 두 개 이상의 테이블들을 연결 또는 결합하여 데이터를 출력하는 것
- 일반적인 경우 행들은 Primary Key(PK)나 Foreign Key(FK)값의 연관에 의해 조인이 성립.
- 어떤 경우에는 이러한 PK,FK의 관계가 없어도 논리적인 값들의 연관만으로 조인 성립이 가능함.
- JOIN의 조건은 WHERE 절에 기술하며 참여하는 테이블의 수가 N개 일 때 JOIN 조건은 반드시 N-1개 이상이어야 한다.
- JOIN은 내부/외부, 일반/ANSI, 동등/비동등, 셀프, CARTESIAN PRODUCT 등으로 구분함.

1. CARTESIAN PRODUCT
 - 조인 조건이 없거나 잘못 기술된 경우
 - ANSI에서는 CROSS JOIN이라고 함.
 
사용 형식 - 일반 조인)
SELECT 컬럼명
FROM 테이블1 [별칭1], 테이블2 [별칭2]...

별칭1은 해당 쿼리 안에서 테이블을 지칭하는 또 다른 이름으로 보통 부르기 쉽고 기억하기 쉬운 단어로

사용형식-ANSI조인)
SELECT 컬럼명
FROM 테이블1 [별칭1]
CROSS JOIN   테이블2 [별칭2]
CROSS JOIN 테이블명3 [별칭3]...


*** 모든 ANSI JOIN의 FROM절에는 하나의 테이블이 존재한다.
 - CARTESIAN PRODUCT나 CROSS JOIN의 결과는 조인에 참여하는 모든 테이블들의 행은 곱한 값 만큼,
   열은 더한 값 만큼 생성된다.
 - 문제 해결을 위하여 반드시 필요한 경우가 아니면 사용을 제자 해야함.

사용형식)
SELECT 'CART' AS 테이블명, COUNT(*) AS 행의수
FROM CART
UNION ALL
SELECT 'BUYPROD', COUNT(*)
FROM PROD; 

SELECT * 
FROM CART,BUYPROD,PROD;

ANSI : CROSS JOIN

SELECT COUNT(*)
FROM BUYPROD
CROSS JOIN CART
CROSS JOIN PROD;


2. 내부조인( INNER JOIN ) 
 - 조인 조건을 만족하는 자료만 반환하고, 조인 조건을 만족하지 않는 자료는 무시함.

사용형식 - 일반조인)

SELECT 컬럼명
FROM 테이블명1 [별칭1], 테이블명2[별칭2],...
WHERE 조인조건
[AND 조인조건]
............
[AND 일반조건]

    일반 조건과 조인조건의 기술 순서는 상관없음
    조인조건을 만족하는 결과 출력
    

사용형식 - ANSI JOIN )

SELECT 컬럼명
FROM 테이블명
INNER JOIN 테이블명2 [별칭2] ON(조인조건1 [AND 일반조건])
[INNER JOIN 테이블명3 [별칭3] ON(조인조건2 [AND 일반조건2])
                    :       
                    :
                    :
[WHERE 일반조건]

    FROM절의 테이블과 첫 번째 INNER JOIN 문의 테이블은 반드시 직접 조인 되어야 한다.
    . JOIN의 결과는 '테이블명1' 과 '테이블명2'의 조인 결과와 '테이블명3'이 조인됨.
    . '일반조건1'은 '테이블명1'과 '테이블명2'에 관련된 조건이며 '일반조건2'는
      '테이블명1'과 '테이블명2', '테이블명3'과 관련된 조건임.
    . WHERE 절의 조건은 모두에 적용되는 조건으로 INNER 조인에서는 ON 절에 기술해도, WHERE절에 기술해도
      결과는 동일하나 외부조인은 WHERE절을 사용하면 안 됨.(내부 JOIN에서는 반드시 들어가야함. 안 들어가면 카테시안 곱이 되어버림.)
    
    

사용예)
 1) 사원테이블과 부서테이블을 이용하여 부서별 사원수와 평균급여를 출력하시오.
    AS는 부서번호, 부서명, 사원수, 평균급여이며 부서번호 순으로 출력해야 함.
 
 (일반 형식)
 SELECT A.DEPARTMENT_ID AS 부서번호, 
        B.DEPARTMENT_NAME AS 부서명,
        COUNT(*) AS 사원수,
        ROUND(AVG(SALARY)) AS 평균급여
 FROM C##HR.EMPLOYEES A, C##HR.DEPARTMENTS B
 WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
 GROUP BY A.DEPARTMENT_ID,B.DEPARTMENT_NAME
 ORDER BY 1;
 
ANSI FORMAT

SELECT A.DEPARTMENT_ID AS 부서번호, 
        B.DEPARTMENT_NAME AS 부서명,
        COUNT(*) AS 사원수,
        ROUND(AVG(SALARY)) AS 평균급여
 FROM C##HR.EMPLOYEES A
 INNER JOIN C##HR.DEPARTMENTS B ON(A.DEPARTMENT_ID=B.DEPARTMENT_ID) -- 조인조건
 GROUP BY A.DEPARTMENT_ID,B.DEPARTMENT_NAME
 ORDER BY 1;

 
 2) 매입테이블과 상품테이블을 활용하여 2020년 1월 상품별 매입현황을 조회하시오.
    AS는 상품번호, 상품명, 매입수량합계, 매입금액합계
    
    SELECT B.PROD_ID AS 상품번호,
           A.PROD_NAME AS 상품명,
           SUM(B.BUY_QTY) AS 매입수량합계,
           SUM(A.PROD_COST*B.BUY_QTY) AS 매입금액합계
    FROM PROD A, BUYPROD B
    WHERE A.PROD_ID=B.PROD_ID 
          AND B.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131') -- 조인조건
    GROUP BY B.PROD_ID, A.PROD_NAME
    ORDER BY 1;
    
    
    ANSI 형식
    
    SELECT B.PROD_ID AS 상품번호,
           A.PROD_NAME AS 상품명,
           SUM(B.BUY_QTY) AS 매입수량합계,
           SUM(A.PROD_COST*B.BUY_QTY) AS 매입금액합계
    FROM  PROD A
    INNER JOIN BUYPROD ON(A.PROD_ID=B.PROD_ID AND
    B.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131'))
    GROUP BY B.PROD_ID,A.PROD_NAME
    ORDER BY 1;
    
    
 3) 2020년 4월 회원별 구매현황을 출력하시오.
    AS는 회원번호, 회원명, 구매금액
    
    SELECT A.MEM_ID AS 회원번호,
           A.MEM_NAME AS 회원명,
           SUM(C.CART_QTY*B.PROD_PRICE) AS 구매금액
    FROM MEMBER A,PROD B,CART C
    WHERE A.MEM_ID=C.MEM_ID 
          AND B.PROD_ID = C.PROD_ID
          AND C.CART_NO LIKE '202004%'
    GROUP BY A.MEM_ID, A.MEM_NAME;

    ANSI 형식

    SELECT A.MEM_ID AS 회원번호,
           A.MEM_NAME AS 회원명,
           SUM(C.CART_QTY*B.PROD_PRICE) AS 구매금액
    FROM MEMBER A
    INNER JOIN CART C ON A.MEM_ID = C.MEM_ID
    INNER JOIN PROD B ON B.PROD_ID = C.PROD_ID AND C.CART_NO LIKE '202004%'
    GROUP BY A.MEM_ID,A.MEM_NAME;

    SELECT A.MEM_ID AS 회원번호,
           A.MEM_NAME AS 회원명,
           SUM(C.CART_QTY*B.PROD_PRICE) AS 구매금액
    FROM  CART C
    INNER JOIN MEMBER A ON A.MEM_ID = C.MEM_ID
    INNER JOIN PROD B ON B.PROD_ID = C.PROD_ID
    AND C.CART_NO LIKE '202004%'
    GROUP BY A.MEM_ID, A.MEM_NAME;
    
    
 4) 2020년 4월 회원별 구매금액을 조회하되 1000만원 이상인 회원만 출력하시오
    AS는 회원번호, 회원명, 구매금액합계 
    
    SELECT C.MEM_ID AS 회원번호,
           M.MEM_NAME AS 회원명,
           SUM(C.CART_QTY*P.PROD_PRICE) AS 구매금액합계
    FROM CART C
    INNER JOIN MEMBER M ON C.MEM_ID = M.MEM_ID
    INNER JOIN PROD P ON C.PROD_ID = P.PROD_ID
    HAVING SUM(C.CART_QTY*P.PROD_PRICE)>=10000000 
    GROUP BY C.MEM_ID, M.MEM_NAME;
    
    
    
    
 5) hr계정의 테이블들을 활용하여 주소가 미국에 있지 않은 부서에 속한 사원정보를 조회하시오.
    AS는 회원번호, 회원명, 부서번호, 부서명, 직책

SELECT A.EMPLOYEE_ID AS 사원번호,
       A.EMP_NAME AS 사원명,
       A.DEPARTMENT_ID AS 부서번호,
       B.DEPARTMENT_NAME AS 부서명,
       C.JOB_TITLE AS 직책,
       D.COUNTRY_ID AS 국가코드
FROM   C##HR.EMPLOYEES A, C##HR.DEPARTMENTS B, C##HR.JOBS C, C##HR.LOCATIONS D
WHERE  A.DEPARTMENT_ID=B.DEPARTMENT_ID  -- 조인조건(부서명 추출)
AND    A.JOB_ID=C.JOB_ID  -- 조인조건(직무명 추출)
AND    B.LOCATION_ID=D.LOCATION_ID
AND    D.COUNTRY_ID != 'US'
ORDER BY 3;


ANSI 조인으로 하기.


 hr계정의 테이블들을 활용하여 주소가 미국에 있지 않은 부서에 속한 사원정보를 조회하시오.
    AS는 회원번호, 회원명, 부서번호, 부서명, 직책
    
SELECT E.EMPLOYEE_ID AS 사원번호,
       E.EMP_NAME AS 사원명,
       E.DEPARTMENT_ID AS 부서번호,
       D.DEPARTMENT_NAME AS 부서명,
       J.JOB_TITLE AS 직책,
       L.COUNTRY_ID AS 국가코드
FROM C##HR.EMPLOYEES E
INNER JOIN C##HR.DEPARTMENTS D ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
INNER JOIN C##HR.LOCATIONS L ON L.LOCATION_ID=D.LOCATION_ID
INNER JOIN C##HR.JOBS J ON J.JOB_ID=E.JOB_ID
WHERE NOT(L.COUNTRY_ID IN ('US'))
ORDER BY 1;
