2025-08-28-03) PL/SQL)

 - Procedural Language SQL
 - 서버에서 절차적 처리를 위해 표준 SQL을 확장한 언어
 - 미리 작성된 것을 컴파일하여 실행 가능한 상태로 서버에 보관하고 필요시 실행 명령만 불러 사용
   => 내부 데이터 버스를 이용하는 자료의 양이 작아져서 실행의 효율성을 확보할 수 있음
      (내부 네트워크의 트래픽을 감소 시킴)
 - 기본은 block으로 구성되며 복수개의 SQL문을 일괄 실행 가능
 - 모듈화 캡슐화가 가능
 - Anonymous Block, Stored Procedure, User defined Function, Trigger, Package
 
 
1. PL/SQL의 구조
  DECLARE
    선언영역 : 변수,상수,커서 선언
  
  BEGIN
  실행영역 : 비지니스 로직을 sql문, 반복문, 조건문 등을 이용하여 처리
  
     [EXCEPTION
          예외처리          ]
    
    END;
    

1)변수
  - 자료가 저장되는 기억장소의 이름(기호번지)
  - SCLAR, REFERENCES, COMPOSITE, BIND 변수로 구분됨
  
    (1) SCLAR 변수
      . 일반적인 변수
      . 한 순간 단일 값만을 저장하며 새로운 값이 입력되면 기존의 값은 없어짐
      
    선언형식)
    변수명  [CONSTANT] 데이터타입 [NOT NULL] [:= 초기값];
    