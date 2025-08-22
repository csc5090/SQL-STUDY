2025-08-22-01) �ܺ� JOIN(OUTER JOIN)

  - �������� ���������� �����ϴ� �ڷḸ ��ȯ�ϰ�, �׷��� ���� �ڷ�� ������.
  - �ܺ������� �ڷ��� ������ ������ ���̺� ���� ���� ���� �� ��ŭ �� ��(NULL) ������ �� ���� ����.
  - COUNT �Լ��� COUNT(�÷���) ���¸� ����ؾ� �Ѵ�.
  - SELECT ������ ��� 2�� �̻��� ���̺� �������� �����ϴ� �÷��� ��ȸ�� �� 
    --�� �� �� ���� ���� �÷����� ����ؾ� �Ѵ�.
  
��� ����)
    SELECT �÷���
    FROM   ���̺��[��Ī1],...   
    WHERE  ��Ī1.�÷���1=��Ī2.�÷���2(+)     --- ���̺��2�� ������ �����.
                    :  
                    :
                    :
   . ���� ���� �� �ܺ������� �ʿ��� ��� ���ǿ� �ܺ����� ������ '(+)'�� �����Ѵ�.
   . 3�� �̻��� ���̺��� �ܺ����� �Ǵ� ��� �� ���̺��� ���ÿ� �ٸ� �� ���̺� �ܺ����� �� �� ����.
     ��, A,B,C ���̺��� �ܺ����� �Ǵ� ��� A(+)=B AND A(+) = C�� ������ ����.
   . ���� ��ο� �ܺ����� �����ڸ� ����� �� ����(ANSI�� ����)
     �� A(+)=B(+)�� ��� �� ��.
   . �Ϲ� ������ �ܺ����� ������ ���� ����Ǹ� ����� �������� ����� ��ȯ��.
   -> �ذ� ������� ANSI���� ��� �Ǵ� �������� ��� (�������� ��� ����. ANSI�� �Ѵ��ص� ������ �޶� ��Ȯ�� ����� �� ��.)
   
ANSI �ܺ�����)
SELECT �÷���
FROM ���̺��1 [��Ī1]
FULL|LEFT|RIGHT OUTER JOIN ���̺��2 [��Ī2] ON (�������� [AND �Ϲ�����])
FULL|LEFT|RIGHT OUTER JOIN ���̺��3 [��Ī3] ON (�������� [AND �Ϲ�����])
                            :
                            :
                            :
[WHERE �Ϲ�����]
                            :
                            :
                            :

  . ������ ���̺��1�� ���̺��2�� �ܺ����εǰ� ���� �� ���� ����� ���̺��3�� �ܺ� ���� ��.
  . FULL : FROM �� �� ���̺�� JOIN�� �� ���̺��� �ڷᰡ ��� ������ ��� ���
  . LEFT : FROM �� ���� ����� JOIN�� �� ���̺��� �ڷẸ�� �� ���� ��� ���.
  . RIGHT : JOIN�� �� ���̺��� �ڷᰡ FROM ������ ������� �� ���� ��� ���
  ** �� �� �ڷᰡ ���� ������ ���ϴ� �÷��� ����Ͽ� ����.
  . ���� ���ǰ� �Ϲ������� ON ���� ����� �� ����.
  . WHERE ���� ���Ǹ� �������� ����� ��ȯ ��.
  
  
��뿹) 

1) ��� �з��� �з���� ��ǰ�� ���� ��� �ǸŰ��� ��ȸ�Ͻÿ�.

SELECT COUNT(*) FROM LPROD; -- 9
SELECT COUNT(DISTINCT LPROD_GU) FROM PROD; --6


SELECT A.LPROD_GU AS �з��ڵ�,
       A.LPROD_NAME AS �з���,
       COUNT(PROD_ID) AS "��ǰ�� ��",
       NVL(TRUNC(AVG(B.PROD_PRICE)),0) AS "��� �ǸŰ�"
FROM LPROD A, PROD B
WHERE A.LPROD_GU=B.LPROD_GU(+)
GROUP BY A.LPROD_GU, A.LPROD_NAME
ORDER BY 1;


ANSI

SELECT A.LPROD_GU AS �з��ڵ�,
       A.LPROD_NAME AS �з���,
       COUNT(PROD_ID) AS "��ǰ�� ��",
       NVL(TRUNC(AVG(B.PROD_PRICE)),0) AS "��� �ǸŰ�"
