2025-0807-01)SELECT 문
사용형식)
    SELECT * | [DISTINCT] [컬럼명[AS 별칭,]
                            :
                            :
                            컬렴명[AS별칭]  ]
        FROM 테이블명
        [WHERE 조건]
        [GROUP BY 컬럼명[,컬럼명,~,컬럼명]]
        [HAVING 조건]
        [ORDER BY 컬럼명|컬럼인덱스[ASC|DESC] [, 컬럼명|컬럼인덱스[ASC|DESC] ,~]]
        
        ASC:오름차순.
        DESC:내림차순.
        
사용예)
 1) 회원테이블(MEMBER)의 모든 자료를 출력하시오.
    SELECT *   --모든 열
      FROM MEMBER;
      
 2) HR계정의 부서정보를 모두 조회하시오.
    
    SELECT *
        FROM C##HR.DEPARTMENTS;

 3) HR계정의 사원테이블(EMPLOYEES)에서 사원번호(EMPLOYEE_ID), 사원명(EMP_NAME), 급여(SALARY)를 출력하시오.
 
    SELECT EMPLOYEE_ID,EMP_NAME,SALARY
        FROM C##HR.EMPLOYEES;
        
    SELECT EMPLOYEE_ID AS 사원번호, 
           EMP_NAME AS 사원명,
           SALARY AS 급여
        FROM C##HR.EMPLOYEES;
 
 4) 상품테이블(PROD)에서 상품번호(PROD_ID),상품명(PROD_NAME),매입가(PROD_COST),매출가(PROD_PRICE)를 조회하시오.
 
    SELECT PROD_ID AS 상품번호,
        PROD_NAME AS 상품명,
        PROD_COST AS 매입가,
        PROD_PRICE AS 매출가
            FROM PROD
            ORDER BY 매입가 DESC;
 
 5) 회원테이블에서 마일리지가 5000이상인 회원들을 조회하시오.
    alias는 회원번호, 회원명, 직업,마일리지이며 마일리지가 큰 회원부터 출력하시오.
    
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원번호,
           MEM_JOB AS 직업,
           MEM_MILEAGE AS 마일리지
            FROM MEMBER
            WHERE MEM_MILEAGE >= 5000
            ORDER BY 4 DESC;
            
 6) HR계정의 사원테이블에서 입사일이 2020년 1월 1일 이후의 사원정보를 조회하시오.
    Alias는 사원번호, 사원명, 부서번호, 입사일이며 부서코드순으로 정렬하고
    같은 부서이면 급여가 적은 사원부터 출력하시오.
 
    SELECT  EMPLOYEE_ID AS 사원번호,
            EMP_NAME AS 사원명,
            DEPARTMENT_ID AS 부서코드,
            HIRE_DATE AS 입사일,
            SALARY AS 급여
            FROM C##HR.EMPLOYEES 
            WHERE HIRE_DATE >= TO_DATE('20200101')
            ORDER BY 부서코드, 급여 ASC;



    숙제들.
    
    1. 상품테이블에서 판매가격이 100만원 이상인 상품을 조회하시오.
    ALIAS는 상품번호, 상품명, 판매가격
    
    SELECT   PROD_ID AS 상품번호,
             PROD_NAME AS 상품명,
             PROD_PRICE AS 판매가격
        FROM PROD 
        WHERE PROD_PRICE >= 1000000;
    
    
    2. 회원테이블에서 마일리지가 2000미만인 회원정보를 조회하시오.
    ALIAS는 회원번호, 회원명, 직업, 마일리지
    
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_JOB AS 직업,
           MEM_MILEAGE 마일리지
        FROM MEMBER
        WHERE MEM_MILEAGE < 2000
        ORDER BY 마일리지 ASC;
    
    6.마일리지가 2000이상이면서 직업이 주부인 회원정보를 조회하시오.
    ALIAS는 회원번호, 회원명, 직업, 마일리지
    
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_JOB AS 직업,
           MEM_MILEAGE AS 마일리지
        FROM MEMBER
        WHERE MEM_MILEAGE >= 2000 AND MEM_JOB LIKE '%주부%';
        
    7.서울에 거주하는 여성회원 정보를 조회하시오.
    ALIAS는 회원번호, 회원명, 주민등록번호, 주소
    
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_REGNO1 AS 주민등록번호앞자리,
           MEM_REGNO2 AS 주민등록번호뒷자리,
           SUBSTR(MEM_REGNO2,1,1) AS 성별코드,
           MEM_ADD1 AS 주소
        FROM MEMBER
        WHERE MEM_ADD1 LIKE '%서울%'
          AND (MEM_REGNO2 LIKE '2%' OR MEM_REGNO2 LIKE '4%');
          
-> 자동 형변환이 좋지 않은 건 알지만, 어떻게 명시적으로 형변환을 해야할지 식이 기억나지 않습니다...

    선택)

    3.서울에 거주하는 회원정보를 조회하시오.
    ALIAS는 회원번호, 회원명, 주소
    
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_ADD1 AS 주소
        FROM MEMBER
        WHERE MEM_ADD1 LIKE '%서울%';
        
        혹은...
        
        SELECT MEM_ID AS 회원번호,
               MEM_NAME AS 회원명,
               MEM_ADD1 AS 주소,
               MEM_HOMETEL AS 집전화번호
        FROM MEMBER
        WHERE MEM_HOMETEL LIKE '%02%';       
        ->집전화번호가 02면서 다른 곳이 주소인 경우도 있다는 변수를 생각하지 못 함.
    
    4.2020년 6월에 구매하지 않은 회원들을 조회하시오.
    ALIAS는 회원번호, 회원명, 성별, 마일리지
    
    SELECT M.MEM_ID AS 회원번호,
           M.MEM_NAME AS 회원명,
           M.MEM_REGNO2 AS 성별,
           M.MEM_MILEAGE AS 마일리지,
           C.CART_NO AS 구입일자
    FROM MEMBER M
    JOIN CART C ON M.MEM_ID = C.MEM_ID
    WHERE (M.MEM_REGNO2 LIKE '2%' OR M.MEM_REGNO2 LIKE '4%')
      AND C.CART_NO NOT LIKE '202006%';
    
   
    
    5. 키보드로 년도를 입력받아 윤년과 평년을 구하시오.
    윤년 : 4의 배수이면서 100의 배수가 아니거나 400의 배수가 되는 해.
    
    //&&옆 숫자를 바꾸면 새로 입력.
    
    SELECT &&2322 AS 입력년도,  
       CASE
         WHEN MOD(&&YEAR, 400) = 0 THEN '윤년'
         WHEN MOD(&&YEAR, 100) = 0 THEN '평년'
         WHEN MOD(&&YEAR, 4) = 0   THEN '윤년'
         ELSE '평년'
       END AS 윤년여부
FROM DUAL;
    
    윤년 = 입력값 / 4 = 0, 입력값 / 100 != 0, 입력값 / 400 = 0.
    
    