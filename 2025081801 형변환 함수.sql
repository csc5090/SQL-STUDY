2025-0818-01) ����ȯ �Լ�
  - TO_CHAR, TO_DATE, TO_NUMBER, CAST
  
  
1. TO_CHAR(c|d|n [,fmt])
    - �־��� �ڷ�(���ڿ�, ����, ��¥ Ÿ��)�� ���ڿ��� �ٲ�
    - �־��� �ڷᰡ ���ڿ��� ��� Ÿ���� CLOB�̳� CHAR�� �ڷḦ VARCHAR2�� �ٲ� ���� ����
    - fmt�� ���ڿ��� �ٲ� �� ����Ǵ� �������� ��¥���İ� ������������ ����
    
    1) ��¥ ���� ���� ���ڿ�
    --------------------------------------------------
    ���Ĺ��ڿ�        | �ǹ�            |  ��
    --------------------------------------------------
    AD,BC,CC        | ����(AD),       |
                    | �����(BC),     |
                    | ����(CC)        | SELECT TO_CHAR(SYSDATE, 'AD   BC   CC   Q') FROM DUAL;
    Q               | �б�            | SELECT TO_CHAR(SYSDATE, 'Q') || '�б�' FROM DUAL;
    YYYY,YYY,YY,Y   | �⵵            | SELECT TO_CHAR(SYSDATE, 'YYYY   YYY    YY   Y') FROM DUAL;       
    YEAR            | �⵵            | SELECT TO_CHAR(SYSDATE, 'YEAR') FROM DUAL;
    MONTH, MON      | ��              | SELECT TO_CHAR(SYSDATE, 'MONTH     MON') FROM DUAL;
    MM, RM          | ��              | SELECT TO_CHAR(SYSDATE, 'MM      RM') FROM DUAL; 
    DDD, DD, J      | ��              | SELECT TO_CHAR(SYSDATE, 'DDD  DD  J') FROM DUAL;
    DAY, DY, D      | ����            | SELECT TO_CHAR(SYSDATE, 'DAY   DY  D') FROM DUAL;
    AM, A.M,        | ����            | SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD AM') FROM DUAL; 
    PM, P.M,        | ����            | SELECT TO_CHAR(SYSDATE, 'PM   P.M') FROM DUAL;
    HH, HH12, HH24  | �ð�            | 
    MI              | ��              | SELECT TO_CHAR(SYSDATE, 'YYYY MM DD HH MI SS') FROM DUAL;
    SS, SSSSS       | ��              | SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SSSSS') FROM DUAL;
                                        SELECT 15*60*60+57*60+04 FROM DUAL;
    "   "           | ����� ���� ���ڿ� |  SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��" HH24:MI:SS  SSSSS') FROM DUAL;

2) ���� ���� ���� ���ڿ�
--------------------------------------------------------------------------------
    ���� ���ڿ�       |     �ǹ�                             |  ��
--------------------------------------------------------------------------------
         9         |��������� �ڸ�, ��ȿ�� ������ ��� ���     | SELECT TO_CHAR(2345, '99999999') AS "COL1" FROM DUAL;
                   |��ȿ���ڰ� �ƴ� ��� ���� ���              |
                   |(�Ҽ����� ���� �ȵǴ� �ڸ����� �ݿø�)       | SELECT TO_CHAR(2345, '00000000') AS "COL1" FROM DUAL;
         0         |��������� �ڸ�, ��ȿ�� ������ ��� ���     |            
                   |��ȿ���ڰ� �ƴѰ�� '0'���(�Ҽ��� ��������)  |            
      $,  L        |�޷� �� ����ȭ�� ��ȣ�� ��ȿ���� ���ʿ� ���  |SELECT TO_CHAR(PROD_COST, '$999,999') AS ���԰� FROM PROD WHERE LPROD_GU='P201';
       MI          |������ ��� ������ ���̳ʽ� ǥ��.           |SELECT TO_CHAR(-23456, '99,999MI') FROM DUAL;
                   |���� ���ڿ� ������ ���                   |
       PR          |������ ��� �ڷḦ "< >"�ȿ� ǥ��.         |SELECT TO_CHAR(-23456, '99,999PR') FROM DUAL;
                   |���� ���ڿ� ������ ���                   |
  ,(COMMA),        |3�ڸ������� �ڸ���                       |
  .(DOT)           |�Ҽ���                                 |


2. TO_NUMBER(c [,fmt])
    - �־��� ���ڿ� �ڷ� 'c'�� ���� ���ڷ� ��ȯ��.
    - 'c'�� �ݵ�� ���ڷ� ��ȯ ������ ���̾�� ��.
    - 'fmt'�� 'c'�� ���Ե� �������ڿ� ������ �ڵ����� ���ڷ� ��ȯ�� �� ���� ��
      �⺻�� ���ڸ� 'c'�� �����ϱ� ���� ���� ���Ĺ��ڿ��̸� ����� �⺻ �������� 

3. TO_NUMBER

4. CAST