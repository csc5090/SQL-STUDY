2025-0801-01)사용자 생성
1. 생성
 - Create User 명령사용
사용형식)
 CREATE USER C##유저명 IDENTIFIED BY 암호;
사용예)
 CREATE USER C##CSC IDENTIFIED BY java;

2. 권한부여
 - DEFAULT ROLL(CONNECT, RESOURCE, DBA)을 부여
 - GRANT 명령으로 권한(룰)을 부여하고, REVOKE 명령으로 회수
사용형식
 GRANT (권한명|롤명,...) TO 계정명;
 REVOKE ON (권한명|롤명,...  FROM 계정명
 
사용예)
 GRANT CONNECT, RESOURCE, DBA TO C##CSC;
 
 사용예) HR계정을 생성
 CREATE USER C##HR IDENTIFIED BY java;
 GRANT CONNECT, RESOURCE, DBA TO C##HR
 
 
 
 
 
 
 
 
 
 
 
 
 