FROM LPROD A
LEFT OUTER JOIN PROD B ON(A.LPROD_GU=B.LPROD_GU)
GROUP BY A.LPROD_GU,A.LPROD_NAME
ORDER BY 1;

2) 2020�� ��� ��ǰ�� ���� ������ ���� �ݾ��� ��ȸ�Ͻÿ�.

SELECT P.PROD_ID AS ��ǰ�ڵ�,
       P.PROD_NAME AS ��ǰ��,
       NVL(SUM(B.BUY_QTY),0) AS "���� ���� �հ�", 
       NVL(SUM(B.BUY_QTY*P.PROD_COST),0) AS "���� �ݾ� �հ�"
FROM PROD P, BUYPROD B
WHERE B.PROD_ID(+)=P.PROD_ID     --��������(��ǰ��, ���Դܰ� ����)
AND   B.BUY_DATE(+) BETWEEN TO_DATE('20200101') AND ('20200131')
GROUP BY P.PROD_ID, P.PROD_NAME
ORDER BY 1; 


ANSI

SELECT P.PROD_ID AS ��ǰ�ڵ�,
       P.PROD_NAME AS ��ǰ��,
       NVL(SUM(B.BUY_QTY),0) AS "���� ���� �հ�", 
       NVL(SUM(B.BUY_QTY*P.PROD_COST),0) AS "���� �ݾ� �հ�"
FROM PROD P
            LEFT OUTER JOIN BUYPROD B ON(P.PROD_ID=B.PROD_ID) AND B.BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200131')
GROUP BY P.PROD_ID,P.PROD_NAME
ORDER BY 1;

SUBQUERY)
(�������� : 2020�� 1�� ��ǰ�����Աݾ�,���Լ����հ�)


SELECT B.PROD_ID AS BPID,
       SUM(B.BUY_QTY) AS BQTY,
       SUM(B.BUY_QTY*A.PROD_COST) AS BSUM
FROM BUYPROD B
INNER JOIN PROD A ON(B.PROD_ID=A.PROD_ID)
WHERE B.BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200131')
GROUP BY B.PROD_ID;



SELECT P.PROD_ID AS ��ǰ�ڵ�,
       P.PROD_NAME AS ��ǰ��,
       NVL(M.BQTY,0) AS ���Լ����հ�,
       NVL(M.BSUM,0) AS ���Աݾ��հ�
FROM PROD P, (SELECT B.PROD_ID AS BPID,
              SUM(B.BUY_QTY) AS BQTY,
              SUM(B.BUY_QTY*A.PROD_COST) AS BSUM
              FROM BUYPROD B
              INNER JOIN PROD A ON(B.PROD_ID=A.PROD_ID)
              WHERE B.BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200131')
              GROUP BY B.PROD_ID)M
WHERE P.PROD_ID=M.BPID(+)
ORDER BY 1;

3) 2020�� ��ݱ� ��� ȸ���� ������Ȳ�� ��ȸ�Ͻÿ�.

SELECT B.MEM_ID AS ȸ����ȣ,
       B.MEM_NAME AS ȸ����,
       NVL(SUM(A.CART_QTY*C.PROD_PRICE),0) AS ���űݾ��հ�
FROM CART A, MEMBER B, PROD C
WHERE SUBSTR(A.CART_NO(+),1,6) BETWEEN '202001' AND '202006' 
AND A.MEM_ID(+)=B.MEM_ID
AND A.PROD_ID(+)=C.PROD_ID
GROUP BY B.MEM_ID, B.MEM_NAME
ORDER BY 1;


SELECT B.MEM_ID AS ȸ����ȣ,
       B.MEM_NAME AS ȸ����,
       NVL(SUM(A.CART_QTY*C.PROD_PRICE),0) AS ���űݾ��հ�
FROM CART A
RIGHT OUTER JOIN MEMBER B ON(A.MEM_ID=B.MEM_ID)
LEFT  OUTER JOIN PROD C ON(A.PROD_ID=C.PROD_ID AND
                           SUBSTR(A.CART_NO,1,6) BETWEEN '202001' AND '202006')
GROUP BY B.MEM_ID,B.MEM_NAME
ORDER BY 1;

��뿹) 2020�� ��� ��ǰ�� ����/������� ��ȸ�Ͻÿ�.

