2025-08-22-01) 외부 JOIN(OUTER JOIN)

  - 내부조인 조인조건을 만족하는 자료만 반환하고, 그렇지 않은 자료는 무시함.
  - 외부조인은 자료의 종류가 부족한 테이블에 많은 쪽의 행의 수 만큼 빈 행(NULL) 삽입한 후 조인 수행.
  - COUNT 함수는 COUNT(컬럼명) 형태를 사용해야 한다.
  - SELECT 절에서 어느 2개 이상의 테이블에 공통으로 존재하는 컬럼을 조회할 때 
    --반 드 시 많은 쪽의 컬럼명을 기술해야 한다.
  
사용 형식)
    SELECT 컬럼명
    FROM   테이블명[별칭1],...   
    WHERE  별칭1.컬럼명1=별칭2.컬럼명2(+)     --- 테이블명2가 부족한 경우임.
                    :  
                    :
                    :
   . 조인 조건 중 외부조인이 필요한 모든 조건에 외부조인 연산자 '(+)'를 삽입한다.
   . 3개 이상의 테이블이 외부조인 되는 경우 한 테이블이 동시에 다른 두 테이블에 외부조인 될 수 없다.
     즉, A,B,C 테이블이 외부조인 되는 경우 A(+)=B AND A(+) = C는 허용되지 않음.
   . 양쪽 모두에 외부조인 연산자를 사용할 수 없음(ANSI는 허용됨)
     즉 A(+)=B(+)는 허용 안 됨.
   . 일반 조건이 외부조인 연산자 없이 기술되면 결과는 내부조인 결과로 변환됨.
   -> 해결 방법으로 ANSI조인 사용 또는 서브쿼리 사용 (서브쿼리 사용 권장. ANSI로 한다해도 조건이 달라서 정확한 계산이 안 됨.)
   
ANSI 외부조인)
SELECT 컬럼명
FROM 테이블명1 [별칭1]
FULL|LEFT|RIGHT OUTER JOIN 테이블명2 [별칭2] ON (조인조건 [AND 일반조건])
FULL|LEFT|RIGHT OUTER JOIN 테이블명3 [별칭3] ON (조인조건 [AND 일반조건])
                            :
                            :
                            :
[WHERE 일반조건]
                            :
                            :
                            :

  . 수행은 테이블명1과 테이블명2가 외부조인되고 이후 이 조인 결과와 테이블명3이 외부 조인 됨.
  . FULL : FROM 절 쪽 테이블과 JOIN절 쪽 테이블의 자료가 모두 부족한 경우 사용
  . LEFT : FROM 절 쪽의 결과가 JOIN절 쪽 테이블의 자료보다 더 많은 경우 사용.
  . RIGHT : JOIN절 쪽 테이블의 자료가 FROM 절쪽의 결과보다 더 많은 경우 사용
  ** 이 때 자료가 많고 적음은 비교하는 컬럼을 고려하여 결정.
  . 조인 조건과 일반조건을 ON 절에 기술할 수 있음.
  . WHERE 절이 사용되면 내부조인 결과로 변환 됨.
  
  
사용예) 

1) 모든 분류별 분류명과 상품의 수와 평균 판매가를 조회하시오.

SELECT COUNT(*) FROM LPROD; -- 9
SELECT COUNT(DISTINCT LPROD_GU) FROM PROD; --6


SELECT A.LPROD_GU AS 분류코드,
       A.LPROD_NAME AS 분류명,
       COUNT(PROD_ID) AS "상품의 수",
       NVL(TRUNC(AVG(B.PROD_PRICE)),0) AS "평균 판매가"
FROM LPROD A, PROD B
WHERE A.LPROD_GU=B.LPROD_GU(+)
GROUP BY A.LPROD_GU, A.LPROD_NAME
ORDER BY 1;


ANSI

SELECT A.LPROD_GU AS 분류코드,
       A.LPROD_NAME AS 분류명,
       COUNT(PROD_ID) AS "상품의 수",
       NVL(TRUNC(AVG(B.PROD_PRICE)),0) AS "평균 판매가"
