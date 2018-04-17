CREATE OR REPLACE package asserts as 
  
  procedure assert(condition in boolean, proc in char, message in char);
  
  procedure assertEquals(expected in CHAR, actual in CHAR, proc in char);
  
END ASSERTS;
/


CREATE OR REPLACE PACKAGE BODY ASSERTS AS 

  PROCEDURE raiseError(proc IN CHAR, message IN CHAR) IS 
  BEGIN
    
    raise_application_error(-20000, 'Error in ' || proc || ': ' || message);
  end raiseerror;
 
  procedure assert(  
    condition in boolean, 
    proc in char, 
    message in char) is
  begin
    if not condition then
      raiseError(proc, message);
    END IF;
  end assert;  
 
  procedure assertEquals(
    expected in char,
    actual in char,
    proc in char) is
  BEGIN
    if not expected like actual then
      raiseError(proc, 'expected ' || expected || ', got ' || actual);
    END IF;
  end assertEquals;
  
END ASSERTS;
/
show error;