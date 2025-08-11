2025-0811-01)
4. ANY(SOME)
(사용형식)
    expr    관계연산자 ANY|SOME(값1, 값2, ..., 값N)
    . expr의 값이 '값1, 값2,,,값n' 중 하나와 사용된 관계연산자를 만족하면 참(true)을 반환함.
    . '='연산자를 사용하면 IN연산자와 같은 기능을 수행함.
    
    
사용예) 
      1) 상품테이블에서 'P102' 분류에 속한 어느 상품의 가장 저렴한 판매가 보다 더 큰 판매가를
         가진 상품의 상품번호, 상품명, 분류코드, 판매가를 조회하여 판매가 순으로 조회하시오.
    
    ('P101' 분류에 속한 상품의 판매가)
        SELECT PROD_PRICE
        FROM   PROD
        WHERE  LPROD_GU='P102'
        
      SELECT PROD_ID AS 상품번호,
             PROD_NAME AS 상품명,
             LPROD_GU AS 분류코드,
             PROD_PRICE AS 판매가
        FROM PROD
       WHERE PROD_PRICE >ANY(SELECT PROD_PRICE
                             FROM   PROD
                             WHERE  LPROD_GU='P102')
         AND LPROD_GU !='P102'
       ORDER BY 4;
       
       
      2) 회원테이블에서 어떤 30대 회원들의 마일리지 보다 많은 마일리지를 보유한 회원정보를 조회하시오.
      alias는 회원번호, 회원명, 나이, 마일리지.
      
       SELECT MEM_MILEAGE
         FROM MEMBER
        WHERE TRUNC((EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BTR))/10)=3
        
      (30대 회원들의 마일리지)
      
      SELECT MEM_ID AS 회원번호,
             MEM_NAME AS 회원명,
             EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) AS 나이,
             MEM_MILEAGE AS 마일리지
        FROM MEMBER
        WHERE NOT MEM_MILEAGE <SOME(SELECT MEM_MILEAGE) AND
        TRUNC((EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR))/10)!=3
        ORDER BY 4 DESC;
        
5. ALL
    expr    관계연산자ALL(값1, 값2, ... 값n)
      . expr의 값이 '값1, 값2,..., 값n' 모두와 사용된 관계연산자를 만족하면 참(true)을 반환함.
      . '='연산자는 절대로 사용될 수 없음.
      
      
      사용예) 
      1) 상품테이블에서 'P201' 분류에 속한 어느 상품의 가장 저렴한 판매가 보다 더 큰 판매가를
         가진 상품의 상품번호, 상품명, 분류코드, 판매가를 조회하여 판매가 순으로 조회하시오.
('P201'분류에 속한 상품의 판매가)
    SELECT PROD_PRICE
      FROM PROD
     WHERE LPROD_GU='P201'
     
    SELECT PROD_ID AS 상품번호,
           PROD_NAME AS 상품명,
           LPROD_GU AS 분류코드,
           PROD_PRICE AS 판매가
      FROM PROD
     WHERE PROD_PRICE > ALL(SELECT PROD_PRICE
                            FROM PROD
                            WHERE LPROD_GU='P201')
    ORDER BY 4;
