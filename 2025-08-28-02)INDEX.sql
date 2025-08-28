2025-08-28-02)INDEX

사용형식)
  CREATE [OR REPLACE] [BITMAP|UNIQUE] INDEX 인덱스명 
  ON 테이블명(컬럼명,...) [ASC|DESC]
  .ASC|DESC : 오름차순 또는 내림차순 인덱스 생성 기본은 내림차순임
  .BITMAP|UNIQUE : 기본은 NONUNIQUE INDEX 임
  
  
사용예) 사원테이블에서 사원명 'James Landry'의 자료를 조회
 SELECT *
 FROM C##HR.EMPLOYEES
 WHERE EMP_NAME = 'James Landry'

사원명으로 인덱스 생성
CREATE INDEX C##HR.idx_emp_name
  ON C##HR.EMPLOYEES(EMP_NAME);
  
  SELECT *
  FROM C##HR.EMPLOYEES
  WHERE EMP_NAME = 'James Landry';
  
  
  
  ** INDEX의 재구성
  - 자료의 삭제/삽입이 대량 발생한 후.
  - 테이블스페이스가 변경된 후.
  
사용형식)
  ALTER INDEX 인덱스명 REBUILD
  
  ALTER INDEX C##HR.idx_emp_name REBUILD;