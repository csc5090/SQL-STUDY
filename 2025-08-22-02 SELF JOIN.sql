2025-08-22-02) SELF JOIN
  - 하나의 테이블에 2개 이상의 별칭을 부여하여 서로 다른 테이블로 가정한 후 JOIN을 수행
  
사용예) 회원테이블에서 'q001'회원의 마일리지보다 많은 마일리지를 보유한 회원의 회원번호,이름,마일리지를 조회하기

SELECT B.MEM_ID AS 회원번호,
       B.MEM_NAME AS 이름,
       B.MEM_MILEAGE AS 마일리지
FROM MEMBER A --q001 회원의 정보
INNER JOIN MEMBER B ON (A.MEM_MILEAGE < B.MEM_MILEAGE) --B: 모든 회원의 정보 
WHERE A.MEM_ID='q001'
ORDER BY 3;