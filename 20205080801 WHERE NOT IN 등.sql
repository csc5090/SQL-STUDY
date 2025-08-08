2025_0808_01 ) ��Ÿ������
    - BETWEEN, LIKE, IN, ALL, ANY(SOME) EXISTS ���� ������.
1. BETWEEN
  - ������ ������ �� ���
  - AND �����ڷ� ġȯ ����

�������)
 expr BETWEEN ��1 AND ��2
 . expr ���� '��1'���� '��2' ���̿� �����ϸ� ��(true)�� ��ȯ.
 . AND �����ڷ� �ٲپ� ����� �� �ִ�.
 . '��1'�� '��2'�� ���� ������ Ÿ���̰ų� ��ȯ �� �� �־�� �Ѵ�.
 
 
 (��뿹)
 1) 2020�� 1�� �����ڷḦ ��ȸ�Ͻÿ�. (��¥, ��ǰ�ڵ�, ���Լ���)
-and + BETWEEN �����ڸ� �̿�
  SELECT BUY_DATE AS ��¥,
         PROD_ID AS ��ǰ�ڵ�, 
         BUY_QTY AS ���Լ���
   FROM BUYPROD
   --WHERE BUY_DATE >= '20200101' AND BUY_DATE <= '20200131'
   WHERE BUY_DATE BETWEEN '20200101' AND '20200131'
   ORDER BY 1;
 
 2) HR ���� EMPLOYEES ���̺��� 10��~40���μ��� ���� ��� ������ ��ȸ�Ͻÿ�.
    Alias�� �����ȣ, �����, �Ի���, �μ���ȣ 
    
    SELECT EMPLOYEE_ID AS �����ȣ, 
           EMP_NAME AS �����,
           HIRE_DATE �Ի���,
           DEPARTMENT_ID AS �μ���ȣ
    FROM C##HR.EMPLOYEES
    WHERE DEPARTMENT_ID BETWEEN 10 AND 40
    --WHERE DEPARTMENT_ID IN(10,20,30,40)
    --WHERE DEPARTMENT_ID = ANY(10,20,30,40)
   /* WHERE DEPARTMENT_ID = 10
    OR DEPARTMENT_ID = 20
    OR DEPARTMENT_ID = 30
    OR DEPARTMENT_ID = 40*/
    --WHERE DEPARTMENT_ID>=10 AND DEPARTMENT_ID <= 40
    ORDER BY 4;
    
2. LIKE 
   ������ ���� �� ���.
   ���� ����'%'�� '_'���
   -'%' : ���̿� ��� ���� (���� ���� ��쵵 ����) ��� ���� �����͸� �ǹ�.
    EX) '��%'   :   '��'���� �����ϴ� ��� ���ڿ��� ����. '��' ���ڿ��� ����(��, ���� ������ ��޵Ǿ���)
        '%��'   :   '��'���� ������ ��� ���ڿ��� ����. '��'���ڿ��� ����.
        '%��%'  :   '��'�̶�� ���ڰ� �ִٸ�, ��ü ���.
        
   -'_' : � ���̵� ��� ���� �� ���� ���� �����͸� �ǹ�.
     EX) '��_'  :   ���ڰ� 2�����̰�, '��'���� �����ϴ� ��� ���ڿ��� ����.
         '_��'  :   ���ڰ� 2�����̰�, '��'���� ������ ��� ���ڿ��� ����.
         '_��_' :   3���� ���ڿ��� �ι�° ���ڷ� '��'�� �����ϸ� ���� ��ȯ.
   
(�������)
expr  LIKE ���Ϲ��ڿ�
   LIKE �����ڴ� ���ڿ� �񱳿� ����.
-where ���� ���ǹ��� ���
-LIKE �����ڴ� ���ڿ� �񱳿� ����.
 
   
expr  BETWEEN ��1 AND ��2
- expr ���� '��1'���� '��2' ���̿� �����ϸ� ��(true)�� ��ȯ.

   
(��뿹)
1)ȸ�� �� ������ �����ϴ� ȸ���� �˻��Ͻÿ�(ȸ����ȣ,ȸ����,�ּ�)

SELECT MEM_ID AS ȸ����ȣ,
       MEM_NAME AS ȸ����,
       MEM_ADD1||' '||MEM_ADD2 AS �ּ�
FROM MEMBER
WHERE MEM_ADD1 LIKE '����%';

2)2020�� 6���� �Ǹ������� ��ȸ�Ͻÿ�.(��¥, ��ǰ�ڵ�, ����ȸ����ȣ, ����)

SELECT TO_DATE (SUBSTR (CART_NO, 1,8)) AS ��¥,
        PROD_ID AS ��ǰ�ڵ�,
        MEM_ID AS ����ȸ����ȣ,
        CART_QTY AS ����
