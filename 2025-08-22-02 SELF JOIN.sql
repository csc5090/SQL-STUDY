2025-08-22-02) SELF JOIN
  - �ϳ��� ���̺� 2�� �̻��� ��Ī�� �ο��Ͽ� ���� �ٸ� ���̺�� ������ �� JOIN�� ����
  
��뿹) ȸ�����̺��� 'q001'ȸ���� ���ϸ������� ���� ���ϸ����� ������ ȸ���� ȸ����ȣ,�̸�,���ϸ����� ��ȸ�ϱ�

SELECT B.MEM_ID AS ȸ����ȣ,
       B.MEM_NAME AS �̸�,
       B.MEM_MILEAGE AS ���ϸ���
FROM MEMBER A --q001 ȸ���� ����
INNER JOIN MEMBER B ON (A.MEM_MILEAGE < B.MEM_MILEAGE) --B: ��� ȸ���� ���� 
WHERE A.MEM_ID='q001'
ORDER BY 3;