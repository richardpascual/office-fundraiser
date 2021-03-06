-- DDL Script for office-fundraiser project

DROP TABLE "FUNDRAISER" CASCADE CONSTRAINTS PURGE;
DROP TABLE "FUND_PEOPLE" CASCADE CONSTRAINTS PURGE;
DROP TABLE "FUND_PLEDGE" CASCADE CONSTRAINTS PURGE;
DROP TABLE "FUND_PAYMENT" CASCADE CONSTRAINTS PURGE;

DROP SEQUENCE "FUNDRAISER_SEQ";
DROP SEQUENCE "FUND_PEOPLE_SEQ";
DROP SEQUENCE "FUND_PLEDGE_SEQ";
DROP SEQUENCE "FUND_PAYMENT_SEQ";

CREATE SEQUENCE   "FUNDRAISER_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;

CREATE SEQUENCE   "FUND_PEOPLE_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;

CREATE SEQUENCE   "FUND_PLEDGE_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;

CREATE SEQUENCE   "FUND_PAYMENT_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;



CREATE TABLE  "FUNDRAISER" 
   (	"FUND_ID" NUMBER NOT NULL ENABLE, 
	"FUND_TITLE" VARCHAR2(250) NOT NULL ENABLE, 
	"START_DATE" DATE NOT NULL ENABLE, 
	"END_DATE" DATE, 
	 CONSTRAINT "FUNDRAISER_PK" PRIMARY KEY ("FUND_ID") ENABLE
   ) ;


CREATE OR REPLACE TRIGGER  "BI_FUNDRAISER" 
  before insert on "FUNDRAISER"               
  for each row  
begin   
  if :NEW."FUND_ID" is null then 
    select "FUNDRAISER_SEQ".nextval into :NEW."FUND_ID" from dual; 
  end if; 
end; 

/
ALTER TRIGGER  "BI_FUNDRAISER" ENABLE;

CREATE TABLE  "FUND_PEOPLE" 
   (	"PERSON_ID" NUMBER NOT NULL ENABLE, 
	"ANONYMOUS_IND" VARCHAR2(1) NOT NULL ENABLE, 
	"ALIAS_IND" VARCHAR2(1) NOT NULL ENABLE, 
	"ALIAS_NAME" VARCHAR2(50), 
	"FIRST_NAME" VARCHAR2(50), 
	"LAST_NAME" VARCHAR2(50), 
	"PHONE_NUMBER" VARCHAR2(20), 
	"EMAIL_ADDRESS" VARCHAR2(100), 
	 CONSTRAINT "FUND_PEOPLE_PK" PRIMARY KEY ("PERSON_ID") ENABLE
   ) ;


CREATE OR REPLACE TRIGGER  "BI_FUND_PEOPLE" 
  before insert on "FUND_PEOPLE"               
  for each row  
begin   
  if :NEW."PERSON_ID" is null then 
    select "FUND_PEOPLE_SEQ".nextval into :NEW."PERSON_ID" from dual; 
  end if; 
end; 

/
ALTER TRIGGER  "BI_FUND_PEOPLE" ENABLE;

CREATE TABLE  "FUND_PLEDGE" 
   (	"PLEDGE_ID" NUMBER NOT NULL ENABLE, 
	"PLEDGE_DATE" DATE NOT NULL ENABLE, 
	"AMOUNT" NUMBER NOT NULL ENABLE, 
	"PERSON_ID" NUMBER NOT NULL ENABLE, 
	"FUND_ID" NUMBER NOT NULL ENABLE, 
	"PAID_IND" VARCHAR2(1) NOT NULL ENABLE, 
	 CONSTRAINT "FUND_PLEDGE_PK" PRIMARY KEY ("PLEDGE_ID") ENABLE
   ) ;

   
ALTER TABLE  "FUND_PLEDGE" ADD CONSTRAINT "FUND_PLEDGE_FK" FOREIGN KEY ("PERSON_ID")
	  REFERENCES  "FUND_PEOPLE" ("PERSON_ID") ON DELETE CASCADE ENABLE;
ALTER TABLE  "FUND_PLEDGE" ADD CONSTRAINT "FUND_PLEDGE_FK1" FOREIGN KEY ("FUND_ID")
	  REFERENCES  "FUNDRAISER" ("FUND_ID") ON DELETE CASCADE ENABLE;


CREATE OR REPLACE TRIGGER  "BI_FUND_PLEDGE" 
  before insert on "FUND_PLEDGE"               
  for each row  
begin   
  if :NEW."PLEDGE_ID" is null then 
    select "FUND_PLEDGE_SEQ".nextval into :NEW."PLEDGE_ID" from dual; 
  end if; 
end; 

/
ALTER TRIGGER  "BI_FUND_PLEDGE" ENABLE;

CREATE TABLE  "FUND_PAYMENT" 
   (	"PAYMENT_ID" NUMBER NOT NULL ENABLE, 
	"PAYMENT_DATE" DATE NOT NULL ENABLE, 
	"PLEDGE_ID" NUMBER, 
	"AMOUNT_COLLECTED" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "FUND_PAYMENT_PK" PRIMARY KEY ("PAYMENT_ID") ENABLE
   ) ;
   

ALTER TABLE  "FUND_PAYMENT" ADD CONSTRAINT "FUND_PAYMENT_FK" FOREIGN KEY ("PLEDGE_ID")
	  REFERENCES  "FUND_PLEDGE" ("PLEDGE_ID") ON DELETE CASCADE ENABLE;


CREATE OR REPLACE TRIGGER  "BI_FUND_PAYMENT" 
  before insert on "FUND_PAYMENT"               
  for each row  
begin   
  if :NEW."PAYMENT_ID" is null then 
    select "FUND_PAYMENT_SEQ".nextval into :NEW."PAYMENT_ID" from dual; 
  end if; 
end; 

/
ALTER TRIGGER  "BI_FUND_PAYMENT" ENABLE;


		