FROM LPROD A
LEFT OUTER JOIN PROD B ON(A.LPROD_GU=B.LPROD_GU)
GROUP BY A.LPROD_GU,A.LPROD_NAME
ORDER BY 1;

2) 2020년 모든 상품별 매입 수량과 매입 금액을 조회하시오.

SELECT P.PROD_ID AS 상품코드,
       P.PROD_NAME AS 상품명,
       NVL(SUM(B.BUY_QTY),0) AS "매입 수량 합계", 
       NVL(SUM(B.BUY_QTY*P.PROD_COST),0) AS "매입 금액 합계"
FROM PROD P, BUYPROD B
WHERE B.PROD_ID(+)=P.PROD_ID     --조인조건(상품명, 매입단가 추출)
AND   B.BUY_DATE(+) BETWEEN TO_DATE('20200101') AND ('20200131')
GROUP BY P.PROD_ID, P.PROD_NAME
ORDER BY 1; 


ANSI

SELECT P.PROD_ID AS 상품코드,
       P.PROD_NAME AS 상품명,
       NVL(SUM(B.BUY_QTY),0) AS "매입 수량 합계", 
       NVL(SUM(B.BUY_QTY*P.PROD_COST),0) AS "매입 금액 합계"
FROM PROD P
            LEFT OUTER JOIN BUYPROD B ON(P.PROD_ID=B.PROD_ID) AND B.BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200131')
GROUP BY P.PROD_ID,P.PROD_NAME
ORDER BY 1;

SUBQUERY)
(서브쿼리 : 2020년 1월 상품별매입금액,매입수량합계)


SELECT B.PROD_ID AS BPID,
       SUM(B.BUY_QTY) AS BQTY,
       SUM(B.BUY_QTY*A.PROD_COST) AS BSUM
FROM BUYPROD B
INNER JOIN PROD A ON(B.PROD_ID=A.PROD_ID)
WHERE B.BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200131')
GROUP BY B.PROD_ID;



SELECT P.PROD_ID AS 상품코드,
       P.PROD_NAME AS 상품명,
       NVL(M.BQTY,0) AS 매입수량합계,
       NVL(M.BSUM,0) AS 매입금액합계
FROM PROD P, (SELECT B.PROD_ID AS BPID,
              SUM(B.BUY_QTY) AS BQTY,
              SUM(B.BUY_QTY*A.PROD_COST) AS BSUM
              FROM BUYPROD B
              INNER JOIN PROD A ON(B.PROD_ID=A.PROD_ID)
              WHERE B.BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200131')
              GROUP BY B.PROD_ID)M
WHERE P.PROD_ID=M.BPID(+)
ORDER BY 1;

3) 2020년 상반기 모든 회원별 구매현황을 조회하시오.

SELECT B.MEM_ID AS 회원번호,
       B.MEM_NAME AS 회원명,
       NVL(SUM(A.CART_QTY*C.PROD_PRICE),0) AS 구매금액합계
FROM CART A, MEMBER B, PROD C
WHERE SUBSTR(A.CART_NO(+),1,6) BETWEEN '202001' AND '202006' 
AND A.MEM_ID(+)=B.MEM_ID
AND A.PROD_ID(+)=C.PROD_ID
GROUP BY B.MEM_ID, B.MEM_NAME
ORDER BY 1;


SELECT B.MEM_ID AS 회원번호,
       B.MEM_NAME AS 회원명,
       NVL(SUM(A.CART_QTY*C.PROD_PRICE),0) AS 구매금액합계
FROM CART A
RIGHT OUTER JOIN MEMBER B ON(A.MEM_ID=B.MEM_ID)
LEFT  OUTER JOIN PROD C ON(A.PROD_ID=C.PROD_ID AND
                           SUBSTR(A.CART_NO,1,6) BETWEEN '202001' AND '202006')
GROUP BY B.MEM_ID,B.MEM_NAME
ORDER BY 1;

사용예) 2020년 모든 상품의 매입/매출액을 조회하시오.

(집한연산자 + 서브쿼리)
SELECT APID AS 상품코드,
       NVL(SUM(MAEIB),0) AS 매입액,
       NVL(SUM(MAECHUL),0) AS 매출액