FROM CART
WHERE CART_NO LIKE '202006%'
ORDER BY 1;

3)2020�� 6�� ���������� ��ȸ�Ͻÿ�(���Գ�¥, ��ǰ��ȣ, ���Լ���)

SELECT BUY_DATE AS ���Գ�¥,
       PROD_ID AS ��ǰ��ȣ,
       BUY_QTY AS ���Լ���
FROM BUYPROD
WHERE BUY_DATE BETWEEN TO_DATE ('20200601') AND ('20200630')
ORDER BY 1;

3. IN
    - ����� �ʵ尡 ���� ���� �� �߿� �ϳ��� ��������� ���캸�� ���� ������.
    - �񱳿����ڿ� �������� OR�� ����Ͽ� �����ϰ� �������� �ۼ����� �ʰ�, �ξ� �����ϰ� ǥ��
    - �ҿ������̰ų� �ұ�Ģ���� ���� ���ϴ� ��� ���.

(�������)
    EXPR  IN(��1, ��2, ..., ��n)
      . expr�� ���� '��1, ��2,...,��n' �� �ϳ��� ������ ��(true)�� ��ȯ.
      . IN �����ڴ� '='����� �����ϰ� ������, �ٸ� ���迬���� ����� �� ����.
      . =ANY, =SOME, OR �����ڷ� ��ó ����.
      
      
(��뿹)
1) HR �������� 20, 40, 90�� �μ��� ���� ����� ��ȸ�Ͻÿ�.(�����ȣ,�����,�μ���ȣ,��å)

SELECT EMPLOYEE_ID AS �����ȣ,
       EMP_NAME AS �����,
       DEPARTMENT_ID AS �μ���ȣ,
       JOB_ID AS ��å
FROM C##HR.EMPLOYEES
WHERE DEPARTMENT_ID IN (20,40,90)
ORDER BY 3; 


** ǥ����
    - ǥ�� SQL������ �б����� �������� ����.
    - SELECT ������ �б���(JAVA�� SWTICH ~ CASE ���� ���)�� ����.
    - CASE WHEN ~ THEN, DECODE �� ������.

    (1) CASE WHEN ~ THEN
    ������� 1)
        CASE WHEN ���ǽ�1 THEN ��1
             WHEN ���ǽ�2 THEN ��2
                       :
                [ELSE ��N]
            END
            .���� ���Ͽ� �� ���� '��1'�̸� '��ȯ��1'�� ��ȯ�ϰ� �ƴϸ� '��'�� ����� ����.
            .'ELSE ��N'�� ��� ���� �İ� ��ġ���� ������ �������� ������ ����.
            .�ڹ��� SWITCH ~ CASE �� ������.
            .�ݵ�� 'END'�� �����ؾ� ��.
            
    (2) DECODE(�÷���, ����1, ���1, ����2, ���2,...����N, ���N+!)
        . �÷��� ���� ����1�� ������ ���1�� ��ȯ�ϰ� �ƴϸ� ������ ���ǵ��� ���ʴ��
          ���ϸ� ��� ������ �������� ������ ���n+1�� ��ȯ��.

2) ȸ�����̺��� ȸ����ȣ, ȸ����, ����, ����, ���ϸ����� ��ȸ�Ͻÿ�.

3) 2020�� 6���� �������� ���� ȸ������ ��ȸ�Ͻÿ�. ȸ����ȣ, ȸ����, ����, ���ϸ���

SELECT MEM_ID AS ȸ����ȣ,
       MEM_NAME AS ȸ����,
       MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ,
       CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','2') THEN
       EXTRACT(YEAR FROM SYSDATE)-(1900+TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)))
       ELSE EXTRACT(YEAR FROM SYSDATE)-(2000+TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)))
       END AS ����,
       DECODE(SUBSTR(MEM_REGNO2,1,1),'1','����ȸ��','2','����ȸ��','3','����ȸ��','4','����ȸ��') AS ����,
       MEM_MILEAGE AS ���ϸ���
       FROM MEMBER;
       
       
3) 2020�� 6���� �������� ���� ȸ������ ��ȸ�Ͻÿ�.(ȸ����ȣ,ȸ����,����,���ϸ���)

SELECT MEM_ID AS ȸ����ȣ,
       MEM_NAME AS ȸ����,
       MEM_MILEAGE AS ���ϸ���
FROM MEMBER
WHERE MEM_ID NOT IN (SELECT DISTINCT MEM_ID
                     FROM CART
                     WHERE CART_NO LIKE '202006%');

(2020�� 6���� ������ ȸ����ȣ)
       
