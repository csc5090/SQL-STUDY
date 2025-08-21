2025-0821-01)JOIN
- 두 개 이상의 테이블들을 연결 또는 결합하여 데이터를 출력하는 것
- 일반적인 경우 행들은 Primary Key(PK)나 Foreign Key(FK)값의 연관에 의해 조인이 성립.
- 어떤 경우에는 이러한 PK,FK의 관계가 없어도 논리적인 값들의 연관만으로 조인 성립이 가능함.
- JOIN의 조건은 WHERE 절에 기술하며 참여하는 테이블의 수가 N개 일 때 JOIN 조건은 반드시 N-1개 이상이어야 한다.
- JOIN은 내부/외부, 일반/ANSI, 동등/비동등, 셀프, CARTESIAN PRODUCT 등으로 구분함.

1. CARTESIAN PRODUCT
 - 조인 조건이 없거나 잘못 기술된 경우
 - ANSI에서는 CROSS JOIN이라고 함.
 
사용 형식 - 일반 조신)
SELECT 컬럼명
FROM 테이블1 [별칭1], 테이블2 [별칭2]...

별칭1은 해당 쿼리 안에서 테이블을 지칭하는 또 다른 이름으로 보통 부르기 쉽고 기억하기 쉬운 단어로

사용형식-ANSI조인)
SELECT 컬럼명
FROM 테이블1 [별칭1]
CROSS JOIN   테이블2 [별칭2]
CROSS JOIN 테이블명3 [별칭3]...


*** 모든 ANSI JOIN의 FROM절에는 하나의 테이블이 존재한다.
 - CARTESIAN PRODUCT나 CROSS JOIN의 결과는 조인에 참여하는 모든 테이블들의 행은 곱한 값 만큼,
   열은 더한 값 만큼 생성된다.
 - 문제 해결을 위하여 반드시 필요한 경우가 아니면 사용을 제자 해야함.

사용형식)
SELECT 'CART' AS 테이블명, COUNT(*) AS 행의수
FROM CART
UNION ALL
SELECT 'BUYPROD', COUNT(*)
FROM PROD; 

SELECT * 
FROM CART,BUYPROD,PROD;

ANSI : CROSS JOIN

SELECT COUNT(*)
FROM BUYPROD
CROSS JOIN CART
CROSS JOIN PROD;


2. 내부조인( INNER JOIN ) 
 - 조인 조건을 만족하는 자료만 반환하고, 조인 조건을 만족하지 않는 자료는 무시함.

사용형식)




