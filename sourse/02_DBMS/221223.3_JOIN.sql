﻿-- [ III ] JOIN : 2개 이상의 테이블을 연결하여 데이터를 검색하는 방법
SELECT * FROM EMP 
    WHERE ENAME = 'SCOTT';
SELECT * FROM DEPT;

-- CROSS JOIN (FROM 절에 테이블을 2개 이상)
SELECT * FROM EMP, DEPT WHERE ENAME = 'SCOTT'; --1(EMP테이블의 개수)*4(DEPT테이블 개수)

SELECT * FROM EMP WHERE ENAME = 'SCOTT';  
SELECT * FROM SALGRADE;
SELECT * FROM EMP, SALGRADE WHERE ENAME = 'SCOTT';

-- SELF JOIN
SELECT * FROM EMP WHERE ENAME = 'SCOTT';

-- ★ 1. EQUI JOIN(공통 필드인 DEPTNO값이 일치되는 조건만 JOIN) ★

SELECT * FROM EMP, DEPT 
    WHERE ENAME = 'SCOTT' AND EMP.DEPTNO = DEPT.DEPTNO;  --DEPTNO가 두번 출력됨
    
    -- ex. 모든 사원의 사번 이름 직책 상사사번 부서번호 부서이름 근무지
SELECT EMPNO, ENAME, JOB, MGR, EMP.DEPTNO, DNAME, LOC 
    FROM EMP, DEPT 
    WHERE EMP.DEPTNO = DEPT.DEPTNO;
    
SELECT EMPNO, ENAME, JOB, MGR, E.DEPTNO, DNAME, LOC 
    FROM EMP E, DEPT D 
    WHERE E.DEPTNO = D.DEPTNO;       --EQUI JOIN 완성본
    
    -- ex1. 급여가 2000이상인 직원만 이름, 직책, 급여, 부서명, 근무지 출력
SELECT ENAME, JOB, SAL, DNAME, LOC
    FROM EMP E, DEPT D 
    WHERE E.DEPTNO = D.DEPTNO
    AND SAL >= 2000;
    
    -- ex2. 20번 부서의 직원만 이름 부서번호 근무지 출력
SELECT ENAME, E.DEPTNO, LOC 
    FROM EMP E, DEPT D 
    WHERE E.DEPTNO = D.DEPTNO
    AND E.DEPTNO = 20;
    
    -- ex3. LOC이 CHOCAGO인 사람의 이름 업무 급여 부서명 근무지를 출력
SELECT ENAME, JOB, SAL, DNAME, LOC      --만약 겹치는 것이 있다면 별칭을 해줘야 함
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO AND LOC='CHICAGO';      --JOIN 후 조건문
    
    -- ex4. DEPTNO가 10이거나 20인 사원의 이름 업무 근무지를 출력(급여순)
SELECT ENAME, JOB, LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO AND E.DEPTNO IN (10, 20) ORDER BY SAL;
    
    -- ex5. JOB이 SALESMAN 이거나 MANAGER인 사원의 이름 급여 상여금 연봉((SAL+COM)*12) 부서명 근무지를 출력(연봉이 큰 순으로 정렬)
SELECT ENAME, SAL, COMM, (SAL+NVL(COMM, 0)*12) ANNUALSAL, DNAME, LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO AND JOB IN ('SALESMAN', 'MANAGER')
    ORDER BY ANNUALSAL DESC;
    
    -- ex6. COMM이 NULL이고 SAL이 1200이상인 사원의 이름 급여 입사일 부서번호 부서명 출력(부서명 순, 급여 큰 순 정렬)
SELECT ENAME, SAL, HIREDATE, D.DEPTNO, DNAME 
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO AND COMM IS NULL AND SAL >=1200
    ORDER BY DNAME, SAL DESC;
    
    -- ex7. NEW YORK에서 근무하는 사원의 이름과 급여를 출력하시오
SELECT ENAME, SAL 
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO AND LOC = 'NEW YORK';
    
    -- ex8. ACCOUNTING 부서 소속 사원의 이름과 입사일을 출력하시오
