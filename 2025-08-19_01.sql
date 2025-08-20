2025-0819-01) ROLLUP과 CUBE

- GROUP BY 절 안에 사용되어 다양한 집계의 결과를 반환
- GROUP BY 절로는 전체 합계를 구할수 없으나 ROLLUP과 CUBE를 사용하면 전체 합계도 구할 수 있음

1. ROLLUP
사용형식)
    GROUP BY [컬럼명,...,] ROLLUP(컬럼명,...,) [컬럼명,...]
    . 반드시 GROUP BY절 안에서만 사용
    . 레벨별 집계 반환
     - 하위 레벨은 모든 컬럼이 적용된 집게이며 해당 집계가 종료되면 오른쪽 부터 하나씩 컬럼을 제거하며 집계를 반환
        ex)GROUP BY ROLLUP(COL1, COL2, COL3) 인경우
           . 가장 하위레벨 집계 : COL1,COL2,COL3가 모두 적용된 집계(GROUP BY절 집계)
           . 다음 레벨 집계 : COL1,COL2가 적용된 집계
           . 다음 레벨 집계 : COL1만 적용된 집계
           . 마지막 레벨 집계 : 모든 컬럼이 배제된 집계(전체집계)
    . ROLLUP절에 기술된 컬럼이 N개일때 N+1개 종류의 집계 반환
    . ROLLUP절 앞 또는 뒤에 컬럼이 기술되면 부분 ROLLUP 결과 반환(전체집계를 구할 수 없음)

사용예)장바구니 테이블에서 월별, 회원별, 상품별, 구매수량 합계를 조회
    
(GROUP BY 절만)
    SELECT SUBSTR(CART_NO,5,2) AS 월,
           MEM_ID AS 회원번호,
           PROD_ID AS 상품별,
           SUM(CART_QTY) AS "구매수량 합계"
    FROM CART
    GROUP BY SUBSTR(CART_NO,5,2),MEM_ID,PROD_ID
    ORDER BY 1, 2, 3;
    
(ROLLUP) 사용)

    SELECT SUBSTR(CART_NO,5,2) AS 월,
           MEM_ID AS 회원번호,
           PROD_ID AS 상품별,
           SUM(CART_QTY) AS "구매수량 합계"
    FROM CART
    GROUP BY ROLLUP(SUBSTR(CART_NO,5,2),MEM_ID,PROD_ID)
    ORDER BY 1, 2, 3;
    
    부분 ROLLUP도 가능
    
    SELECT SUBSTR(CART_NO,5,2) AS 월,
           MEM_ID AS 회원번호,
           PROD_ID AS 상품별,
           SUM(CART_QTY) AS "구매수량 합계"
    FROM CART
    GROUP BY SUBSTR(CART_NO,5,2), ROLLUP(MEM_ID,PROD_ID)
    ORDER BY 1, 2, 3;
    
    2.CUBE
    사용형식)
        GROUP BY [컬럼명,...,] CUBE(컬럼명,...,) [컬럼명,...,]
        
        .반드시 GROUP BY 절 안에서만 사용
        .조합가능한 모든 종류의 집계를 반환
        .CUBE 절에 기술된 컬럼이 N개일 때 2^n종류의 집계 반환
        .CUBE 절 앞 또는 뒤에 컬럼이 기술되면 부분 CUBE 결과 반환(전체집계를 구할 수 없음)
        
SELECT SUBSTR(CART_NO,5,2) AS 월,
           MEM_ID AS 회원번호,
           PROD_ID AS 상품별,
           SUM(CART_QTY) AS "구매수량 합계"
    FROM CART
    GROUP BY CUBE(SUBSTR(CART_NO,5,2),MEM_ID,PROD_ID)
    ORDER BY 1, 2, 3;