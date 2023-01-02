-- [X] View, In-Line View, TOP-N
-- 1. VIEW : 가상의 테이블 (1)단순뷰 (2)복합뷰

-- (1) 단순뷰 : 하나의 테이블을 이용하여 만든 뷰
-- 물리적인 저장공간과 데이터를 가지는 테이블
DROP TABLE EMP1;
CREATE TABLE EMP1 AS SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO FROM EMP;
SELECT * FROM EMP1;
INSERT INTO EMP1 (EMPNO, ENAME, JOB, DEPTNO) VALUES (1111, '홍', 'ITMANAGER', 40);
SELECT * FROM EMP1 WHERE EMPNO=1111;
SELECT * FROM USER_TABLES WHERE TABLE_NAME LIKE 'EMP%';
DROP TABLE EMP1;

-- 가상의 테이블 : 물리적인 저장공간과 데이터 X, 가상 테이블은 진짜 테이블을 이용하여 만들어야 함(서브쿼리)
CREATE OR REPLACE VIEW EMPv0
    AS SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO FROM EMP;
SELECT * FROM EMPv0;
SELECT * FROM USER_TABLES WHERE TABLE_NAME LIKE 'EMP%';     -- VIEW 는 진짜 테이블이 아니기에 안 보인다
SELECT * FROM USER_VIEWS;
DROP VIEW EMPv0;        -- VIEW는 DROP 하지 않아도 똑같은 이름으로 만들 수 있다
    -- ex. EMP테이블의 EMPNO, ENAME, JOB, DEPTNO 만 있는 가상의 테이블 뷰 EMPv0 만들기
CREATE OR REPLACE VIEW EMPv0
    AS SELECT EMPNO, ENAME, JOB, DEPTNO FROM EMP;
SELECT * FROM EMPv0;
INSERT INTO EMPv0 VALUES (1111, '홍', 'ITMANAGER', 40);  -- 테이블처럼 INSERT 해보기
SELECT * FROM EMP;      -- EMPv0(VIEW)에 INSERT 하였지만 EMP(TABLE)에도 INSERT 된다
UPDATE EMPv0 SET JOB='ANALYST' WHERE EMPNO=1111;    -- EMPv0의 필드를 변경해도 EMP의 필드도 변경된다
DELETE FROM EMPv0 WHERE EMPNO=1111;     -- 홍 삭제

    -- EMPv0(VIEW) = EMP의 30번 부서만 가져와서 만들기
CREATE OR REPLACE VIEW EMPv0
    AS SELECT * FROM EMP WHERE DEPTNO=30;
SELECT * FROM USER_VIEWS;
INSERT INTO EMPv0 VALUES (1111, '홍', NULL, NULL, SYSDATE, NULL, NULL, 40);      -- EMPv0은 30번 부서만 가져왔기에 40번부서는 EMP에 INSERT된다
SELECT * FROM EMPv0;
SELECT * FROM EMP;
DELETE FROM EMPv0 WHERE EMPNO=1111;     -- 30번 부서의 조건이 만족하는 행만 DELETE가 된다
DELETE FROM EMP WHERE EMPNO=1111;    
    -- 단순뷰에서 INSERT 가 불가한 경우 : 뷰 생성시 NOT NULL 필드를 미포함한 경우
CREATE OR REPLACE VIEW EMPv0 AS SELECT ENAME, JOB FROM EMP;
INSERT INTO ENMv0 VALUES ('홍', 'MANAGER');  -- PRIMARY KEY인 EMPNO가 미 호함이므로 INSERT 불가
SELECT * FROM EMP;
COMMIT;
-- VIEW의 제한 조건
-- WITH CHECK OPTION 추가 : 뷰의 조건에 해당되는 데이터만 삽입, 수정, 삭제가 가능
    -- ex. EMP테이블의 30번 부서의 가상의 테이블(30번만 DML가능)
CREATE OR REPLACE VIEW EMPv0
    AS SELECT * FROM EMP WHERE DEPTNO=30
    WITH CHECK OPTION;
INSERT INTO EMPv0 (EMPNO, ENAME, DEPTNO) VALUES (1111, '홍', 30);
INSERT INTO EMPv0 (EMPNO, ENAME, DEPTNO) VALUES (1112, '홍', 40);    -- WITH CHECK OPTION 을 했기에 40번 부서는 INSERT 불가
SELECT * FROM EMP WHERE ENAME='SMITH';
DELETE FROM EMPvO WHERE ENAME='SMITH';  -- SMITH가 20번 부서이기에 DELETE도 불가
-- WITH READ ONLY 추가 : 읽기 전용 뷰
CREATE OR REPLACE VIEW EMPv0   
    AS SELECT * FROM EMP WHERE DEPTNO=20 WITH READ ONLY;