SELECT ENAME, HIREDATE
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO AND DNAME = 'ACCOUNTING';
    
    -- ex9. 직급이 MANAGER인 사원의 이름, 부서명을 출력하시오
SELECT ENAME, DNAME
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO AND JOB = 'MANAGER';
    
    -- ex10. Comm이 null이 아닌 사원의 이름, 급여, 부서코드, 근무지를 출력하시오.
SELECT ENAME, SAL, D.DEPTNO, LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO AND NOT COMM IS NULL;
    
-- ★2.NON-EQUI JOIN★

SELECT * FROM EMP WHERE ENAME = 'SCOTT';
SELECT * FROM SALGRADE;
SELECT * FROM EMP, SALGRADE WHERE ENAME = 'SCOTT'; --CROSS JOIN
SELECT * FROM EMP, SALGRADE 
    WHERE SAL BETWEEN LOSAL AND HISAL AND ENAME = 'SCOTT'; -- NON-EQEUI JOIN
    
    -- ex11. 모든 사원의 사번, 이름, 직책, 상사사번, 급여, 급여등급(1등급, 2등급...)
SELECT EMPNO, ENAME, JOB, MGR, SAL, GRADE||'등급' GRADE
    FROM EMP, SALGRADE
    WHERE SAL BETWEEN LOSAL AND HISAL;
    
    -- 탄탄ex1. Comm이 null이 아닌 사원의 이름, 급여, 등급, 부서번호, 부서이름, 근무지를 출력하시오.
SELECT ENAME, SAL, GRADE, E.DEPTNO, DNAME, LOC
    FROM EMP E, DEPT D, SALGRADE
    WHERE E.DEPTNO = D.DEPTNO AND SAL BETWEEN LOSAL AND HISAL 
    AND NOT COMM IS NULL;
    
    -- 탄탄ex2. 이름, 급여, 입사일, 급여등급
SELECT ENAME, SAL, HIREDATE, GRADE
    FROM EMP, SALGRADE 
    WHERE SAL BETWEEN LOSAL AND HISAL;
    
    -- 탄탄ex3. 이름, 급여, 입사일, 급여등급, 부서명, 근무지
SELECT ENAME, SAL, HIREDATE, GRADE, DNAME, LOC
    FROM EMP E, DEPT D, SALGRADE
    WHERE E.DEPTNO = D.DEPTNO AND SAL BETWEEN LOSAL AND HISAL;
    
    -- 탄탄ex4. 이름, 급여, 등급, 부서코드, 근무지. 단 comm 이 null아닌 경우
SELECT ENAME, SAL, GRADE, E.DEPTNO, LOC
    FROM EMP E, DEPT D, SALGRADE
    WHERE E.DEPTNO = D.DEPTNO AND SAL BETWEEN LOSAL AND HISAL AND NOT COMM IS NULL;
    
    -- 탄탄ex5. 이름, 급여, 급여등급, 연봉, 부서명, 부서별 출력, 부서가 같으면 연봉순. 연봉=(sal+comm)*12 comm이 null이면 0
SELECT ENAME, SAL, GRADE, SAL*12+NVL(COMM, 0) ANNUALSAL , DNAME
    FROM EMP E, DEPT D, SALGRADE
    WHERE E.DEPTNO = D.DEPTNO AND SAL BETWEEN LOSAL AND HISAL 
    ORDER BY DNAME, ANNUALSAL;
    
    -- 탄탄ex6. 이름, 업무, 급여, 등급, 부서코드, 부서명 출력. 급여가 1000~3000사이. 정렬조건 : 부서별, 부서같으면 업무별, 업무같으면 급여 큰순
SELECT ENAME, JOB, SAL, GRADE, D.DEPTNO, DNAME
    FROM EMP E, DEPT D, SALGRADE
    WHERE E.DEPTNO = D.DEPTNO AND SAL BETWEEN LOSAL AND HISAL
    AND SAL BETWEEN 1000 AND 3000 ORDER BY DNAME, JOB, SAL DESC;
    
    -- 탄탄ex7. 이름, 급여, 등급, 입사일, 근무지. 81년에 입사한 사람. 등급 큰순
