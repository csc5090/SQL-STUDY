2025-0819-01) ROLLUP�� CUBE

- GROUP BY �� �ȿ� ���Ǿ� �پ��� ������ ����� ��ȯ
- GROUP BY ���δ� ��ü �հ踦 ���Ҽ� ������ ROLLUP�� CUBE�� ����ϸ� ��ü �հ赵 ���� �� ����

1. ROLLUP
�������)
    GROUP BY [�÷���,...,] ROLLUP(�÷���,...,) [�÷���,...]
    . �ݵ�� GROUP BY�� �ȿ����� ���
    . ������ ���� ��ȯ
     - ���� ������ ��� �÷��� ����� �����̸� �ش� ���谡 ����Ǹ� ������ ���� �ϳ��� �÷��� �����ϸ� ���踦 ��ȯ
        ex)GROUP BY ROLLUP(COL1, COL2, COL3) �ΰ��
           . ���� �������� ���� : COL1,COL2,COL3�� ��� ����� ����(GROUP BY�� ����)
           . ���� ���� ���� : COL1,COL2�� ����� ����
           . ���� ���� ���� : COL1�� ����� ����
           . ������ ���� ���� : ��� �÷��� ������ ����(��ü����)
    . ROLLUP���� ����� �÷��� N���϶� N+1�� ������ ���� ��ȯ
    . ROLLUP�� �� �Ǵ� �ڿ� �÷��� ����Ǹ� �κ� ROLLUP ��� ��ȯ(��ü���踦 ���� �� ����)

��뿹)��ٱ��� ���̺��� ����, ȸ����, ��ǰ��, ���ż��� �հ踦 ��ȸ
    
(GROUP BY ����)
    SELECT SUBSTR(CART_NO,5,2) AS ��,
           MEM_ID AS ȸ����ȣ,
           PROD_ID AS ��ǰ��,
           SUM(CART_QTY) AS "���ż��� �հ�"
    FROM CART
    GROUP BY SUBSTR(CART_NO,5,2),MEM_ID,PROD_ID
    ORDER BY 1, 2, 3;
    
(ROLLUP) ���)

    SELECT SUBSTR(CART_NO,5,2) AS ��,
           MEM_ID AS ȸ����ȣ,
           PROD_ID AS ��ǰ��,
           SUM(CART_QTY) AS "���ż��� �հ�"
    FROM CART
    GROUP BY ROLLUP(SUBSTR(CART_NO,5,2),MEM_ID,PROD_ID)
    ORDER BY 1, 2, 3;
    
    �κ� ROLLUP�� ����
    
    SELECT SUBSTR(CART_NO,5,2) AS ��,
           MEM_ID AS ȸ����ȣ,
           PROD_ID AS ��ǰ��,
           SUM(CART_QTY) AS "���ż��� �հ�"
    FROM CART
    GROUP BY SUBSTR(CART_NO,5,2), ROLLUP(MEM_ID,PROD_ID)
    ORDER BY 1, 2, 3;
    
    2.CUBE
    �������)
        GROUP BY [�÷���,...,] CUBE(�÷���,...,) [�÷���,...,]
        
        .�ݵ�� GROUP BY �� �ȿ����� ���
        .���հ����� ��� ������ ���踦 ��ȯ
        .CUBE ���� ����� �÷��� N���� �� 2^n������ ���� ��ȯ
        .CUBE �� �� �Ǵ� �ڿ� �÷��� ����Ǹ� �κ� CUBE ��� ��ȯ(��ü���踦 ���� �� ����)
        
SELECT SUBSTR(CART_NO,5,2) AS ��,
           MEM_ID AS ȸ����ȣ,
           PROD_ID AS ��ǰ��,
           SUM(CART_QTY) AS "���ż��� �հ�"
    FROM CART
    GROUP BY CUBE(SUBSTR(CART_NO,5,2),MEM_ID,PROD_ID)
    ORDER BY 1, 2, 3;