2025-0821-01)JOIN
- �� �� �̻��� ���̺���� ���� �Ǵ� �����Ͽ� �����͸� ����ϴ� ��
- �Ϲ����� ��� ����� Primary Key(PK)�� Foreign Key(FK)���� ������ ���� ������ ����.
- � ��쿡�� �̷��� PK,FK�� ���谡 ��� ������ ������ ���������� ���� ������ ������.
- JOIN�� ������ WHERE ���� ����ϸ� �����ϴ� ���̺��� ���� N�� �� �� JOIN ������ �ݵ�� N-1�� �̻��̾�� �Ѵ�.
- JOIN�� ����/�ܺ�, �Ϲ�/ANSI, ����/�񵿵�, ����, CARTESIAN PRODUCT ������ ������.

1. CARTESIAN PRODUCT
 - ���� ������ ���ų� �߸� ����� ���
 - ANSI������ CROSS JOIN�̶�� ��.
 
��� ���� - �Ϲ� ����)
SELECT �÷���
FROM ���̺�1 [��Ī1], ���̺�2 [��Ī2]...

��Ī1�� �ش� ���� �ȿ��� ���̺��� ��Ī�ϴ� �� �ٸ� �̸����� ���� �θ��� ���� ����ϱ� ���� �ܾ��

�������-ANSI����)
SELECT �÷���
FROM ���̺�1 [��Ī1]
CROSS JOIN   ���̺�2 [��Ī2]
CROSS JOIN ���̺��3 [��Ī3]...


*** ��� ANSI JOIN�� FROM������ �ϳ��� ���̺��� �����Ѵ�.
 - CARTESIAN PRODUCT�� CROSS JOIN�� ����� ���ο� �����ϴ� ��� ���̺���� ���� ���� �� ��ŭ,
   ���� ���� �� ��ŭ �����ȴ�.
 - ���� �ذ��� ���Ͽ� �ݵ�� �ʿ��� ��찡 �ƴϸ� ����� ���� �ؾ���.

�������)
SELECT 'CART' AS ���̺��, COUNT(*) AS ���Ǽ�
FROM CART
UNION ALL
SELECT 'BUYPROD', COUNT(*)
FROM PROD; 

SELECT * 
FROM CART,BUYPROD,PROD;

ANSI : CROSS JOIN

SELECT COUNT(*)
FROM BUYPROD
CROSS JOIN CART
CROSS JOIN PROD;


2. ��������( INNER JOIN ) 
 - ���� ������ �����ϴ� �ڷḸ ��ȯ�ϰ�, ���� ������ �������� �ʴ� �ڷ�� ������.

�������)




