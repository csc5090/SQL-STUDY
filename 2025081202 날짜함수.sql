2025-0812-02)
3. ��¥�Լ�
    1) SYSDATE
        - ǥ�� ��¥ �Լ�
        - �ý����� �����ϴ� ��,��,��,��,��,�ʸ� ���·� ��ȯ.
        - ������ ������ ����� �� �� ������ ��¥�� ������ �� ��¥ ���̿� ����� ������ ��ȯ.
        
��뿹)
    SELECT SYSDATE, SYSDATE-10, SYSDATE+35,
           SYSDATE-TO_DATE('20241215'),TRUNC(SYSDATE)-TO_DATE('20241215')
        FROM DUAL;
        
        
2.ADD_MONTH(date, n)
    - �־��� ��¥�ڷ� date�� ���� n�� ���� ��¥�� ��ȯ.
    
��뿹2)
ȸ�����̺��� MEM_BIR�� ȸ�� �������̶� �������� ��. 2�� �� 7�� ���� ��¥�����Ͻÿ�.
SELECT MEM_ID AS ȸ����ȣ,
       MEM_NAME AS ȸ����,
       MEM_BIR AS ����,
       ADD_MONTHS(MEM_BIR,2) AS ������,
       ADD_MONTHS(MEM_BIR,2)-7 AS �˶�����
FROM MEMBER;
        
3. NEXT_DAY(date, c)  ex) SELECT NEXT_DAY(DATE '2025-08-12', 'ȭ����')
  - �־��� ��¥ 'date'���� �ٰ��� 'c'������ ��¥�� ��ȯ.
  - 'c'�� '������', '��' ~ '�Ͽ���', '��'�� �����.

��뿹)
SELECT NEXT_DAY(SYSDATE,'ȭ����'),
       NEXT_DAY(SYSDATE,'�����')
    FROM DUAL;
    

������̺��� 80�� �μ��� ����� �ټӱⰣ�� XX�� XX���� �������� ����Ͽ� ��ȸ�Ͻÿ�.
       ALIAS�� �����ȣ, �����, �Ի���, �ټӱⰣ.