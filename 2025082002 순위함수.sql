2025082002) 순위함수
    - 순위를 반환해주는 함수.
    - RANK() OVER, DENSE_RANK() OVER, ORW_NUMBER() OVER
    - SELECT 절 전용 함수들.
사용형식)
SELECT RANK() |DENSE_RANK()|ROW_NUMBER()| OVER(ORDER BY 컬럼명 [ASC|DESC],...) AS 별칭
    . RANK() : 일반적인 순위 부여(같은 값이면 같은 순위를 부여하고 다음 순위는 "현재순위 + 같은 값의 갯수"로 부여)
    . DENSE_RANK() : 같은 값이면 같은 순위를 부여하고 다음 순위는 "현재순위+1"로 부여
    . ROW_NUMBER() : 순서화된 값이 나열된 순에 따라 차례대로 순서값을 부여
  
    EX)         9, 8, 8, 7, 7, 7, 7, 6, 5, 4
    RANK()      1  2  2  4  4  4  4  8  9  10
  DENSE_RANK()  1  2  2  3  3  3  3  4  5  6
  ROW_NUMBER()  1  2  3  4  5  6  7  8  9  10