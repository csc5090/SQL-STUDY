2025-0801-01)����� ����
1. ����
 - Create User ��ɻ��
�������)
 CREATE USER C##������ IDENTIFIED BY ��ȣ;
��뿹)
 CREATE USER C##CSC IDENTIFIED BY java;

2. ���Ѻο�
 - DEFAULT ROLL(CONNECT, RESOURCE, DBA)�� �ο�
 - GRANT ������� ����(��)�� �ο��ϰ�, REVOKE ������� ȸ��
�������
 GRANT (���Ѹ�|�Ѹ�,...) TO ������;
 REVOKE ON (���Ѹ�|�Ѹ�,...  FROM ������
 
��뿹)
 GRANT CONNECT, RESOURCE, DBA TO C##CSC;
 
 ��뿹) HR������ ����
 CREATE USER C##HR IDENTIFIED BY java;
 GRANT CONNECT, RESOURCE, DBA TO C##HR
 
 
 
 
 
 
 
 
 
 
 
 
 