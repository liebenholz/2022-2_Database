/* Oracle 12c 이상의 CDB 환경에서 사용. 사용자 이름 c## 추가 */
DROP USER c##enterprise CASCADE;
CREATE USER c##enterprise IDENTIFIED BY enterprise DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp PROFILE DEFAULT;
GRANT CONNECT, RESOURCE TO c##enterprise;
GRANT CREATE VIEW, CREATE SYNONYM TO c##enterprise;
GRANT UNLIMITED TABLESPACE TO c##enterprise;
ALTER USER c##enterprise ACCOUNT UNLOCK;

/* 여기서부터는 기업 계정으로 접속 */
conn c##enterprise/enterprise;

CREATE TABLE Employee (
empno NUMBER(2),
name VARCHAR2(40),
phoneno VARCHAR2(40),
address VARCHAR2(40),
sex VARCHAR(8),
position VARCHAR2(40),
deptno NUMBER(2),
PRIMARY KEY(empno),
);

CREATE TABLE Department (
deptno NUMBER(2),
deptname VARCHAR2(40),
manager VARCHAR2(40),
PRIMARY KEY(deptno)
);

CREATE TABLE Project (
projno NUMBER(2),
projname VARCHAR2(40),
deptno NUMBER(2),
PRIMARY KEY(projno),
);

CREATE TABLE Works (
empno NUMBER(2),
projno NUMBER(2),
hours_worked NUMBER(8),
PRIMARY KEY(empno, projno),
);

/* Employee, Department, Project, Works 데이터 생성 */
INSERT INTO Employee VALUES(1, '김철수', '010-1000-2000', '대한민국 서울', '남', '차장', 3);
INSERT INTO Employee VALUES(2, '박영희', '010-2000-3000', '대한민국 구리', '여', '대리', 1);
INSERT INTO Employee VALUES(3, '이지영', '010-3000-4000', '대한민국 광명', '여', '차장', 2);
INSERT INTO Employee VALUES(4, '최주현', '010-4000-5000', '대한민국 군포', '남', '사원', 3);
INSERT INTO Employee VALUES(5, '홍길동', '010-5000-6000', '대한민국 성남', '남', '부장', 1);
INSERT INTO Employee VALUES(6, '강찬석', '010-6000-7000', '대한민국 수원', '남', '대리', 2);
INSERT INTO Employee VALUES(7, '장지수', '010-7000-8000', '대한민국 서울', '여', '사원', 3);

INSERT INTO Department VALUES (1, '경영', '홍길동');
INSERT INTO Department VALUES (2, '마케팅', '이지영');
INSERT INTO Department VALUES (3, 'IT', '김철수');

INSERT INTO Project VALUES (1, '3분기 주주총회', 1);
INSERT INTO Project VALUES (2, '3분기 매출 분석', 2);
INSERT INTO Project VALUES (3, '4분기 광고 협의', 2);
INSERT INTO Project VALUES (4, '신규 업데이트', 3);

INSERT INTO Works VALUES (1, 4, 2);
INSERT INTO Works VALUES (2, 1, 3);
INSERT INTO Works VALUES (3, 2, 8);
INSERT INTO Works VALUES (4, 4, 9);
INSERT INTO Works VALUES (5, 1, 8);
INSERT INTO Works VALUES (6, 3, 10);
INSERT INTO Works VALUES (7, 4, 12);

COMMIT;