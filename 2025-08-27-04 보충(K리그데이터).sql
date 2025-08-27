1. PLAYER 테이블에서 '울산 HD' 소속 선수들의 이름과 포지션을 모두 조회하세요.

SELECT PLAYER_NAME AS 이름,
       POSITION AS 포지션
FROM PLAYER 
WHERE TEAM_ID=(SELECT TEAM_ID
                 FROM TEAM
                WHERE TEAM_NAME='울산 HD');

2. STADIUM 테이블에서 '서울월드컵경기장'의 주소를 조회하시오.

SELECT STADIUM_NAME AS 경기장,
       ADDRESS AS 주소
FROM STADIUM
WHERE ADDRESS LIKE '서울%';

3. 2025년 3월 15일에 열린 모든 경기의 홈 팀 ID와 원정 팀 ID를 조회하세요.

SELECT HOMETEAM_ID AS 홈팀ID,
       AWAYTEAM_ID AS 원정팀ID
FROM SCHEDULE
WHERE SCHE_DATE IN '20250315'

3-1 2025년 3월 15일에 열린 모든 경기의 홈 팀 이름과 원정 팀 이름, 경기장 명을 조회하세요.

SELECT (SELECT TEAM_NAME
          FROM TEAM
         WHERE A.HOMETEAM_ID=TEAM_ID) AS "홈팀 이름",
         (SELECT TEAM_NAME
          FROM TEAM
         WHERE A.AWAYTEAM_ID=TEAM_ID) AS "어웨이팀 이름",
         (SELECT STADIUM_NAME
          FROM STADIUM
         WHERE A.STADIUM_ID=STADIUM_ID) AS "경기장 이름"
FROM SCHEDULE A;