INSERT INTO EMPv0 (EMPNO, ENAME, DEPTNO) VALUES (1113, '홍', 20);    -- READ ONLY라 INSERT 불가

-- (2) 복합뷰 : 2개 이상의 테이블로 구성한 뷰, 가상의 필드를 이용한 경우. DML문을 제한적으로만 사용
-- ① 2개 이상의 테이블로 구성한 뷰
CREATE OR REPLACE VIEW EMPv0
    AS SELECT EMPNO, ENAME, JOB, DNAME FROM DEPT D, EMP E WHERE E.DEPTNO=D.DEPTNO;
SELECT * FROM EMPv0;
INSERT INTO EMPv0 VALUES (1112, 'HONG', 'MANAGER', 'SALES');
-- ② 가상의 필드를 이용한 경우 (컬럼에 별칭을 사용)
CREATE OR REPLACE VIEW EMPv0        -- 별칭 사용 : 생성 가능
    AS SELECT EMPNO, ENAME, SAL*12 YEAR_SAL FROM EMP WHERE DEPTNO=10;
SELECT * FROM EMPv0;
INSERT INTO EMPv0 VALUES (1113, 'HONG', 12000);    

CREATE OR REPLACE VIEW EMPv0        -- 별칭 X : 생성 X
    AS SELECT EMPNO, ENAME, SAL*12 FROM EMP WHERE DEPTNO=10;

    -- ex1. 사번, 이름, 급여, 10의 자리에서 반올림한 급여를 뷰로 생성
CREATE OR REPLACE VIEW EMPv0
    AS SELECT EMPNO, ENAME, SAL, ROUND(SAL, -2) SAL2 FROM EMP;
    
    -- ex2. 중복이 제거된 JOB, DEPTNO를 뷰로 생성
CREATE OR REPLACE VIEW EMPv0
    AS SELECT DISTINCT JOB, DEPTNO FROM EMP;
SELECT * FROM EMPv0;

    -- ex3. 부서번호, 최소급여, 최대급여, 부서평균급여를 포함한 EMPv0 뷰를 생성
CREATE OR REPLACE VIEW EMPv0 (DNO, MINSAL, MAXSAL, AVGSAL)
    AS SELECT DEPTNO, MIN(SAL), MAX(SAL), AVG(SAL) FROM EMP GROUP BY DEPTNO;
    
    -- ex4. 부서명 최소급여 최대급여 평균급여를 포함한 DEPTv0 뷰를 생성
CREATE OR REPLACE VIEW DEPTv0 (DNAME, MANSAL, MAXSAL, AVGSAL)
    AS SELECT DNAME, MIN(SAL), MAX(SAL), AVG(SAL) FROM EMP E, DEPT D
    WHERE E.DEPTNO=D.DEPTNO GROUP BY DNAME;
SELECT * FROM DEPTv0;

-- 2. INLINE_VIEW (FROM절에 오는 SUB QUERY) FROM 절에 오는 서브쿼리는 VIEW처럼 작용
    -- 문법 : SELECT 필드 FROM 테이블, (서브쿼리) 별칭
--             WHERE 조인 조건

    -- ex. 급여가 2000을 초과하는 사원의 평균 급여
SELECT AVG(SAL) FROM EMP WHERE SAL>2000;
SELECT AVG(SAL) FROM (SELECT SAL FROM EMP WHERE SAL>2000) A;

    -- ex2. 부서별 평균 월급보다 높은 사원을 사번, 이름, 급여, 부서번호, 부서평균
SELECT  EMPNO, ENAME, E.DEPTNO, ROUND(AVGSAL)
    FROM EMP E, (SELECT DEPTNO, AVG(SAL) AVGSAL FROM EMP GROUP BY DEPTNO) A
    WHERE E.DEPTNO=A.DEPTNO AND SAL>AVGSAL;


-- 3. TOP-N 구문 (1~10등, 11~20등 ..)
-- 함수를 이용한 RANK 출력(1~꼴등)
SELECT ENAME, RANK() OVER(ORDER BY SAL DESC) RANK,
        DENSE_RANK() OVER(ORDER BY SAL DESC) DENSE_RANK,
        ROW_NUMBER() OVER(ORDER BY SAL DESC) ROW_NUMBER
        FROM EMP;
-- ROWNUM(테이블로부터 가져온 순서), INLINE-VIEW를 이용한 TOP-N