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
    AM, A.M,        | 오전            | SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD AM') FROM DUAL; 
    PM, P.M,        | 오후            | SELECT TO_CHAR(SYSDATE, 'PM   P.M') FROM DUAL;
    HH, HH12, HH24  | 시간            | 
    MI              | 분              | SELECT TO_CHAR(SYSDATE, 'YYYY MM DD HH MI SS') FROM DUAL;
    SS, SSSSS       | 초              | SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SSSSS') FROM DUAL;
                                        SELECT 15*60*60+57*60+04 FROM DUAL;
    "   "           | 사용자 정의 문자열 |  SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일" HH24:MI:SS  SSSSS') FROM DUAL;

2) 숫자 형식 지정 문자열
--------------------------------------------------------------------------------
    형식 문자열       |     의미                             |  예
--------------------------------------------------------------------------------
         9         |출력형식의 자리, 유효한 숫자인 경우 출력     | SELECT TO_CHAR(2345, '99999999') AS "COL1" FROM DUAL;
                   |유효숫자가 아닌 경우 공백 출력              |
                   |(소수점은 대응 안되는 자리에서 반올림)       | SELECT TO_CHAR(2345, '00000000') AS "COL1" FROM DUAL;
         0         |출력형식의 자리, 유효한 숫자인 경우 출력     |            
                   |유효숫자가 아닌경우 '0'출력(소수점 마찬가지)  |            
      $,  L        |달러 및 지역화폐 기호를 유효숫자 왼쪽에 출력  |SELECT TO_CHAR(PROD_COST, '$999,999') AS 매입가 FROM PROD WHERE LPROD_GU='P201';
       MI          |음수인 경우 우측에 마이너스 표시.           |SELECT TO_CHAR(-23456, '99,999MI') FROM DUAL;
                   |형식 문자열 우측에 기술                   |
       PR          |음수인 경우 자료를 "< >"안에 표시.         |SELECT TO_CHAR(-23456, '99,999PR') FROM DUAL;
                   |형식 문자열 우측에 기술                   |
  ,(COMMA),        |3자리마다의 자리점                       |
  .(DOT)           |소숫점                                 |


2. TO_NUMBER(c [,fmt])
    - 주어진 문자열 자료 'c'의 값을 숫자로 변환함.
    - 'c'는 반드시 숫자로 변환 가능한 값이어야 함.
    - 'fmt'는 'c'에 포함된 편집문자열 때문에 자동으로 숫자로 변환할 수 없을 때
      기본형 숫자를 'c'로 편집하기 위해 사용된 형식문자열이며 출력은 기본 숫자형임 
      SELECT TO_NUMBER('1234'),
             TO_NUMBER('-3456'),
             TO_NUMBER('23.56')
      FROM DUAL;
      
      SELECT TO_NUMBER('1234'),
             TO_NUMBER('\3456'),
             TO_NUMBER('23.56')
      FROM DUAL;
      
      SELECT TO_NUMBER('1,234', '9,999'),
             TO_NUMBER('1,234', '0,000'),
             TO_NUMBER('￦3456', 'L9999'),
             TO_NUMBER('<23.56>', '99.99PR')
      FROM DUAL;

ALTER SESSION SET NLS_DATE_FORMAT='YYYY/MM/DD HH24:MI:SS';



3. TO_DATE(c|n [,fmt])
    - 주어진 문자열 자료 'c' 또는 숫자자료 n을 날짜타입으로 변환함.
    - 'c'와 n은 반드시 날짜로 변환 가능한 타입이어야 함.
    - 'fmt'는 'c'에 포함된 편집문자열 때문에 자동으로 날짜로 변환할 수 없을 때 또는 시분초 값이 정의 되었을 때 
      'c'로 편집하기 위해 사용된 형식문자열이며 출력은 기본 날짜형임.
      
      SELECT TO_DATE('20250818'),
             TO_DATE(20250818)
      FROM DUAL;
    
      SELECT TO_DATE('오후 5:18 2025-08-18','AM HH:MI YYYY-MM-DD')
      FROM DUAL;

      SELECT EXTRACT(MONTH FROM TO_DATE('오후 5:18 2025-08-18','AM HH:MI YYYY-MM-DD'))
        FROM DUAL;


4. CAST(컬럼 AS 타입)
    - 컬럼의 자료형을 AS 다음에 기술한 타입으로 변환해 줌.
    - 모든 자료형을 변환할 수 있으나 형식을 지정하여 변환은 불가능.
    

    SELECT CAST(12345 AS CHAR(5)) AS "COL1",
           CAST(SYSDATE AS VARCHAR2(100)) AS "COL2",
           CAST('<23,456>' AS NUMBER(6)) AS "COL3"--형식지정을 해야함.
      FROM DUAL;