SELECT ENAME, SAL, GRADE, HIREDATE, LOC
    FROM EMP E, DEPT D, SALGRADE
    WHERE E.DEPTNO = D.DEPTNO AND SAL BETWEEN LOSAL AND HISAL
        AND TO_CHAR(HIREDATE, 'YY') = '81' 
    ORDER BY GRADE DESC;
    
-- ★3.SELF-JOIN★

SELECT EMPNO, ENAME, MGR FROM EMP WHERE ENAME = 'SMITH';
SELECT EMPNO, ENAME FROM EMP WHERE EMPNO = 7902;
SELECT WORKER.EMPNO, WORKER.ENAME, WORKER.MGR, MANAGER.EMPNO, MANAGER.ENAME 
    FROM EMP WORKER, EMP MANAGER
    WHERE WORKER.ENAME = 'SMITH' AND WORKER.MGR = MANAGER.EMPNO;
    -- ex1. 모든 사원의 사번, 이름, 상사의 사번, 이름
SELECT W.EMPNO, W.ENAME, M.EMPNO, M.ENAME
    FROM EMP W, EMP M
    WHERE W.MGR = M.EMPNO;  --KING의 MGR이 NULL이라 생략
DESC EMP;

    -- ex2. 'SMITH의 상사는 FORD다' 포맷으로 출력
SELECT W.ENAME || '의 상사는 ' || M.ENAME || '다' MESSAGE
    FROM EMP W, EMP M
    WHERE W.MGR = M.EMPNO;
    
    -- 탄탄ex1. 매니저가 KING인 사원들의 이름과 직급을 출력하시오.
SELECT WORKER.ENAME, WORKER.JOB
    FROM EMP WORKER, EMP MANAGER
    WHERE WORKER.MGR=MANAGER.EMPNO AND MANAGER.ENAME='KING';
    
    -- 탄탄ex2. SCOTT과 동일한 부서번호에서 근무하는 사원의 이름을 출력하시오
SELECT M.ENAME
    FROM EMP W, EMP M  
    WHERE W.ENAME = 'SCOTT' AND W.DEPTNO = M.DEPTNO AND M.ENAME <> 'SCOTT';
    
    -- 탄탄ex3. SCOTT과 동일한 근무지에서 근무하는 사원의 이름을 출력하시오(2단계 최종문제)
SELECT * FROM EMP WHERE ENAME = 'SCOTT';
SELECT * FROM DEPT;
INSERT INTO DEPT VALUES (50, 'IT', 'DALLAS');
INSERT INTO EMP VALUES (9999, '홍', NULL, NULL, NULL, 6000, NULL, 50);

SELECT E2.ENAME
    FROM EMP E1, DEPT D1, EMP E2, DEPT D2
    WHERE E1.DEPTNO = D1.DEPTNO AND E2.DEPTNO = D2.DEPTNO
        AND E1.ENAME = 'SCOTT' AND D1.LOC = D2.LOC AND E2.ENAME <> 'SCOTT';
        
-- 홍데이터, 50번 부서 데이터 원상복귀(삭제)
ROLLBACK;
SELECT * FROM EMP;

-- ★4.OUTER-JOIN★  EQUI & SELF JOIN 조건에 만족하지 않는 행도 나타나는 조인
-- (1) SELP JOIN에서의 OUTER JOIN
SELECT W.ENAME, W.MGR, M.EMPNO, M.ENAME
    FROM EMP W, EMP M
    WHERE W.MGR = M.EMPNO(+);
    
    -- ex. 'SMITH의 상사는 FORD'  'KING의 상사는 없다'
SELECT W.ENAME || '의 상사는' || NVL(M.ENAME, '없다')
    FROM EMP W, EMP M
    WHERE W.MGR = M.EMPNO(+);

    -- ex. 말단 사원 출력(상사가 아닌 사원)
SELECT M.EMPNO, M.ENAME
    FROM EMP W, EMP M
    WHERE W.MGR(+) = M.EMPNO AND W.ENAME IS NULL;
    
