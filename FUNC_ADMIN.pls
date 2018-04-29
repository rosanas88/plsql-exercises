create or replace PACKAGE BODY func_admin AS
    
   /**
   * Exercises with Loop
   **/
    PROCEDURE HIRE_FUNC
        AS
    BEGIN
        FOR i IN 1..5 LOOP
            -- insert with subselect
            INSERT INTO FUNCIONARIO (NOME, SALARIO) SELECT DBMS_RANDOM.STRING('A', 20), TRUNC(DBMS_RANDOM.VALUE(100, 500)) FROM DUAL FIRST;
        END LOOP;
    END HIRE_FUNC;
    
 
   /**
   * Exercises with explicit cursor
   **/
   PROCEDURE FIRE_FUNC IS
   func_id NUMBER(38);
   
    CURSOR SALARIOS IS
            SELECT ID
             FROM FUNCIONARIO
        ORDER BY SALARIO DESC;
   
    BEGIN
       OPEN SALARIOS;
         LOOP 
           FETCH SALARIOS INTO func_id;
           DBMS_OUTPUT.PUT_LINE(func_id);
           EXIT WHEN func_id > 0;
           END LOOP;
       CLOSE SALARIOS;
      DELETE FROM FUNCIONARIO WHERE ID = func_id;
      DBMS_OUTPUT.PUT_LINE(func_id);
   END FIRE_FUNC;
   
   -- Define local function, available only inside package
   FUNCTION sal_ok (funcId NUMBER, sal NUMBER) RETURN BOOLEAN IS
      min_sal NUMBER;
      max_sal NUMBER;
   BEGIN
      SELECT MIN(SALARIO), MAX(SALARIO)
        INTO min_sal, max_sal
        FROM FUNCIONARIO
        WHERE ID = funcId;
      RETURN (sal >= min_sal) AND (sal <= max_sal);
   END sal_ok;
   
   
  /**
   * Exercises with custom exceptions and called local function
   **/ 
  PROCEDURE raise_salary (amount NUMBER) IS
      sal NUMBER(14,2);
      funcId NUMBER(38);
   BEGIN
      SELECT id, salario INTO funcId, sal
        FROM funcionario
        WHERE id BETWEEN 1 and 10;
        
      IF sal_ok(funcId, sal + amount) THEN
         UPDATE FUNCIONARIO SET SALARIO = sal + amount WHERE id = funcId;
      ELSE
         RAISE invalid_salary;
      END IF;
   EXCEPTION  -- exception-handling part starts here
     WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE
         ('The salary is out of the specified range.');
   END raise_salary;


END func_admin;