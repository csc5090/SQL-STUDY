2025-08-20-01) NULL ó�� �Լ�
    - ����Ŭ���� ����ڰ� �÷��� �����ϰ� ���� �������� ������ �⺻������ NULL���� ������.
    - ����� ��� �� ���� NULL�̸� ����� �ݵ�� NULL�� ��.
    - ����Ŭ�� NULLó�� �Լ��δ� NVL, NVL2, NULLIF, COALESCE ���� ���� ��.

1. IS NULL�� IS NOT NULL
    - ��������
    - Ư�� �÷��� ���� NULL������ �Ǵ��� �� '='�����ڷδ� ��� �򰡸� �� �� ����.
    - �� �� ���Ǵ� �����ڰ� IS NULL/IS NOT.
    
    ��뿹) ��ǰ���̺��� ���������� ���� ���� ��ǰ�� ��ȸ�Ͻÿ�.
           ��ǰ�ڵ�, ��ǰ��, ����
           
           SELECT PROD_ID AS ��ǰ�ڵ�,
                  PROD_COLOR AS ����,
                  PROD_NAME AS ��ǰ��
           FROM PROD
           WHERE PROD_COLOR IS NOT NULL;
           
           
2. NVL(col,value)
    - col�� ���� NULL�̸� value�� ��ȯ�ϰ� NULL�� �ƴϸ� col���� ��ȯ��.
    - col�� ������ Ÿ�԰� value�� ������ Ÿ���� �ݵ�� ��ġ�ؾ� ��.
    
��뿹) ��ǰ���̺��� ũ������(PROD_SIZE)�� ��ȸ�Ͽ� �� ���� NULL�̸� 'ũ�� ���� ����'�� ����ϰ�,
        NULL�� �ƴϸ� ũ�⸦ ����Ͻÿ�.
        
SELECT  PROD_ID AS ��ǰ�ڵ�,
        PROD_NAME AS ��ǰ��,
        NVL(LPAD(PROD_SIZE,8),'���� ����') AS ũ��
FROM PROD;
        
        
��뿹) 2020�� 2�� ��� ��ǰ�� ���Լ����� ��ȸ�Ͻÿ�.
        ��ǰ�ڵ�,��ǰ��,���Լ���
        
SELECT B.PROD_ID AS ��ǰ�ڵ�,
       B.PROD_NAME AS ��ǰ��,
       NVL(SUM(A.BUY_QTY),0) AS ���Լ���
FROM BUYPROD A
RIGHT OUTER JOIN PROD B ON(A.PROD_ID=B.PROD_ID AND A.BUY_DATE
         BETWEEN TO_DATE('20200201') AND LAST_DAY(TO_DATE('20200201')))
GROUP BY B.PROD_ID, B.PROD_NAME
ORDER BY 1;

        
**��ǰ���̺��� �з��ڵ� 'P301'�� ���� ��ǰ�� ����ܰ��� ���Դܰ��� �����Ͻÿ�.

UPDATE PROD 
SET PROD_PRICE=PROD_COST
WHERE LPROD_GU='P301';

SELECT *
FROM PROD
WHERE LPROD_GU='P301';
        
3. NVL2(col, value1, value2)
    - col ���� ���Ͽ� �� ���� NULL�̸� value2��, NULL�� �ƴϸ� value1�� ��ȯ.
    - value1�� value2�� ������ Ÿ���� ���� �ؾ� ��.
    
    SELECT NVL2(PROD_DETAIL, '�ζٱ��Ӥ���', '�ȳζٱ��Ӥ���') AS �ζٱ��ΰ�
    FROM PROD;
    
��뿹) ������̺��� ������� ���������� ��ȸ�Ͽ� ���ʽ��� ����Ͽ� ����Ͻÿ�.
        ���������� ���ٸ� '�������� ����'����, ������ �⺻���� 50%�� ���ʽ��� ����.

SELECT EMPLOYEE_ID AS �����ȣ,
       EMP_NAME AS �����,
       NVL2(COMMISSION_PCT,TO_CHAR(ROUND(SALARY*0.5),'99,999'), '�������� ����') AS ���ʽ�
FROM C##HR.EMPLOYEES;

