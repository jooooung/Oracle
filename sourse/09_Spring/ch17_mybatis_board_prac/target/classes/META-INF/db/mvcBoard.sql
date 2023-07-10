DROP TABLE MVCBOARD2;
DROP SEQUENCE MVCBOARD2_SEQ;
CREATE TABLE MVCBOARD2(
  bID   NUMBER(6) PRIMARY KEY,
  bNAME VARCHAR2(50) NOT NULL,
  bTITLE VARCHAR2(100) NOT NULL,
  bCONTENT VARCHAR2(1000),
  bDATE    DATE DEFAULT SYSDATE NOT NULL, -- 작성일
  bHIT     NUMBER(6) DEFAULT 0 NOT NULL,  -- 조회수
  bGROUP   NUMBER(6) NOT NULL, -- 원글이면 BID와 같고, 답변글의 경우 원글의 BGROUP과 같다
  bSTEP    NUMBER(3) NOT NULL, -- 같은 그룹내 출력 순서
  bINDENT  NUMBER(3) NOT NULL, -- 들여쓰기 정도
  bIP      VARCHAR2(20)
);
CREATE SEQUENCE MVCBOARD2_SEQ MAXVALUE 999999 NOCACHE NOCYCLE;

-- 글목록
SELECT * 
    FROM (SELECT ROWNUM RN, A.* 
        FROM (SELECT * FROM MVCBOARD2 ORDER BY BGROUP DESC, BSTEP, BID DESC) A)
        WHERE RN BETWEEN 1 AND 5;
-- 전체글개수
SELECT COUNT(*) FROM MVCBOARD2;
-- 글 상세보기
SELECT * FROM MVCBOARD2 WHERE BID = 1;
-- 조회수 올리기
UPDATE MVCBOARD2 SET BHIT = BHIT + 1
    WHERE BID = 1;
-- 글쓰기
INSERT INTO MVCBOARD2 (BID, BNAME, BTITLE, BCONTENT, BGROUP, BSTEP, BINDENT, BIP)
 VALUES (MVCBOARD2_SEQ.NEXTVAL, '홍길','제목', NULL, MVCBOARD2_SEQ.CURRVAL, 0,0,'192.1.1.1');
-- 답글 전 작업
UPDATE MVCBOARD2 SET BSTEP = BSTEP + 1
    WHERE BGROUP = 1 AND BSTEP > 0;
-- 답글쓰기
INSERT INTO MVCBOARD2 (BID, BNAME, BTITLE, BCONTENT, BGROUP, BSTEP, BINDENT, BIP)
 VALUES (MVCBOARD2_SEQ.NEXTVAL, '홍','답제목', NULL, 1, 1,1,'192.1.1.1');
-- 글수정
UPDATE MVCBOARD2 SET BTITLE = '제목',
    BCONTENT = 'SS',
    BIP = '192.1.1.2'
    WHERE BID = 2;
-- 글삭제
DELETE FROM MVCBOARD2 WHERE BID = 3;
COMMIT;
