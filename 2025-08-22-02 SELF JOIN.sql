2025-08-22-02) SELF JOIN
  - 하나의 테이블에 2개 이상의 별칭을 부여하여 서로 다른 테이블로 가정한 후 JOIN을 수행
  
사용예) 50번 부서의 평균급여보다 더 많은 평균급여를 보유한 부서를 조회하시오.
        AS는 부서번호, 평균급여 
    SELECT 부서번호, 평균급여
    FROM   C##HR.EMPLOYEES A, C##HR.EMPLOYEES B
    WHERE 