-- (2) EQUI JOIN에서의 OUTER JOIN
SELECT * FROM EMP;  -- 14행
SELECT * FROM DEPT; -- 4행
SELECT * FROM EMP E, DEPT D WHERE E.DEPTNO = D.DEPTNO;  -- 40번 부서가 출력 안됨
SELECT * FROM EMP E, DEPT D WHERE E.DEPTNO(+) = D.DEPTNO; 

-- ★ <연습문제> PART1
--1. 이름, 직속상사명
SELECT E1.ENAME, E2.ENAME MGR
    FROM EMP E1, EMP E2
    WHERE E1.MGR = E2.EMPNO;
    
--2. 이름, 급여, 업무, 직속상사명
SELECT E1.ENAME, E1.SAL, E1.JOB, E2.ENAME MGR
    FROM EMP E1, EMP E2
    WHERE E1.MGR = E2.EMPNO;
    
--3. 이름, 급여, 업무, 직속상사명 . (상사가 없는 직원까지 전체 직원 다 출력.
    --상사가 없을 시 '없음'으로 출력)
SELECT E1.ENAME, E1.SAL, E1.JOB, NVL(E2.ENAME, '없다') MGR
    FROM EMP E1, EMP E2
    WHERE E1.MGR = E2.EMPNO(+);    

--4. 이름, 급여, 부서명, 직속상사명
SELECT E1.ENAME, E1.SAL, D1.DNAME, E2.ENAME MGR
    FROM EMP E1, DEPT D1, EMP E2
    WHERE E1.DEPTNO = D1.DEPTNO AND E1.MGR = E2.EMPNO; 

--5. 이름, 급여, 부서코드, 부서명, 근무지, 직속상사명, (상사가 없는 직원까지 전체 직원 다 출력)
SELECT E1.ENAME, E1.SAL, E1.DEPTNO, D1.DNAME, LOC, NVL(E2.ENAME, '없다') MGR
    FROM EMP E1, DEPT D1, EMP E2
    WHERE E1.DEPTNO = D1.DEPTNO AND E1.MGR = E2.EMPNO(+);                                         
    
--6. 이름, 급여, 등급, 부서명, 직속상사명. 급여가 2000이상인 사람
SELECT W.ENAME, W.SAL, GRADE, DNAME, M.ENAME MANAGER
    FROM EMP W, SALGRADE, DEPT D, EMP M
    WHERE W.SAL BETWEEN LOSAL AND HISAL AND W.DEPTNO=D.DEPTNO AND W.MGR=M.EMPNO
        AND W.SAL >= 2000;

--7. 이름, 급여, 등급, 부서명, 직속상사명, (직속상사가 없는 직원까지 전체직원 부서명 순 정렬)
SELECT E1.ENAME, E1.SAL, GRADE, D1.DNAME, NVL(E2.ENAME, '없다') MGR
    FROM EMP E1, DEPT D1, SALGRADE, EMP E2
    WHERE E1.DEPTNO = D1.DEPTNO 
        AND E1.SAL BETWEEN LOSAL AND HISAL
        AND E1.MGR = E2.EMPNO(+) ORDER BY D1.DNAME;                       
        
--8. 이름, 급여, 등급, 부서명, 연봉, 직속상사명. 연봉=(급여+comm)*12 단 comm이 null이면 0
SELECT W.ENAME, W.SAL, GRADE, D.DNAME, W.SAL*12+NVL(W.COMM, 0) ANNUALSAL, M.ENAME MGR
    FROM EMP W, DEPT D, SALGRADE, EMP M
    WHERE W.MGR = M.EMPNO AND W.DEPTNO = D.DEPTNO
        AND W.SAL BETWEEN LOSAL AND HISAL;
        
--9. 8번을 부서명 순 부서가 같으면 급여가 큰 순 정렬
SELECT W.ENAME, W.SAL, GRADE, DNAME, (W.SAL+NVL(W.COMM, 0))*12 ANNUALSAL, M.ENAME MANAGER
    FROM EMP W, EMP M, SALGRADE, DEPT D
    WHERE W.MGR=M.EMPNO AND W.SAL BETWEEN LOSAL AND HISAL AND W.DEPTNO=D.DEPTNO
    ORDER BY DNAME, W.SAL DESC; -- ORDER BY DNAME, SAL DESC도 가능 
        
