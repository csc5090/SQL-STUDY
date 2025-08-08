2025_0808_01 ) 기타연산자
    - BETWEEN, LIKE, IN, ALL, ANY(SOME) EXISTS 등이 제공됨.
1. BETWEEN
  - 범위를 지정할 때 사용
  - AND 연산자로 치환 가능

사용형식)
 expr BETWEEN 값1 AND 값2
 . expr 값이 '값1'에서 '값2' 사이에 존재하면 참(true)을 반환.
 . AND 연산자로 바꾸어 사용할 수 있다.
 . '값1'과 '값2'는 동일 데이터 타입이거나 변환 될 수 있어야 한다.
 
 
 (사용예)
 1) 2020년 1월 매입자료를 조회하시오. (날짜, 상품코드, 매입수량)
-and + BETWEEN 연산자를 이용
  SELECT BUY_DATE AS 날짜,
         PROD_ID AS 상품코드, 
         BUY_QTY AS 매입수량
   FROM BUYPROD
   --WHERE BUY_DATE >= '20200101' AND BUY_DATE <= '20200131'
   WHERE BUY_DATE BETWEEN '20200101' AND '20200131'
   ORDER BY 1;
 
 2) HR 계정 EMPLOYEES 테이블에서 10번~40번부서에 속한 사원 정보를 조회하시오.
    Alias는 사원번호, 사원명, 입사일, 부서번호 
    
    SELECT EMPLOYEE_ID AS 사원번호, 
           EMP_NAME AS 사원명,
           HIRE_DATE 입사일,
           DEPARTMENT_ID AS 부서번호
    FROM C##HR.EMPLOYEES
    WHERE DEPARTMENT_ID BETWEEN 10 AND 40
    --WHERE DEPARTMENT_ID IN(10,20,30,40)
    --WHERE DEPARTMENT_ID = ANY(10,20,30,40)
   /* WHERE DEPARTMENT_ID = 10
    OR DEPARTMENT_ID = 20
    OR DEPARTMENT_ID = 30
    OR DEPARTMENT_ID = 40*/
    --WHERE DEPARTMENT_ID>=10 AND DEPARTMENT_ID <= 40
    ORDER BY 4;
    
2. LIKE 
   패턴을 비교할 때 사용.
   패턴 문자'%'와 '_'사용
   -'%' : 길이와 상관 없이 (문자 없는 경우도 포함) 모든 문자 데이터를 의미.
    EX) '김%'   :   '김'으로 시작하는 모든 문자열과 대응. '김' 문자열도 대응(참, 같은 값으로 취급되어짐)
        '%김'   :   '김'으로 끝나는 모든 문자열과 대응. '김'문자열도 대응.
        '%김%'  :   '김'이라는 글자가 있다면, 전체 출력.
        
   -'_' : 어떤 값이든 상관 없이 한 개의 문자 데이터를 의미.
     EX) '김_'  :   글자가 2글자이고, '김'으로 시작하는 모든 문자열과 대응.
         '_김'  :   글자가 2글자이고, '김'으로 끝나는 모든 문자열과 대응.
         '_김_' :   3글자 문자열에 두번째 문자로 '김'이 존재하면 참을 반환.
   
(사용형식)
expr  LIKE 패턴문자열
   LIKE 연산자는 문자열 비교에 사용됨.
-where 절의 조건문에 사용
-LIKE 연산자는 문자열 비교에 사용됨.
 
   
expr  BETWEEN 값1 AND 값2
- expr 값이 '값1'에서 '값2' 사이에 존재하면 참(true)를 반환.

   
(사용예)
1)회원 중 대전에 거주하는 회원을 검색하시오(회원번호,회원명,주소)

SELECT MEM_ID AS 회원번호,
       MEM_NAME AS 회원명,
       MEM_ADD1||' '||MEM_ADD2 AS 주소
FROM MEMBER
WHERE MEM_ADD1 LIKE '대전%';

2)2020년 6월의 판매정보를 조회하시오.(날짜, 상품코드, 구매회원번호, 수량)

SELECT TO_DATE (SUBSTR (CART_NO, 1,8)) AS 날짜,
        PROD_ID AS 상품코드,
        MEM_ID AS 구매회원번호,
        CART_QTY AS 수량
