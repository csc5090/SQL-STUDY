2025-08-28-01) 시퀀스(sequence)
  - 자동으로 번호를 생성하기 위한 객체.
  - Sequence 객체는 테이블과 독립적이므로 여러곳에서 사용 가능.
  - Sequence를 이용하는 경우
  1.Primary Key를 설정할 후보키가 없거나 PK를 특별히 의미있게 만들지 않아도 되는 경우.
  2.자동으로 순서적인 번호가 필요한 경우
  
사용형식(문법)
  CREATE SEQUENCE 시퀀스명
    START WITH n    -- 시작 값 설정 생략하면 MINVALUE가 설정됨.
    INCREMENT BY n   -- 증감값
    MAXVALUE n | NOMAXVALUE  -- 최대값 default는 NOMAXVALUE로 10^27
    MINVALUE n | NOMINVALUE  -- 최소값 default는 NOMINVALUE로 1
    CYCLE  |  NOCYCLE  -- 최대 또는 최소 값까지 도달한 후 다시 시퀀스를 생성하는 경우는 CYCLE임. default NOCYCLE
    CACHE n  |  NOCACHE  -- 시퀀스 값을 캐쉬 메모리에 생성할지 여부 default는 CACHE
    ORDER | NOORDER  -- 정의한대로 시퀀스 생성을 담보하면 ORDER, default는 NOORDER
    
    
** 시퀀스 값 참조용 의사컬럼(Pseudo Column)
   시퀀스명.NEXTVAL : 시퀀스 객체의 다음 값 참조하여 반환
   시퀀스명.CURRVAL : 시퀀스 객체의 현재 값 참조하여 반환

*** 시퀀스가 생성된 후 가장 먼저 사용하는 명령은 시퀀스명.NEXTVAL 이어야 함
   
    
    
사용예) 다음자료를 LPROD 테이블에 저장하시오.

--------------------------------------------------------
  LPROD_ID            LPROD_GU             LPROD_NAME
-------------------------------------------------------- 
     10                 P501                 농산물
     INSERT INTO LPROD(LPROD_ID,LPROD_GU,LPROD_NAME) VALUES(seq_lprod_id.NEXTVAL, 'P501', '농산물');
     SELECT * FROM LPROD;
     11                 P502                 임산물
     SELECT seq_lprod_id.CURRVAL FROM DUAL;
     INSERT INTO LPROD(LPROD_ID,LPROD_GU,LPROD_NAME) VALUES(seq_lprod_id.NEXTVAL, 'P502', '임산물');
     SELECT * FROM LPROD;
     12                 P503                 수산물
     INSERT INTO LPROD(LPROD_ID,LPROD_GU,LPROD_NAME) VALUES(seq_lprod_id.NEXTVAL, 'P503', '수산물');
     SELECT * FROM LPROD;

 CREATE SEQUENCE seq_lprod_id 
 START WITH 10;
 
 SELECT seq_lprod_id.NEXTVAL FROM DUAL;
 
 INCREMENT BY