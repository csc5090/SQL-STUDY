1. PLAYER 테이블에서 '울산 HD' 소속 선수들의 이름과 포지션을 모두 조회하세요.

SELECT PLAYER_NAME AS 이름,
       POSITION AS 포지션
FROM PLAYER 
WHERE TEAM_ID=(SELECT TEAM_ID
                 FROM TEAM
                WHERE TEAM_NAME='울산 HD');

서브쿼리
(팀명이 울산HD인 팀의 팀 번호 찾기)
