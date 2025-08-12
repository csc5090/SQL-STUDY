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