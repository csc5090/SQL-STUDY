2025_0805_
문자열, 숫자, 날짜, 기타 (2진 자료)
1. 문자 자료
  - ' ' 안에 기술된 자료
  - 고정 길이 : char, nchar
  - 가변 길이 : varchar2, varchar, long, clob, , nvarchar, nvarchar2, nclob
  
  사용예)
   CREATE TABLE TBL_CHAR(
     COL1 CHAR(20),
     COL2 CHAR(20 BYTE),
     COL3 CHAR(20 CHAR)
);

 INSERT INTO TBL_CHAR(COL1, COL2, COL3) VALUES ('대전시 중구', '대전시 중구 ','대전시 중구 계룡로 846')

 SELECT * FROM TBL_CHAR;

 SELECT LENGTHB (COL1),
        LENGTHB (COL2),
        LENGTHB (COL3)
    FROM TBL_CHAR;

사용예)
 CREATE TABLE TBL_VARCHAR2(
    COL1 VARCHAR2(50),
    COL2 VARCHAR2(50),
    COL3 VARCHAR2(4000 CHAR)
  );
  
  INSERT INTO TBL_VARCHAR2  VALUES('대전시 중구 계룡로 846','대전시 중구 계룡로 846',
                                   '대전시 중구 계룡로 846');
                                   
  SELECT * FROM TBL_VARCHAR2;
--*는 모든 것(ALL)을 의미.


 SELECT LENGTHB (COL1),
        LENGTHB (COL2),
        LENGTHB (COL3)
    FROM TBL_CHAR;
    
    
    
    
    
사용예)
  CREATE TABLE TBL_LOB(
    COLI LONG,
   -- COL2 LONG,
    COL3 CLOB,
    COL4 CLOB,
    COL5 CLOB
 );
 
  SELECT  --LENGTHB (COL1),
        LENGTH (COL3),
        DBMS_LOB.GETLENGTH (COL4)
    FROM TBL_LOB;
 
  INSERT INTO TBL_LOB(COLI, COL3, COL4) VALUES('대전시 중구 계룡로 846','대전시 중구 계룡로 846',
                                               'IL POSTINO BOYHOOD');
                                               
                                
                        
2. 숫자 자료형

  - NUMBER[(*|P [,S])]
  - INTEGER, BINARY_FLOAT, BINARY_DOUBLE, 등이 제공됨.
  
1) NUMBER [(*|P [,S])]
  . 기본 숫자자료형
  . P(PRECISION) : 전체 자리수를 뜻하는 말. 1~38 사이의 숫자 사용
  . S(SCALE) : 양수 소숫점 이하의 자리수로 S+1번째 자리에서 반올림하여 저장
               음수 : 해당 정수 자리에서 반올림되어 저장
  . P 대신 *을 사용하면 전체 자리수 시스템에게 의뢰 
  . '(*|F[,S])' 생략되면 사용자가 입력한 데이터를 변형 없이 저장함

사용예)
           CREATE TABLE TBL_NUMBER(
        COL1 NUMBER,
        COL2 NUMBER(3),
        COL3 NUMBER(3,2),
        COL4 NUMBER(5,2),
        COL5 NUMBER(7,1),
        COL6 NUMBER(7,-1),
        COL7 NUMBER(7,-2),
        COL8 NUMBER(*,2),
        COL9 NUMBER(4,5),
        COL10 NUMBER(4,7),
        COL11 NUMBER(3,4),
        COL12 NUMBER(4,6)
    );
    
    INSERT INTO TBL_NUMBER
        VALUES(
            456.73, --COL1
            456.73, --COL2
            6.73, --COL3 NUMBER (3,2)
            456.73, --COL4
            456.77, --COL5
            50456.73, --COL6
            12456.73, --COL7
            12456.7393, --COL8
            0.01234,--COL9
            0.0001234, --COL10
            0.0012, --COL11
            0.00123789 --COL12
            );
           

3. 날짜 타입
  - DATE, TIMESTAMP, TIMESTAMP WITH TIME ZONE, TIMESTAMP WITH LOCAL TIME ZONE
  - 데이터 타입으로 설정된 컬럼은 '+', '-'의 대상이 됨.
  
  
  
  
  사용예)
   CREATE TABLE TBL_DATE(
     COL1 DATE,
     COL2 DATE,
     COL3 DATE
);

  INSERT INTO TBL_DATE VALUES(SYSDATE, SYSDATE-5, SYSDATE+26);
  
  SELECT * FROM TBL_DATE;
  
  (시간표시 방법 : 세션 속성 변경)
   ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
   
   SELECT * FROM TBL_DATE;
   
   
   
   (시간표시 방법 : 변환함수 사용)
   
   SELECT TO_CHAR(COL1, 'YYYY/MM/DD HH24:MI:SS'),
          TO_CHAR(COL2, 'YYYY/MM/DD HH24:MI:SS'),
          TO_CHAR(COL3, 'YYYY/MM/DD HH24:MI:SS')
     FROM TBL_DATE;
     
    SELECT '1992년 2월 17일은' ||
        CASE MOD((TO_DATE('1992-02-17') - TO_DATE('00010101')-1),7) 
           WHEN 0 THEN '일요일'
           WHEN 1 THEN '월요일'
           WHEN 2 THEN '화요일'
           WHEN 3 THEN '수요일'
           WHEN 4 THEN '목요일'
           WHEN 5 THEN '금요일'
           ELSE '토요일'
        END AS 요일
    FROM TBL_DATE;
      
    
    
    
사용예 )
   CREATE TABLE TBL_TIMESTAMP (
     COL1 TIMESTAMP,
     COL2 TIMESTAMP WITH TIME ZONE,
     COL3 TIMESTAMP WITH LOCAL TIME ZONE
  );
  
  
    INSERT INTO TBL_TIMESTAMP VALUES(SYSDATE, SYSDATE, SYSDATE);
    INSERT INTO TBL_TIMESTAMP VALUES(SYSTIMESTAMP, SYSTIMESTAMP, SYSTIMESTAMP);
    
    SELECT * FROM TBL_TIMESTAMP;
    
    