(���ѿ����� + ��������)
SELECT APID AS ��ǰ�ڵ�,
       NVL(SUM(MAEIB),0) AS ���Ծ�,
       NVL(SUM(MAECHUL),0) AS �����
FROM( SELECT A.PROD_ID AS APID,
      SUM(A.PROD_COST*BUY_QTY) AS MAEIB,
      0 AS MAECHUL
      FROM PROD A
      INNER JOIN BUYPROD B ON (A.PROD_ID=B.PROD_ID AND EXTRACT(YEAR FROM B.BUY_DATE)=2020)
      GROUP BY A.PROD_ID
      UNION ALL
      SELECT A.PROD_ID, 0, SUM(A.PROD_PRICE*B.CART_QTY)
      FROM PROD A
      INNER JOIN CART B ON (A.PROD_ID=B.PROD_ID AND SUBSTR(B.CART_NO,1,4)='2020')
      GROUP BY A.PROD_ID)
      GROUP BY APID
      ORDER BY 1;
      

(�Ϲ� �ܺ� ����)
SELECT C.PROD_ID AS ��ǰ��ȣ,
       C.PROD_NAME AS ��ǰ��,
       NVL(SUM(B.BUY_QTY*C.PROD_COST),0) AS ���Ծ�,
       NVL(SUM(A.CART_QTY*C.PROD_PRICE),0) AS �����
FROM CART A, BUYPROD B, PROD C
WHERE A.PROD_ID(+)=C.PROD_ID
AND A.CART_NO(+) LIKE '2020%'
AND B.PROD_ID(+)=C.PROD_ID
AND EXTRACT(YEAR FROM B.BUY_DATE(+)) = 2020
GROUP BY C.PROD_ID,C.PROD_NAME
ORDER BY 1;

(�������� �̿�)
  SELECT A.PROD_ID AS ��ǰ�ڵ�,
         A.PROD_NAME AS ��ǰ��,
         A.MAEIB AS ���Ծ�,
         B.MAECHUL AS �����
  FROM   PROD A,
                (SELECT A.PROD_ID AS APID,
                 SUM(A.BUY_QTY*B.PROD_COST) AS MAEIB
                 FROM BUYPROD A
                 INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
                 WHERE EXTRACT(YEAR FROM A.BUY_DATE)=2020
                 GROUP BY A.PROD_ID; ) B,
 
                 (SELECT A.PROD_ID AS CPID,
                  SUM(A.CART_QTY*B.PROD_PRICE)AS MAECHUL
                  FROM CART A
                  INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
                  WHERE SUBSTR(A.CART_NO,1,4)='2020'
                  GROUP BY A.PROD_ID) C

 WHERE   A.PROD_ID=B.APID(+)
 AND     A.PROD_ID=C.CPID(+)
 ORDER BY 1;
 
 
 
 (2020�� ��ǰ�� ���Ծ� : ��������)
 
 (SELECT A.PROD_ID AS APID,
        SUM(A.BUY_QTY*B.PROD_COST) AS MAEIB
 FROM BUYPROD A
 INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
 WHERE EXTRACT(YEAR FROM A.BUY_DATE)=2020
 GROUP BY A.PROD_ID; ) B,
 
 (2020�� ��ǰ�� ����� : ��������)
 
 (SELECT A.PROD_ID AS CPID,
        SUM(A.CART_QTY*B.PROD_PRICE)AS MAECHUL
        FROM CART A
        INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
WHERE SUBSTR(A.CART_NO,1,4)='2020'
GROUP BY A.PROD_ID) C



(ANSI OUTER JOIN)


SELECT A.PROD_ID AS ��ǰ�ڵ�,
       A.PROD_NAME AS ��ǰ��,
       NVL(SUM(A.PROD_COST*B.BUY_QTY),0) AS ���Ծ�,
       NVL(SUM(A.PROD_PRICE*C.CART_QTY),0) AS �����
FROM   PROD A
LEFT OUTER JOIN BUYPROD B ON(A.PROD_ID=B.PROD_ID AND EXTRACT(YEAR FROM B.BUY_DATE)=2020)
LEFT OUTER JOIN CART C ON(A.PROD_ID=C.PROD_ID AND C.CART_NO LIKE '2020%')
GROUP BY A.PROD_ID, A.PROD_NAME
ORDER BY 1;

