2025-09-01-01) 반복문

- 오라클의 반복문은 LOOP, WHILE, FOR 문이 제공됨.

1. LOOP문
 - 반복문의 기본구조를 제공
 - 무한 루프를 제공함

사용형식) 
    LOOP
        반복처리문(들);
        EXIT WHEN 조건;
        [반복처리문(들);]
        END LOOP;
    
    . 'EXIT WHEN 조건' : 조건이 만족하면 반복을 벗어남
    
    
사용예) 구구단의 7단을 출력.

DECLARE
    L_CNT NUMBER:=1;
BEGIN
    LOOP
    EXIT WHEN L_CNT > 9;
    DBMS_OUTPUT.PUT_LINE('7 * '||L_CNT||' = '||7*L_CNT);
    L_CNT:=L_CNT+1;
    END LOOP;
END;

사용예) 충남에 거주하는 회원들의 2020년 4월 구매현황을 조회하시오.
       출력은 회원번호, 회원명, 구매금액합계이다.
       


커서) 2020년 5월 충남 거주 회원들이 구매한 상품코드, 회원번호,회원명
    
DECLARE L_MID MEMBER.MEM_ID%TYPE;
        L_NAME VARCHAR2(100);
        L_SUM NUMBER:=0;
        
        CURSOR cur_cart_05 IS 
         SELECT MEM_ID, MEM_NAME
           FROM MEMBER
          WHERE MEM_ADD1 LIKE '충남%';

BEGIN
    OPEN cur_cart_05;
    LOOP
    FETCH cur_cart_05 INTO L_MID,L_NAME;
    EXIT WHEN cur_cart_05%NOTFOUND;
    SELECT SUM(A.CART_QTY*B.PROD_PRICE) INTO L_SUM
      FROM CART A, PROD B
      WHERE A.PROD_ID=B.PROD_ID
        AND A.MEM_ID=L_MID
        AND A.CART_NO LIKE '202005%';
      DBMS_OUTPUT.PUT_LINE(L_MID||'  '||L_NAME||'  '||TO_CHAR(NVL(L_SUM,0),'99,999,999'));
      DBMS_OUTPUT.PUT_LINE('---------------------------------');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('처리 건수 : '||cur_cart_05%ROWCOUNT);
    CLOSE cur_cart_05;
END;


사용예) 입력 받은 부서번호를 이용하여 해당부서에 근무하는 사원정보를 출력하시오
       출력 사원번호, 사원명, 부서번호, 부서명, 입사일
       
DECLARE 
  L_EID C##HR.EMPLOYEES.EMPLOYEE_ID%TYPE;   -- 사원번호
  L_ENAME VARCHAR2(100); --사원명
  L_DID C##HR.DEPARTMENTS.DEPARTMENT_ID%TYPE; -- 부서번호
  L_DNAME VARCHAR2(50); -- 부서명
  L_HIRE_DATE DATE; -- 입사일
  
  CURSOR cur_emp_02(P_DID C##HR.DEPARTMENTS.DEPARTMENT_ID%TYPE) IS 
    SELECT EMPLOYEE_ID
    FROM C##HR.EMPLOYEES
    WHERE DEPARTMENT_ID=P_DID;

BEGIN
    OPEN cur_emp_02(30);
    LOOP
    FETCH cur_emp_02 INTO L_EID;
    EXIT WHEN cur_emp_02%NOTFOUND;
    SELECT A.EMP_NAME, B.DEPARTMENT_ID, A.HIRE_DATE, B.DEPARTMENT_NAME
        INTO L_ENAME,L_DID,L_HIRE_DATE,L_DNAME
    FROM C##HR.EMPLOYEES A, C##HR.DEPARTMENTS B
    WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
    AND A.EMPLOYEE_ID=L_EID;
    DBMS_OUTPUT.PUT_LINE('사원번호 :'||L_EID);
    DBMS_OUTPUT.PUT_LINE('사원명 :'||L_ENAME);
    DBMS_OUTPUT.PUT_LINE('부서번호 :'||L_DID);
    DBMS_OUTPUT.PUT_LINE('부서명 :'||L_DNAME);
    DBMS_OUTPUT.PUT_LINE('입사일 :'||L_HIRE_DATE);
    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('처리 인원 : '||cur_emp_02%ROWCOUNT);
    CLOSE cur_emp_02;
END;



2.WHILE 문
  - 일반 웹 개발언어의 WHILE과 같은 기능
  
  사용형식)
  WHILE 조건 LOOP
    반복처리문(들);
        :
        :
    END LOOP;
    
    .'조건'이 참이면 반복처리문들을 수행하고 조건이 거짓이면 END LOOP 다음명령 수행
    
사용예) 구구단의 7단을 만들기

DECLARE 
    L_CNT NUMBER:=0;
BEGIN
    WHILE L_CNT < 9
    LOOP
    L_CNT:=L_CNT+1;
    DBMS_OUTPUT.PUT_LINE('7 * '||L_CNT' = '||7*L_CNT);
    END LOOP;
END;




사용예 ) 입력 받은 분류에 속한 상품의 2020년 매입현황을 조회하시오.
        출력은 상품번호, 상품명, 매입금액
   
   
        
