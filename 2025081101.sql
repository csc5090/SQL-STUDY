2025-0811-01)
4. ANY(SOME)
(�������)
    expr    ���迬���� ANY|SOME(��1, ��2, ..., ��N)
    . expr�� ���� '��1, ��2,,,��n' �� �ϳ��� ���� ���迬���ڸ� �����ϸ� ��(true)�� ��ȯ��.
    . '='�����ڸ� ����ϸ� IN�����ڿ� ���� ����� ������.
    
    
��뿹) 
      1) ��ǰ���̺��� 'P102' �з��� ���� ��� ��ǰ�� ���� ������ �ǸŰ� ���� �� ū �ǸŰ���
         ���� ��ǰ�� ��ǰ��ȣ, ��ǰ��, �з��ڵ�, �ǸŰ��� ��ȸ�Ͽ� �ǸŰ� ������ ��ȸ�Ͻÿ�.
    
    ('P101' �з��� ���� ��ǰ�� �ǸŰ�)
        SELECT PROD_PRICE
        FROM   PROD
        WHERE  LPROD_GU='P102'
        
      SELECT PROD_ID AS ��ǰ��ȣ,
             PROD_NAME AS ��ǰ��,
             LPROD_GU AS �з��ڵ�,
             PROD_PRICE AS �ǸŰ�
        FROM PROD
       WHERE PROD_PRICE >ANY(SELECT PROD_PRICE
                             FROM   PROD
                             WHERE  LPROD_GU='P102')
         AND LPROD_GU !='P102'
       ORDER BY 4;
       
       
      2) ȸ�����̺��� � 30�� ȸ������ ���ϸ��� ���� ���� ���ϸ����� ������ ȸ�������� ��ȸ�Ͻÿ�.
      alias�� ȸ����ȣ, ȸ����, ����, ���ϸ���.
      
       SELECT MEM_MILEAGE
         FROM MEMBER
        WHERE TRUNC((EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BTR))/10)=3
        
      (30�� ȸ������ ���ϸ���)
      
      SELECT MEM_ID AS ȸ����ȣ,
             MEM_NAME AS ȸ����,
             EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) AS ����,
             MEM_MILEAGE AS ���ϸ���
        FROM MEMBER
        WHERE NOT MEM_MILEAGE <SOME(SELECT MEM_MILEAGE) AND
        TRUNC((EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR))/10)!=3
        ORDER BY 4 DESC;
        
5. ALL
    expr    ���迬����ALL(��1, ��2, ... ��n)
      . expr�� ���� '��1, ��2,..., ��n' ��ο� ���� ���迬���ڸ� �����ϸ� ��(true)�� ��ȯ��.
      . '='�����ڴ� ����� ���� �� ����.
      
      
      ��뿹) 
      1) ��ǰ���̺��� 'P201' �з��� ���� ��� ��ǰ�� ���� ������ �ǸŰ� ���� �� ū �ǸŰ���
         ���� ��ǰ�� ��ǰ��ȣ, ��ǰ��, �з��ڵ�, �ǸŰ��� ��ȸ�Ͽ� �ǸŰ� ������ ��ȸ�Ͻÿ�.
('P201'�з��� ���� ��ǰ�� �ǸŰ�)
    SELECT PROD_PRICE
      FROM PROD
     WHERE LPROD_GU='P201'
     
    SELECT PROD_ID AS ��ǰ��ȣ,
           PROD_NAME AS ��ǰ��,
           LPROD_GU AS �з��ڵ�,
           PROD_PRICE AS �ǸŰ�
      FROM PROD
     WHERE PROD_PRICE > ALL(SELECT PROD_PRICE
                            FROM PROD
                            WHERE LPROD_GU='P201')
    ORDER BY 4;
