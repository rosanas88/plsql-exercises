"# plsql-exercises"  

#Download and Install oracle 11g Xe
#Create a User and Datbase Connections (https://docs.oracle.com/cd/E17781_01/admin.112/e18585/toc.htm#XEGSG114)
#Downloand and Install Sql Developer

#Create a table

  CREATE TABLE "FUNCIONARIO" 
   (	"ID" NUMBER(38,0), 
	    "NOME" VARCHAR2(200 BYTE), 
	    "SALARIO" NUMBER(14,2), 
	    PRIMARY KEY ("ID")
   );

/ 

#Create a sequence to generate id

CREATE SEQUENCE S_FUNCIONARIO"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 31 CACHE 10 NOORDER  NOCYCLE;


#Create a trigger to update PK "id" calling the sequence

create or replace TRIGGER FUNCIONARIO_TRG
BEFORE INSERT ON  FUNCIONARIO
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN 
if(:new.ID is null) then SELECT S_FUNCIONARIO.nextval INTO :new.ID FROM dual; end if;
END;


/
ALTER TRIGGER "ROSANA"."FUNCIONARIO_TRG" ENABLE;