DECLARE 
  L_PID   PROD.PROD_ID%TYPE;     -- 상품번호
  L_PNAME PROD.PROD_NAME%TYPE;   -- 상품명
  L_MSUM  NUMBER := 0;           -- 매입금액

  CURSOR cur_buyprod_02(P_LPROD_GU LPROD.LPROD_GU%TYPE) IS
    SELECT PROD_ID, PROD_NAME
      FROM PROD
     WHERE LPROD_GU = P_LPROD_GU;
BEGIN
  OPEN cur_buyprod_02('P102');
  FETCH cur_buyprod_02 INTO L_PID, L_PNAME;
  WHILE cur_buyprod_02%FOUND LOOP
    -- 상품별 2020년 매입금액 합계
    SELECT NVL(SUM(A.BUY_QTY * B.PROD_COST), 0)
      INTO L_MSUM
      FROM BUYPROD A
      JOIN PROD B ON A.PROD_ID = B.PROD_ID
     WHERE A.PROD_ID = L_PID
       AND EXTRACT(YEAR FROM A.BUY_DATE) = 2020;

    DBMS_OUTPUT.PUT_LINE('상품코드 : ' || L_PID);
    DBMS_OUTPUT.PUT_LINE('상품명   : ' || L_PNAME);
    DBMS_OUTPUT.PUT_LINE('매입금액 : ' || TO_CHAR(L_MSUM, 'FM999,999,999'));
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------');

    FETCH cur_buyprod_02 INTO L_PID, L_PNAME; -- 다음 행 가져오기
  END LOOP;

  CLOSE cur_buyprod_02;
END;


3. 일반 FOR 문
  - 일반 웹 개발언어의 FOR 와 같은 기능
  
사용형식) 
FOR 제어인덱스 [REVERSE] IN 초기값...최종값 LOOP
    반복처리문(들);
        :
        :
    END LOOP;
    . 제어인덱스에 초기값을 할당하여 최종값과 비교하여 범위내의 값이면 반복실행
    . 제어인덱스는 시스템에서 설정하는 변수이며 1씩 증가.
    . REVERSE가 사용되면 역순으로 반복처리됨.
    
    
사용예) 구구단 7단 출력하기.

DECLARE
BEGIN
    FOR I IN 1..9 LOOP
    DBMS_OUTPUT.PUT_LINE('7 * '||I||' = '||7*I);
    END LOOP;
END;

3-1) 커서용 FOR 문
일반 FOR문과 다르게 커서에 사용되는 FOR문 
- OPEN, FETCH, CLOSE 문을 생략함.

사용형식) 
FOR 레코드명 IN 커서명[매개변수값]|커서문의 SELECT 명령 LOOP 
    커서처리문;
END LOOP;
    .커서에 있는 컬럼 참조 : 레코드명.커서컬럼명
    
사용예) 입력받은 분류에 속한 상품의 2020년 매입현황을 조회하라.
        상품번호, 상품명, 매입금액 출력하기
        
        
DECLARE 
    L_MSUM NUMBER:=0; -- 매입금액

CURSOR cur_buyprod_03(P_LPROD_GU LPROD.LPROD_GU%TYPE) IS
    SELECT PROD_ID,PROD_NAME
    FROM PROD
    WHERE LPROD_GU=P_LPROD_GU;
BEGIN 
FOR REC IN cur_buyprod_03('P201') LOOP
SELECT SUM(A.BUY_QTY*B.PROD_COST) INTO L_MSUM
FROM BUYPROD A, PROD B
WHERE EXTRACT(YEAR FROM A.BUY_DATE)=2020
AND A.PROD_ID=REC.PROD_ID
AND A.PROD_ID=B.PROD_ID;
    DBMS_OUTPUT.PUT_LINE('상품코드 : ' || REC.PROD_ID);
    DBMS_OUTPUT.PUT_LINE('상품명   : ' || REC.PROD_NAME);
    DBMS_OUTPUT.PUT_LINE('매입금액 : ' || TO_CHAR(NVL(L_MSUM,0),'999,999,999'));
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
END LOOP;
END;




(IN-LINE VIEW)

DECLARE 
    L_MSUM NUMBER:=0; -- 매입금액
BEGIN 
FOR REC IN (SELECT PROD_ID,PROD_NAME
              FROM PROD
              WHERE LPROD_GU='P201')

LOOP
SELECT SUM(A.BUY_QTY*B.PROD_COST) INTO L_MSUM
FROM BUYPROD A, PROD B
WHERE EXTRACT(YEAR FROM A.BUY_DATE)=2020
AND A.PROD_ID=REC.PROD_ID
AND A.PROD_ID=B.PROD_ID;
    DBMS_OUTPUT.PUT_LINE('상품코드 : ' || REC.PROD_ID);
    DBMS_OUTPUT.PUT_LINE('상품명   : ' || REC.PROD_NAME);
    DBMS_OUTPUT.PUT_LINE('매입금액 : ' || TO_CHAR(NVL(L_MSUM,0),'999,999,999'));
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
END LOOP;
END;


