2025-0811-02)함수
    -이미 프로그램되고 컴파일되어 저장되어 있으며, 사용자가 필요한 경우 호출하여 결과를 
     반환 받을 수 있는 모듈
    -문자열, 숫자, 날짜, 변환 함수, NULL처리함수, 집계함수, 순위함수 등이 제공.
    - 함수는 함수를 포함할 수 있다.

1.  문자열 함수
    - 1) ||
        - 문자열 결합 연산자
        - JAVA의 문자열 "+" 연산자와 동일 기능.
        
      2) CONTACT(c1, c2)
        - 문자열 c1과 c2를 결합하여 반환.
        - c1 || c2와 동일.
        
사용예) 회원테이블에서 회원번호, 회원명, 주민번호를 출력하시오.
       단, 주민번호는 'XXXXXX-XXXXXXX'형식으로 출력하시오.
       
       SELECT MEM_ID AS 회원번호,
              MEM_NAME AS 회원명,
              MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호
              --CONCAT (CONCAT(MEM_REGNO1,'-'), MEM_REGNO2) AS 주민번호
         FROM MEMBER;
        
      3) LOWER(C1), UPPER(C2), INITCAP(C1)
        - 주어진 문자열을 모두 소문자로(LOWER), 모두 대문자로(UPPER).
          각 단어의 시작문자만 대문자로(INITCAP) 변환.
          
사용예) 상품의 분류코드 'p102'에 속한 상품번호, 상품명, 매입가격을 출력하시오.

        SELECT PROD_ID AS 상품번호,
               PROD_NAME AS 상품명,
               PROD_COST AS 매입가격
          FROM PROD
         WHERE LOWER(LPROD_GU)='p102';
         
(INITCAP)
    SELECT EMPLOYEE_ID, EMP_NAME, LOWER(EMP_NAME), INITCAP(LOWER(EMP_NAME))
    FROM C##HR.EMPLOYEES
    WHERE DEPARTMENT_ID=80;
          
      4) LPAD(c1, n [,c2]), RPAD(c1, n [,c2])
        - 주어진 문자열 c1을 n자리에 오른쪽부터 채우고 남는 공간에 c2를 채움(LPAD)
        - 주어진 문자열 c1을 n자리에 왼쪽부터 채우고 남는 오른쪽 공간에 c2를 채움(RPAD)
        - c2를 생략하면 공백을 채움.
        
사용예)
    SELECT PROD_NAME, RPAD(PROD_COST,10,'#'),LPAD(PROD_COST,10)
    FROM   PROD
    WHERE  PROD_COST < 300000
    ORDER BY 2;
    

5. LTRIM(c1 [,c2]), RTRIM(c1 [,c2])
    - 주어진 문자열 c1에서 왼쪽부터(LTRIM), 또는 오른쪽(RTRIM)부터 c2 문자열 패턴과 동일한 
      문자열을 찾아 삭제
    - c2가 생략되면 왼쪽(LTRIM) 또는 오른쪽(RTRIM)에 존재하는 공백을 제거
    
사용예)
    SELECT LTRIM('AABBCDABAB', 'AB'), AS "COL1",
        LTRIM('     DAB AB  '), AS "COL2",
        RTRIM('AABBCDABAB', 'AB'), AS "COL3",
        RTRIM('DA BAB   ') AS "COL4"
    FROM DUAL;

    
6. TRIM(c1)
    - c1체에 포함된 양쪽 공백을 찾아 삭제

사용예) CART테이블에 오늘 날짜의 장바구니 번호를 생성하여 출력하시오.
       단, 내가 오늘 맨 처음 로그인한 회원임.
       
        SELECT TO_CHAR(SYSDATE, 'YYYYMMDD')||TRIM(TO_CHAR(1,'00000'))
        FROM   DUAL;
        
7. SUBSTR(c1, n [,count])
   - 주어진 문자열 c1에서 n위치부터 count 갯수 만큼의 부분 문자열을 추출하여 반환.
   - count가 생략되면 n부터 나머지 모든 문자열을 반환
   - n이 음수이면 오른쪽 부터 시작하여 count갯수 만큼의 부분 문자열을 추출하여 반환.
   
사용예)
    SELECT MEM_ADD1,
           SUBSTR(MEM_ADD1,1,2) AS "COL2",
           SUBSTR(MEM_ADD1,3),
           SUBSTR(MEM_ADD1,-10,5)
    FROM   MEMBER;
    
사용예) 매출 자료 중 년도에 상관없이 5월에 판매된 상품별 판매수량 합계를 조회하시오.
    
    SELECT PROD_ID AS 상품번호,
        SUM (CART_QTY) AS "판매수량 합계"
    FROM   CART
    WHERE SUBSTR(CART_NO,5,2)='05'
    GROUP BY PROD_ID
    ORDER BY 2 DESC;
    
    
8. INSTR(c, c1 [,loc1 [,rept])
    - 주어진 문자열 c에서 처음 만난 c1의 위치를 반환
    - loc는 시작 위치 값
    - rept는 반복횟수 정의
    
사용예)
    SELECT INSTR('PERSIMONPEARAPPLE', 'P') AS "COL1",
           INSTR('PERSIMONPEARAPPLE', 'P',3) AS "COL2",
           INSTR('PERSIMONPEARAPPLE', 'P',3,2) AS "COL3"
        FROM DUAL;
    
9. REPLACE(c, c1[ ,c2])
    - 주어진 문자열 c1을 찾아 c2로 대치 시킴
    - c2가 생략되면 c1을 찾아 삭제
    
 사용예) 상품테이블에서 상품명 중 '삼성'을 찾아 'SAMSUNG'으로 치환하고,
        문자열 내부의 공백을 제거하시오.
 
    SELECT PROD_NAME,
            REPLACE (PROD_NAME, '삼성','SAMSUNG') AS "COL2",
            REPLACE (PROD_NAME, ' ') AS "COL3"
      FROM PROD; 
    
    