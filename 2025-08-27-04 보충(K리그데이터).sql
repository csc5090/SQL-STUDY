1. PLAYER ���̺��� '��� HD' �Ҽ� �������� �̸��� �������� ��� ��ȸ�ϼ���.

SELECT PLAYER_NAME AS �̸�,
       POSITION AS ������
FROM PLAYER 
WHERE TEAM_ID=(SELECT TEAM_ID
                 FROM TEAM
                WHERE TEAM_NAME='��� HD');

��������
(������ ���HD�� ���� �� ��ȣ ã��)
