2025-08-29-01) �����Լ� 2

    - HAVING �� : SELECT ������ ���� �����Լ��� ������ �ο��� �� ���
    
��뿹) HR�������� ����� ���� 10�� �̻��� �μ��� ��ȸ�Ͻÿ�.
        AS�� �μ���ȣ, �����

SELECT DEPARTMENT_ID AS �μ���ȣ,
       COUNT(*) AS �����
FROM C##HR.EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 10
ORDER BY 1;


��뿹) 2020�� 5�� ȸ�� �� ���ż����� ����Ƚ���� ��ȸ�ϰ�, ����Ƚ���� 2ȸ �̻��� ȸ���� ������ ��ȸ�Ͻÿ�.

SELECT B.MEM_ID AS ȸ���ڵ�,
       A.MEM_NAME AS ȸ����,
       SUM(B.CART_QTY) AS ���ż���,
       COUNT(DISTINCT B.CART_NO) AS ����Ƚ��
FROM MEMBER A
INNER JOIN CART B ON(A.MEM_ID=B.MEM_ID)
WHERE CART_NO LIKE '202005%'
HAVING COUNT(DISTINCT B.CART_NO) >= 2
GROUP BY A.MEM_NAME, B.MEM_ID
ORDER BY 1;




SELECT B.MEM_ID AS ȸ���ڵ�,
       A.MEM_NAME AS ȸ����,
       SUM(B.CART_QTY) AS ���ż���,
       COUNT(B.CART_QTY) AS ����Ƚ��
FROM MEMBER A
INNER JOIN CART B ON(A.MEM_ID=B.MEM_ID)
WHERE CART_NO LIKE '202005%'
HAVING COUNT(B.CART_QTY) >= 2
GROUP BY A.MEM_NAME, B.MEM_ID
ORDER BY 1;

SELECT MEM_ID,
       COUNT(MEM_ID)
  FROM CART
WHERE MEM_ID IN ('a001') AND CART_NO LIKE '202005%'
GROUP BY MEM_ID
HAVING COUNT(MEM_ID) >= 2


��뿹) ��ǰ���̺��� �з��� ��ǰ�� ���� ��ȸ�ϰ� ��ǰ�� �������� 5�� �̻��� �з��� ����Ͻÿ�.

SELECT LPROD_GU AS �з�,
       AS "��ǰ�� ������"
       COUNT(*) AS "��ǰ�� ��"
FROM PROD
GROUP BY LPROD_GU
HAVING COUNT(*)>=10
ORDER BY 1;