FROM( SELECT A.PROD_ID AS APID,
      SUM(A.PROD_COST*BUY_QTY) AS MAEIB,
      0 AS MAECHUL
      FROM PROD A
      INNER JOIN BUYPROD B ON (A.PROD_ID=B.PROD_ID AND EXTRACT(YEAR FROM B.BUY_DATE)=2020)
      GROUP BY A.PROD_ID
      UNION ALL
      SELECT A.PROD_ID, 0, SUM(A.PROD_PRICE*B.CART_QTY)
      FROM PROD A
      INNER JOIN CART B ON (A.PROD_ID=B.PROD_ID AND SUBSTR(B.CART_NO,1,4)='2020')
      GROUP BY A.PROD_ID)
      GROUP BY APID
      ORDER BY 1;
      

(일반 외부 조인)
SELECT C.PROD_ID AS 상품번호,
       C.PROD_NAME AS 상품명,
       NVL(SUM(B.BUY_QTY*C.PROD_COST),0) AS 매입액,
       NVL(SUM(A.CART_QTY*C.PROD_PRICE),0) AS 매출액
FROM CART A, BUYPROD B, PROD C
WHERE A.PROD_ID(+)=C.PROD_ID
AND A.CART_NO(+) LIKE '2020%'
AND B.PROD_ID(+)=C.PROD_ID
AND EXTRACT(YEAR FROM B.BUY_DATE(+)) = 2020
GROUP BY C.PROD_ID,C.PROD_NAME
ORDER BY 1;

(서브쿼리 이용)
  SELECT A.PROD_ID AS 상품코드,
         A.PROD_NAME AS 상품명,
         A.MAEIB AS 매입액,
         B.MAECHUL AS 매출액
  FROM   PROD A,
                (SELECT A.PROD_ID AS APID,
                 SUM(A.BUY_QTY*B.PROD_COST) AS MAEIB
                 FROM BUYPROD A
                 INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
                 WHERE EXTRACT(YEAR FROM A.BUY_DATE)=2020
                 GROUP BY A.PROD_ID; ) B,
 
                 (SELECT A.PROD_ID AS CPID,
                  SUM(A.CART_QTY*B.PROD_PRICE)AS MAECHUL
                  FROM CART A
                  INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
                  WHERE SUBSTR(A.CART_NO,1,4)='2020'
                  GROUP BY A.PROD_ID) C

 WHERE   A.PROD_ID=B.APID(+)
 AND     A.PROD_ID=C.CPID(+)
 ORDER BY 1;
 
 
 
 (2020년 상품별 매입액 : 내부조인)
 
 (SELECT A.PROD_ID AS APID,
        SUM(A.BUY_QTY*B.PROD_COST) AS MAEIB
 FROM BUYPROD A
 INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
 WHERE EXTRACT(YEAR FROM A.BUY_DATE)=2020
 GROUP BY A.PROD_ID; ) B,
 
 (2020년 상품별 매출액 : 내부조인)
 
 (SELECT A.PROD_ID AS CPID,
        SUM(A.CART_QTY*B.PROD_PRICE)AS MAECHUL
        FROM CART A
        INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
WHERE SUBSTR(A.CART_NO,1,4)='2020'
GROUP BY A.PROD_ID) C



(ANSI OUTER JOIN)


SELECT A.PROD_ID AS 상품코드,
       A.PROD_NAME AS 상품명,
       NVL(SUM(A.PROD_COST*B.BUY_QTY),0) AS 매입액,
       NVL(SUM(A.PROD_PRICE*C.CART_QTY),0) AS 매출액
FROM   PROD A
LEFT OUTER JOIN BUYPROD B ON(A.PROD_ID=B.PROD_ID AND EXTRACT(YEAR FROM B.BUY_DATE)=2020)
LEFT OUTER JOIN CART C ON(A.PROD_ID=C.PROD_ID AND C.CART_NO LIKE '2020%')
GROUP BY A.PROD_ID, A.PROD_NAME
ORDER BY 1;

