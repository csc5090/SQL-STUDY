2025-0812-02)
3. 날짜함수
    1) SYSDATE
        - 표준 날짜 함수
        - 시스템이 제공하는 년,월,일,시,분,초를 형태로 전환.
        - 덧셈과 뺄셈의 대상이 될 수 있으며 날짜의 뺄셈은 두 날짜 사이에 경과된 날수를 반환.
        
사용예)
    SELECT SYSDATE, SYSDATE-10, SYSDATE+35,
           SYSDATE-TO_DATE('20241215'),TRUNC(SYSDATE)-TO_DATE('20241215')
        FROM DUAL;
        
        
2.ADD_MONTH(date, n)
    - 주어진 날짜자로 date의 월에 n을 더한 날짜를 반환.
    
사용예2)
회원테이블에서 MEM_BIR이 회원 만료일이라 가정했을 때. 2달 후 7일 전의 날짜를ㅜ하시오.
SELECT MEM_ID AS 회원번호,
       MEM_NAME AS 회원명,
       MEM_BIR AS 일자,
       ADD_MONTHS(MEM_BIR,2) AS 만료일,
       ADD_MONTHS(MEM_BIR,2)-7 AS 알람일자
FROM MEMBER;
        
3. NEXT_DAY(date, c)  ex) SELECT NEXT_DAY(DATE '2025-08-12', '화요일')
  - 주어진 날짜 'date'에서 다가올 'c'요일의 날짜를 반환.
  - 'c'는 '월요일', '월' ~ '일요일', '일'을 써야함.

사용예)
SELECT NEXT_DAY(SYSDATE,'화요일'),
       NEXT_DAY(SYSDATE,'목요일')
    FROM DUAL;
    

사원테이블에서 80번 부서의 사원들 근속기간을 XX년 XX개월 형식으로 출력하여 조회하시오.
       ALIAS는 사원번호, 사원명, 입사일, 근속기간.
       
4. LAST_DAY(date)
  - 주어진 날짜자료에 포함된 월의 마지막일을 포함하는 날짜 반환
  

사용예) 키보드로 1-6월 사이의 월을 입력받아 해당월의 매입총액을 출력하시오.

    ACCEPT P_MONTH PROMPT '월(1-6) 입력 : '
    DECLARE
            L_SUM NUMBER:=0;
            S_DATE DATE := TO_DATE('2020'||TRIM(TO_CHAR(&P_MONTH, '00'))||'01');
            E_DATE DATE := LAST_DAY(S_DATE);
    BEGIN
            SELECT SUM(A.BUY_QTY*B.PROD_COST) INTO L_SUM
            FROM BUYPROD A
            INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
            WHERE A.BUY_DATE BETWEEN S_DATE AND E_DATE;
            
            DBMS_OUTPUT.PUT_LINE(&P_MONTH||'월의 매입 총액은 '||
            TO_CHAR(L_SUM,'9,999,999,999')'원입니다');
    END;
    
    
    
5. MONTHS_BETWEEN(d1,d2)
    - 두 날짜 자료(d1,d2) 사이의 개월수를 반환
    - 나이나 경력 산정 등에 사용
    
    SELECT MEM_ID AS 회원번호,
              MEM_NAME AS 회원명,
              MEM_BIR AS 생년월일,
              TRUNC(MONTHS_BETWEEN(SYSDATE, MEM_BIR)/12) ||'년' ||
              ROUND(MOD(MONTHS_BETWEEN(SYSDATE, MEM_BIR),12))||'월' AS 나이
       FROM MEMBER;
    
사용예) 회원테이블에서 회원들의 나이를 xx년 xx개월 형식으로 구하여 출력하시오.
       나이는 MEM_BIT컬럼을 이용하여 계산하고, 회원번호, 회원명, 생년월일, 나이를 구하시오.
       
       SELECT MEM_ID AS 회원번호,
              MEM_NAME AS 회원명,
              MEM_BIR AS 생년월일, 
              TRUNC(MONTHS_BETWEEN(SYSDATE, MEM_BIR)/12) ||'년 ' ||
              ROUND(MOD(MONTHS_BETWEEN(SYSDATE, MEM_BIR),12))||'월' AS 나이
       FROM MEMBER;
       

사용예) 사원테이블에서 80번 부서의 사원들 근속기간을 XX년 XX개월 형식으로 출력.
        AS 는 사원번호, 사원명, 입사일, 근속기간
        
        
        
        
6. EXTRACT(fmt FROM date)
  - 주어진 날짜자료 date에서 필요한 부분만 추출
    (fmt=YEAR, MONTH, DAY, HOUR, MINUTE, SECOND)
  - 추출된 자료의 데이터 타입은 숫자
  
  
사용예) 회원테이블에서 다음달 생일인 회원들을 추출하시오.
       AS는 회원번호, 회원명, 생년월일, 핸드폰번호,

      
      SELECT MEM_ID AS 회원번호,
             MEM_NAME AS 회원명,
             MEM_BIR AS 생년월일,
             MEM_HP AS 핸드폰번호
      FROM MEMBER
      WHERE
      EXTRACT (MONTH FROM SYSDATE)+1=EXTRACT(MONTH FROM MEM_BIR);