FROM CART
WHERE CART_NO LIKE '202006%'
ORDER BY 1;

3)2020년 6월 매입정보를 조회하시오(매입날짜, 상품번호, 매입수량)

SELECT BUY_DATE AS 매입날짜,
       PROD_ID AS 상품번호,
       BUY_QTY AS 매입수량
FROM BUYPROD
WHERE BUY_DATE BETWEEN TO_DATE ('20200601') AND ('20200630')
ORDER BY 1;

3. IN
    - 기술된 필드가 여러 개의 값 중에 하나인 경우인지를 살펴보기 위한 연산자.
    - 비교연산자와 논리연산자 OR을 사용하여 복잡하게 쿼리문을 작성하지 않고, 훨씬 간단하게 표현
    - 불연속적이거나 불규칙적인 값을 비교하는 경우 사용.

(사용형식)
    EXPR  IN(값1, 값2, ..., 값n)
      . expr의 값이 '값1, 값2,...,값n' 중 하나와 같으면 참(true)를 반환.
      . IN 연산자는 '='기능을 내포하고 있으며, 다른 관계연산자 사용할 수 없음.
      . =ANY, =SOME, OR 연산자로 대처 가능.
      
      
(사용예)
1) HR 계정에서 20, 40, 90번 부서에 속한 사원을 조회하시오.(사원번호,사원명,부서번호,직책)

SELECT EMPLOYEE_ID AS 사원번호,
       EMP_NAME AS 사원명,
       DEPARTMENT_ID AS 부서번호,
       JOB_ID AS 직책
FROM C##HR.EMPLOYEES
WHERE DEPARTMENT_ID IN (20,40,90)
ORDER BY 3; 


** 표현식
    - 표준 SQL에서는 분기명령이 제공되지 않음.
    - SELECT 절에서 분기기능(JAVA의 SWTICH ~ CASE 문의 기능)을 제공.
    - CASE WHEN ~ THEN, DECODE 가 제공됨.

    (1) CASE WHEN ~ THEN
    사용형식 1)
        CASE WHEN 조건식1 THEN 값1
             WHEN 조건식2 THEN 값2
                       :
                [ELSE 값N]
            END
            .식을 평가하여 그 값이 '값1'이면 '반환값1'을 반환하고 아니면 '식'의 결과를 평가함.
            .'ELSE 값N'은 모든 값이 식과 일치하지 않으면 만족하지 않으면 수행.
            .자바의 SWITCH ~ CASE 와 유사함.
            .반드시 'END'로 종료해야 함.
            
    (2) DECODE(컬럼명, 조건1, 결과1, 조건2, 결과2,...조건N, 결과N+!)
        . 컬럼의 값이 조건1과 같으면 결과1을 반환하고 아니면 이후의 조건들을 차례대로
          비교하며 모든 조건이 만족되지 않으면 결과n+1을 반환함.

2) 회원테이블에서 회원번호, 회원명, 나이, 성별, 마일리지를 조회하시오.

3) 2020년 6월에 구매하지 않은 회원들을 조회하시오. 회원번호, 회원명, 성별, 마일리지

SELECT MEM_ID AS 회원번호,
       MEM_NAME AS 회원명,
       MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호,
       CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','2') THEN
       EXTRACT(YEAR FROM SYSDATE)-(1900+TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)))
       ELSE EXTRACT(YEAR FROM SYSDATE)-(2000+TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)))
       END AS 나이,
       DECODE(SUBSTR(MEM_REGNO2,1,1),'1','남성회원','2','여성회원','3','남성회원','4','여성회원') AS 성별,
       MEM_MILEAGE AS 마일리지
       FROM MEMBER;
       
       
3) 2020년 6월에 구매하지 않은 회원들을 조회하시오.(회원번호,회원명,성별,마일리지)

SELECT MEM_ID AS 회원번호,
       MEM_NAME AS 회원명,
       MEM_MILEAGE AS 마일리지
FROM MEMBER
WHERE MEM_ID NOT IN (SELECT DISTINCT MEM_ID
                     FROM CART
                     WHERE CART_NO LIKE '202006%');

(2020년 6월에 구매한 회원번호)
       
