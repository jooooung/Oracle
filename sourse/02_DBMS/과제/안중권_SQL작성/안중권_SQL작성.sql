﻿DROP TABLE MEMBER;
DROP TABLE MEMBER_LEVEL;

CREATE TABLE MEMBER_LEVEL(
    LEVELNO NUMBER(1) PRIMARY KEY,
    LEVELNAME VARCHAR2(10) NOT NULL
);
SELECT * FROM MEMBER_LEVEL;
INSERT INTO MEMBER_LEVEL VALUES (-1, 'black');
INSERT INTO MEMBER_LEVEL VALUES (0, '일반');
INSERT INTO MEMBER_LEVEL VALUES (1, '실버');
INSERT INTO MEMBER_LEVEL VALUES (2, '골드');
SELECT * FROM MEMBER_LEVEL;

CREATE TABLE MEMBER (
    mNO NUMBER(2) PRIMARY KEY,
    mNAME VARCHAR2(15) NOT NULL,
    mPW VARCHAR2(15) CHECK(LENGTH(mPW)>=1 AND LENGTH(mPW)<=8),
    mEMAIL VARCHAR2(200),
    mPOINT NUMBER(38) CHECK(mPOINT>=0),
    mRDATE DATE DEFAULT SYSDATE,
    LEVELNO NUMBER(1),
    FOREIGN KEY (LEVELNO) REFERENCES MEMBER_LEVEL(LEVELNO),
    UNIQUE(mEMAIL)
);
SELECT * FROM MEMBER;
DROP SEQUENCE MEMBER_SEQ;
CREATE SEQUENCE MEMBER_SEQ 
    START WITH 1
    MAXVALUE 99
    NOCACHE
    NOCYCLE;

INSERT INTO MEMBER 
    VALUES (MEMBER_SEQ.NEXTVAL, '홍길동', 'aa', 'hong@hong.com', 0, '22/03/10', 0);
INSERT INTO MEMBER 
    VALUES (MEMBER_SEQ.NEXTVAL, '신길동', 'bb', 'sin@sin.com', 1000, '22/04/01', 1); 
SELECT mNO, mNAME, mEMAIL mMAIL, mPOINT point, LEVELNAME|| '고객' levelname 
    FROM MEMBER M, MEMBER_LEVEL L
    WHERE M.LEVELNO=L.LEVELNO;