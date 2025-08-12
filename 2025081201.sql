2025-0812-01) 함수

숫자함수

1) 수학적 함수 ABS(n), SIGN(n), SQRT(n), POWER(b, n)

ABS : n의 절대값
SIGN : n의 부호에 따라 음수이면 -1, 0이면 0, 양수이면 1을 반환
SQRT : n의 평방근(루트)
POWER : b의 n승값 (b를 n번 거듭제곱한 값)

사용예)
SELECT ABS(-1200), ABS(1200), SIGN(0.000001), SIGN(1200), SIGN(0),
SQRT(16), POWER(2,10)
FROM DUAL;


★★★★
2) ROUND(n [, m])
  m이 양수인 경우: 주어진 자료 n의 소수부분 m+1번째 자리에서 반올림하여 m번째까지 반환
  m이 음수인 경우: 주어진 자료 n의 정수부분 m번째 자리에서 반올림하여 반환

사용예)HR계정의 사원테이블에서 사원들의 보너스를 계산하여 지급액을 출력하는 SQL문을 작성하라.
보너스 = 급여 * 영업실적 * 30%
지급액=급여+보너스
출력은 사원번호,사원명,영업실적,급여,보너스,지급액이며
지급액은 일의 자리에서 반올림하고, 보너스는 소수 첫자리에서 반올림하시오.

SELECT EMPLOYEE_ID AS 사원번호,
       EMP_NAME AS 사원명,
       NVL(COMMISSION_PCT,0) AS 영업실적,
       SALARY AS 급여,
       ROUND(SALARY*NVL(COMMISSION_PCT,0)*0.3) AS 보너스,
       ROUND(SALARY+ROUND(SALARY*NVL(COMMISSION_PCT,0)*0.3),-1) AS 지급액
FROM C##HR.EMPLOYEES

SELECT ROUND(230/17,2), TRUNC(230/17,2)  FROM DUAL;

★★★
TRUNC(n [, m])
  m이 양수인 경우: 주어진 자료 n의 소수부분 m+1번째 자리에서 절삭하여 m번째까지 반환
  m이 음수인 경우: 주어진 자료 n의 정수부분 m번째 자리에서 절삭하여 반환

MOD(n [, m]) : n을 m으로 나눈 나머지 반환 (Java의 % 연산자 기능)

사용예)
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_BIR AS 생년월일,
    CASE MOD((TRUNC(MEM_BIR)-TO_DATE('00010101')-1),7)
                WHEN 0 THEN '일요일'
                WHEN 1 THEN '월요일'
                WHEN 2 THEN '화요일'
                WHEN 3 THEN '수요일'
                WHEN 4 THEN '목요일'
                WHEN 5 THEN '금요일'
                ELSE '토요일' 
            END AS 요일
    FROM MEMBER;

FLOOR(n) : n과 같거나 작은 수 중에서 가장 큰 정수

CEIL(n) : n과 같거나 큰 수 중에서 가장 작은 정수. 소수점 이하의 값이 존재하면 무조건 올림.
급여·세금 계산 등 금액 계산에서 자주 사용됨.

사용예)
    SELECT FLOOR(2.43), FLOOR(10), FLOOR(-12.5), CEIL(2.43), CEIL(10), CEIL(12.5)
    FROM DUAL;

GREATEST(n1,n2,...n),  LEAST(n1,n2,....n)
    주어진 n1,n2,...n 에서 가장 큰 값(GREATEST) 또는 가장 작은값(LEAST)을 반환
    'n1,n2,...n'은 모든 동일 자료형 이어야 함.
    
사용예)
    SELECT GREATEST(200,3400, 20), LEAST('홍길동', '홍길순', '홍길남')
    FROM DUAL;
    
    문제] 회원 테이블에서 마일리지가 1000미만인 회원의 마일리지를 1000으로 출력하고 1000이상
    회원은 보유 마일리지를 그대로 출력하시오.
    
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_MILEAGE AS 마일리지,
  GREATEST(MEM_MILEAGE,1000) AS 변경마일리지
    FROM MEMBER;

7)WIDTH_BUCKET(n, lower, upper, block_count)
  - block(구간)은 항상 1부터 카운팅.
  - 하한 값 lower에서 상한값 upper를 block_count 갯수 만큼의 블록으로 
    나누었을 때 주어진 값 n이 소속된 블록의 순번을 반환.
  - 한 블록에는 하한 값은 포함되지만 상한 값은 포함되지 않음(다음 구간에 포함)
  - 블록의 갯수가 n개일 때 출력되는 블록의 수는 n+2개임(하한 값 미만과 상한값 이상)
  
사용예) 회원테이블에서 마일리지 값을 1000-8000사이를 8개의 구간으로 나누고
       회원들이 보유한 마일리지가 속한 구간에 따라 구간값, 회원 등급을 출력하시오.
       회원등급은 비고란에 출력.
       ALIAS는 회원번호, 회원명, 마일리지,등급,비고
       
       0-3:초급회원
       4-6:보통회원
       7이상:VIP회원
       
       SELECT MEM_ID AS 회원번호,
              MEM_NAME AS 회원명,
              MEM_MILEAGE AS 마일리지,
              WIDTH_BUCKET(MEM_MILEAGE,1000,8000,8) AS 등급,
       CASE WHEN WIDTH_BUCKET(MEM_MILEAGE,1000,8000,8) BETWEEN 0 AND 3 THEN '초급회원'
            WHEN WIDTH_BUCKET(MEM_MILEAGE,1000,8000,8) BETWEEN 4 AND 6 THEN '보통회원'
            ELSE 'VIP회원'
        END AS 비고
       FROM MEMBER
       ORDER BY 3 DESC;
       

문제) 위 문제에서 가장 마일리지가 많은 회원부터 '1등급회원' 등 차례대로 등급을 출력하는 
     쿼리 작성.     ALIAS는 회원번호, 회원명, 마일리지, 회원등급
     
     SELECT MEM_ID AS 회원번호,
            MEM_NAME AS 회원명,
            MEM_MILEAGE AS 마일리지,
    10-WIDTH_BUCKET(MEM_MILEAGE,1000,8000,8)||'등급회원' AS 회원등급
    FROM MEMBER
    ORDER BY 3 DESC;
    
    
    
    
    
    SELECT MEM_ID AS 회원번호,
            MEM_NAME AS 회원명,
            MEM_MILEAGE AS 마일리지,
    WIDTH_BUCKET(MEM_MILEAGE,700,8700,24)||'등급' AS 등급
    FROM MEMBER
    WHERE WIDTH_BUCKET(MEM_MILEAGE,700,8700,24) = 3
    ORDER BY 3 DESC;