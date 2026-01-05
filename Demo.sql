SET SERVEROUTPUT ON;

DECLARE
  V_CUR    SYS_REFCURSOR;
  -- Ensure these variables match the types and count in your PROCEDURE
  V_FLAG   VARCHAR2(100); 
  V_MSG    VARCHAR2(500);
  V_TRANID NUMBER;        
BEGIN
  -- Calling the SAVE procedure (Ensure this procedure is compiled)
  SAHIL_USP_SAVE_USERPROFILE(
    P_SYSTRANNO  => 0,
    P_TRNMODE    => 'EDIT',
    P_SYSUSERNO  => 2,
    P_USERID     => 'USERW',
    P_FULLNAME   => 'SAHIL THALE',
    P_EMAIL      => 'SAHIL@GMAIL.COM',
    P_PASSWORD   => 'PASS123',
    P_AGE        => '25',
    P_PHONE      => '9999999999',
    P_GENDER     => 'M',
    P_ADDRESS    => 'STREET 1',
    P_CITY       => 'URAN',
    P_STATE      => 'MH',
    P_ZIPCODE    => '400702',
    P_CREATEDBY  => 'ADMIN',
    P_CUROUTPUT  => V_CUR
  );

  -- THE FIX FOR ORA-06504: 
  -- Match the FETCH exactly to what your procedure's SELECT statement returns
  LOOP
    FETCH V_CUR INTO V_FLAG, V_MSG; -- Ensure 3 variables if SELECT has 3 columns
    EXIT WHEN V_CUR%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('FLAG: ' || V_FLAG || ' | MSG: ' || V_MSG || ' | ID: ' || V_TRANID);
  END LOOP;

  CLOSE V_CUR;

EXCEPTION
  WHEN OTHERS THEN
    IF V_CUR%ISOPEN THEN CLOSE V_CUR; END IF;
    DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END;
/

INSERT INTO SAHIL_MSTUSERPROFILE( SYSUSERNO,USERID) VALUES(2,'USER02');







SELECT * FROM sahil_mstuserprofiletrans;


SELECT * FROM sahil_mstuserprofile;








--CHECKER SP FOR ADD
DECLARE
  V_CUR   SYS_REFCURSOR;
  V_FLAG  VARCHAR2(1);
  V_MSG   VARCHAR2(200);
BEGIN
  SAHIL_USP_AUTHORISE_USERPROFILE(
    P_SYSTRNNO  => 4,        -- USE ACTUAL SYSTRNNO
    P_ACTION    => 'A',
    P_REMARK    => 'NULL',
    P_CHECKER   => 'CHECKER1',
    P_CUROUTPUT => V_CUR
  );

  FETCH V_CUR INTO V_FLAG, V_MSG;
  DBMS_OUTPUT.PUT_LINE('FLAG = ' || V_FLAG || ' | MSG = ' || V_MSG);
  CLOSE V_CUR;
END;
/

--MAKER SP FOR EDIT


DECLARE
  V_CUR   SYS_REFCURSOR;
  V_FLAG  VARCHAR2(1);
  V_MSG   VARCHAR2(200);
BEGIN
  SAHIL_USP_SAVE_USERPROFILE;(
    P_TRNMODE   => 'EDIT',
    P_SYSUSERNO => 5,            -- EXISTING SYSUSERNO
    P_USERID    => 'USR001',
    P_FULLNAME  => 'Sahil V Thale',
    P_EMAIL     => 'sahil.new@test.com',
    P_PASSWORD  => 'newpass@123',
    P_AGE       => '26',
    P_PHONE     => '9999999999',
    P_GENDER    => 'M',
    P_ADDRESS   => 'Mumbai',
    P_CITY      => 'Mumbai',
    P_STATE     => 'MH',
    P_ZIPCODE   => '400001',
    P_CREATEDBY => 'MAKER2',
    P_CUROUTPUT => V_CUR
  );

  FETCH V_CUR INTO V_FLAG, V_MSG;
  DBMS_OUTPUT.PUT_LINE('FLAG = ' || V_FLAG || ' | MSG = ' || V_MSG);
  CLOSE V_CUR;
END;
/

-- AUTH SP FOR EDIT

DECLARE
  V_CUR   SYS_REFCURSOR;
  V_FLAG  VARCHAR2(1);
  V_MSG   VARCHAR2(200);
BEGIN
  SAHIL_USP_AUTHORISE_USERPROFILE(
    P_SYSTRNNO  => 2,       -- EDIT TRANSACTION SYSTRNNO
    P_ACTION    => 'A',
    P_REMARK    => NULL,
    P_CHECKER   => 'CHECKER2',
    P_CUROUTPUT => V_CUR
  );

  FETCH V_CUR INTO V_FLAG, V_MSG;
  DBMS_OUTPUT.PUT_LINE('FLAG = ' || V_FLAG || ' | MSG = ' || V_MSG);
  CLOSE V_CUR;
END;
/

