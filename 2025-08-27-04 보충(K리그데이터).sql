1. PLAYER ���̺��� '��� HD' �Ҽ� �������� �̸��� �������� ��� ��ȸ�ϼ���.

SELECT PLAYER_NAME AS �̸�,
       POSITION AS ������
FROM PLAYER 
WHERE TEAM_ID=(SELECT TEAM_ID
                 FROM TEAM
                WHERE TEAM_NAME='��� HD');

2. STADIUM ���̺��� '��������Ű����'�� �ּҸ� ��ȸ�Ͻÿ�.

SELECT STADIUM_NAME AS �����,
       ADDRESS AS �ּ�
FROM STADIUM
WHERE ADDRESS LIKE '����%';

3. 2025�� 3�� 15�Ͽ� ���� ��� ����� Ȩ �� ID�� ���� �� ID�� ��ȸ�ϼ���.

SELECT HOMETEAM_ID AS Ȩ��ID,
       AWAYTEAM_ID AS ������ID
FROM SCHEDULE
WHERE SCHE_DATE IN '20250315'

3-1 2025�� 3�� 15�Ͽ� ���� ��� ����� Ȩ �� �̸��� ���� �� �̸�, ����� ���� ��ȸ�ϼ���.

SELECT (SELECT TEAM_NAME
          FROM TEAM
         WHERE A.HOMETEAM_ID=TEAM_ID) AS "Ȩ�� �̸�",
         (SELECT TEAM_NAME
          FROM TEAM
         WHERE A.AWAYTEAM_ID=TEAM_ID) AS "������� �̸�",
         (SELECT STADIUM_NAME
          FROM STADIUM
         WHERE A.STADIUM_ID=STADIUM_ID) AS "����� �̸�"
FROM SCHEDULE A;