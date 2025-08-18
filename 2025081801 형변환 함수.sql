2025-0818-01) 형변환 함수
  - TO_CHAR, TO_DATE, TO_NUMBER, CAST
  
  
1. TO_CHAR(c|d|n [,fmt])
    - 주어진 자료(문자열, 숫자, 날짜 타입)를 문자열로 바꿈
    - 주어진 자료가 문자열인 경우 타입이 CLOB이나 CHAR인 자료를 VARCHAR2로 바꿀 때만 가능
    - fmt는 문자열로 바꿀 때 적용되는 형식으로 날짜형식과 숫자형식으로 구분
    
    1) 날짜 형식 지정 문자열
    --------------------------------------------------
    형식문자열        | 의미            |  예
    --------------------------------------------------
    AD,BC,CC        | 서기(AD),       |
                    | 기원전(BC),     |
                    | 세기(CC)        | SELECT TO_CHAR(SYSDATE, 'AD   BC   CC   Q') FROM DUAL;
    Q               | 분기            | SELECT TO_CHAR(SYSDATE, 'Q') || '분기' FROM DUAL;
    YYYY,YYY,YY,Y   | 년도            | SELECT TO_CHAR(SYSDATE, 'YYYY   YYY    YY   Y') FROM DUAL;       
    YEAR            | 년도            | SELECT TO_CHAR(SYSDATE, 'YEAR') FROM DUAL;
    MONTH, MON      | 월              | SELECT TO_CHAR(SYSDATE, 'MONTH     MON') FROM DUAL;
    MM, RM          | 월              | SELECT TO_CHAR(SYSDATE, 'MM      RM') FROM DUAL; 
    DDD, DD, J      | 일              | SELECT TO_CHAR(SYSDATE, 'DDD  DD  J') FROM DUAL;
    DAY, DY, D      | 요일            | SELECT TO_CHAR(SYSDATE, 'DAY   DY  D') FROM DUAL;
    

2. TO_DATE


3. TO_NUMBER

4. CAST