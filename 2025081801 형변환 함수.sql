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
    

2. TO_DATE


3. TO_NUMBER

4. CAST