--  PART2
--1.EMP 테이블에서 모든 사원에 대한 이름, 부서번호, 부서명을 출력하는 SELECT 문장을 작성하여라.
SELECT ENAME, E.DEPTNO, D.DNAME
    FROM EMP E, DEPT D WHERE E.DEPTNO = D.DEPTNO;
    
--2. EMP 테이블에서 NEW YORK에서 근무하고 있는 사원에 대하여 이름, 업무, 급여, 부서명을 출력
SELECT ENAME, E.JOB, E.SAL, D.DNAME
    FROM EMP E, DEPT D WHERE E.DEPTNO = D.DEPTNO AND LOC = 'NEW YORK';
    
--3. EMP 테이블에서 보너스를 받는 사원에 대하여 이름,부서명,위치를 출력
SELECT ENAME, DNAME, LOC
    FROM EMP E, DEPT D WHERE E.DEPTNO = D.DEPTNO AND COMM > 0;

--4. EMP 테이블에서 이름 중 L자가 있는 사원에 대하여 이름,업무,부서명,위치를 출력
SELECT ENAME, JOB, DNAME, LOC
    FROM EMP E, DEPT D WHERE E.DEPTNO = D.DEPTNO AND ENAME LIKE '%L%';

--5. 사번, 사원명, 부서코드, 부서명을 검색하라. 사원명기준으로 오름차순정열
SELECT EMPNO, ENAME, E.DEPTNO, DNAME
    FROM EMP E, DEPT D WHERE E.DEPTNO = D.DEPTNO ORDER BY ENAME;
    
--6. 사번, 사원명, 급여, 부서명을 검색하라. 
    --단 급여가 2000이상인 사원에 대하여 급여를 기준으로 내림차순으로 정열하시오
SELECT EMPNO, ENAME, SAL, DNAME
    FROM EMP E, DEPT D WHERE E.DEPTNO = D.DEPTNO AND SAL >= 2000 ORDER BY SAL DESC;
    
--7. 사번, 사원명, 업무, 급여, 부서명을 검색하시오. 단 업무가 MANAGER이며 급여가 2500이상인
-- 사원에 대하여 사번을 기준으로 오름차순으로 정열하시오.
SELECT EMPNO, ENAME, JOB, SAL, DNAME
    FROM EMP E, DEPT D WHERE E.DEPTNO = D.DEPTNO
        AND JOB = 'MANAGER' AND SAL >= 2500 ORDER BY EMPNO;

--8. 사번, 사원명, 업무, 급여, 등급을 검색하시오. 단, 급여기준 내림차순으로 정렬하시오
SELECT EMPNO, ENAME, JOB, SAL, GRADE
    FROM EMP, SALGRADE WHERE SAL BETWEEN LOSAL AND HISAL ORDER BY SAL DESC;

--9. 사원테이블에서 사원명, 사원의 상사를 검색하시오(상사가 없는 직원까지 전체)
SELECT E1.ENAME, E1.MGR, NVL(E2.ENAME, '없다') MGRNAME
    FROM EMP E1, EMP E2 
    WHERE E1.MGR = E2.EMPNO(+);

--10. 사원명, 상사명, 상사의 상사명을 검색하시오
SELECT E1.ENAME, E2.ENAME MGR, E3.ENAME MGR2
    FROM EMP E1, EMP E2, EMP E3
    WHERE E1.MGR = E2.EMPNO AND E2.MGR = E3.EMPNO;

--11. 위의 결과에서 상위 상사가 없는 모든 직원의 이름도 출력되도록 수정하시오
SELECT E1.ENAME, E2.ENAME MGR, E3.ENAME MGR2
    FROM EMP E1, EMP E2, EMP E3
    WHERE E1.MGR = E2.EMPNO(+) AND E2.MGR = E3.EMPNO(+);
