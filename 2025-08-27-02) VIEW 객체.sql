2025-08-27-02) VIEW 객체
  - 뷰는 가사의 테이블
  - SELECT 문의 결과집합(PL/SQL에서는 CURSOR라고 함)
  - VIEW를 사용하는 이유 
    .필요한 정보가 한 개의 테이블에 있지 않고, 여러개의 테이블에 분산되어 있는 경우
    .테이블에 들어 있는 자료의 일부분만 필요하고 자료의 전체 ROW나 COLUMN이 필요하지 않은 경우.
    .특정자료에 대한 접근을 제한하고자 할 경우(보안)
    
(뷰의 생성)
 CREATE [OR REPLACE] [FORCE|NOFORCE] VIEW 뷰이름[(컬럼명,...)]
 AS
    SELECT 문
        [WITH CHECK OPTION]
        [WITH READ ONLY]
    .'OR REPLACE' : 이미 동일한 이름의 뷰가 존재한다면 덮어씌우고, 없다면 새롭게 생성함.
    .FORCE : 쿼리의 테이블, 컬럼, 함수 등이 일부 존재하지 않아도 뷰는 생성됨(INVALID 상태).(SELECT문에 오류가 있어도 뷰 자체는 만들어짐)
    .NOFORCE : 쿼리의 테이블, 컬럼, 함수 등이 정상적으로 동작해야만 뷰를 생성(default).(SELECT문에 오류가 없어야 뷰가 만들어짐)
    .'뷰이름[(컬럼명,...)]' : 뷰에서 사용할 컬럼명 기술. 생략하면 SELECT문의 별칭이 뷰의 컬럼명이 되고,
     별칭도 생략되면 SELECT 문의 컬럼명이 뷰의 컬럼명이 됨.
    .'WITH CHECK OPTION' : 뷰생성에 사용된 SELECT 문의 WHERE 조건을 위배하는 DML명령을
      뷰를 대상으로 실행할 수 없음(원본 테이블은 제한없이 DML명령 사용 가능)
    .'WITH READ ONLY' : 읽기 전용 뷰를 생성
    .WITH READ ONLY 와 WITH CHECK OPTION은 동시 사용할 수 없다.
    
    -뷰 사용시 주의사항
      .뷰를 생성할 때 제약조건(WITH)이 있는 경우, ORDER BY 절 사용이 불가능함.
      .뷰가 집계함수, GROUP BY 절, DISTINCT를 사용하여 만들어진 경우 INSERT, UPDATE, DELETE 구문을 사용할 수 없다.
      .어느 컬럼이 표현식, 일반함수를 통하여 만들어진 경우 해당 컬럼의 추가 및 수정불가능
      .CURRVAL, NEXTVAL 의사컬럼(pseudo column) 사용 불가
      .ROWID, ROWNUM, LEVEL 의사컬럼을 사용 할 경우 AS를 사용해야 함.
      

        
사용예) 회원테이블에서 마일리지가 10000포인트 이상인 회원의 회원번호, 회원명, 마일리지를
       조회하여 뷰를 생성하시오.
      
CREATE OR REPLACE VIEW view_mileage(MID,NAME,MILEAGE)
AS 
  SELECT MEM_ID AS 회원번호,
         MEM_NAME AS 회원명,
         MEM_MILEAGE AS 마일리지
  FROM MEMBER
  WHERE MEM_MILEAGE >= 10000;

SELECT * FROM VIEW_MILEAGE;

1) 회원테이블의 자료 중 'u001'회원의 마일리지(6564)를 10500으로 변경하시오

  UPDATE MEMBER
  SET MEM_MILEAGE=10500
  WHERE MEM_ID='u001';
  
  
2) VIEW_MILEAGE테이블에서 'u001'회원 정보를 삭제하시오.

SELECT * FROM VIEW_MILEAGE;

DELETE FROM VIEW_MILEAGE 
WHERE MEM_ID='u001';

3) VIEW_MILEAGE 에서 'u001'마일리지를 1000으로 변경하기

CREATE OR REPLACE VIEW view_mileage
AS
SELECT MEM_ID AS 회원번호,MEM_NAME AS 회원명, MEM_MILEAGE AS 마일리지
FROM MEMBER
WHERE MEM_MILEAGE>=10000
WITH CHECK OPTION;

UPDATE VIEW_MILEAGE
SET 마일리지=1000
WHERE 회원번호='u001';


-- f001 신영남 16506
4) 뷰 VIEW_MILEAGE에서 'f001' 회원의 마일리지(16506)를 9000포인트로 변경하시오.

SELECT * FROM VIEW_MILEAGE;

UPDATE VIEW_MILEAGE
SET 마일리지=9000
WHERE 회원번호='f001';

INSERT INTO VIEW_MILEAGE VALUES('a002','거지최원효',12000);

5) MEMBER 테이블에서 'a002' 회원의 마일리지를 1200으로 변경하시오.

UPDATE MEMBER 
SET MEM_MILEAGE=1200
WHERE MEM_ID='a002';


**컬럼명을 생략하고 WITH READ ONLY를 사용한 뷰를 생성하기.

CREATE OR REPLACE VIEW VIEW_MILEAGE
AS
SELECT MEM_ID AS 회원번호,MEM_NAME AS 회원명,MEM_MILEAGE AS 마일리지
FROM MEMBER
WHERE MEM_MILEAGE>=10000
WITH READ ONLY;

SELECT * FROM VIEW_MILEAGE;

6) 뷰 VIEW_MILEAGE에서 'f001' 회원의 마일리지(16506)를 9000포인트로 변경하시오.

UPDATE VIEW_MILEAGE
SET MEM_MILEAGE=9000
WHERE MEM_ID='f001';

4-1) 뷰 마이리지에서 f001 회원의 마일리지를 19000포인트로 변경하시오.

UPDATE VIEW_MILEAGE
SET 마일리지=16506
WHERE 회원번호='f001';

UPDATE MEMBER
SET MEM_MILEAGE=16506
WHERE MEM_ID='f001';