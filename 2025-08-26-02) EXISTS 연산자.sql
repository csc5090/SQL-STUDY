2025-08-26-02) EXISTS ������
  - EXISTS �����ڴ� WHERE ���� ���Ǹ� �ݵ�� ���������� ����Ǿ�� �Ѵ�.
  - EXISTS ������ �������� �÷����� ������� ����
  - ������ ���������� ����� �� ���̶� ������ ��(TRUE)�� ��ȯ

��뿹) ��ٱ��� ���̺��� 2020�� 4���� �Ǹŵ� ��ǰ�� 6������ �Ǹŵ� ��ǰ�� ã�� 
       ��ǰ��ȣ, ��ǰ���� ����Ͻÿ�.
2020�� 4���� �Ǹŵ� ��ǰ�� ��ǰ��ȣ, ��ǰ�� 

SELECT DISTINCT A.PROD_ID, B.PROD_NAME 
FROM CART A 
INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
WHERE A.CART_NO LIKE '202004%'
INTERSECT
SELECT DISTINCT A.PROD_ID, B.PROD_NAME 
FROM CART A 
INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
WHERE A.CART_NO LIKE '202006%'
ORDER BY 1;

(EXISTS ������ ���)
SELECT DISTINCT A.PROD_ID, B.PROD_NAME 
FROM CART A 
INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
WHERE A.CART_NO LIKE '202004%'
AND NOT EXISTS(SELECT 1
             FROM CART C
            WHERE C.CART_NO LIKE '202006%'
            AND A.PROD_ID=C.PROD_ID);

