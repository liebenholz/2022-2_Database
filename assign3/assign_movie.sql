/* system 계정으로 접속. CONN system */
/* Oracle 12c 이상의 CDB 환경에서 사용. 사용자 이름 c## 추가 */
DROP USER c##movie CASCADE;
CREATE USER c##movie IDENTIFIED BY movie DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp PROFILE DEFAULT;
GRANT CONNECT, RESOURCE TO c##movie;
GRANT CREATE VIEW, CREATE SYNONYM TO c##movie;
GRANT UNLIMITED TABLESPACE TO c##movie;
ALTER USER c##movie ACCOUNT UNLOCK;

/* 여기서부터는 영화 계정으로 접속 */
conn c##movie/movie;

CREATE TABLE Theater (
theaterid NUMBER(2),
theatername VARCHAR2(40),
location VARCHAR2(40),
PRIMARY KEY (theaterid)
);

CREATE TABLE Cinema (
theaterid NUMBER(2),
cinenum NUMBER(2) CHECK(cinenum>1 AND cinenum<=10),
moviename VARCHAR2(60),
price NUMBER(8) CHECK(price>0 AND price<=20000),
seats NUMBER(4),
PRIMARY KEY(theaterid, cinenum) ON DELETE CASCADE
FOREIGN KEY(theaterid) REFERENCES Theater(theaterid)
);

CREATE TABLE Orders (
orderid NUMBER(2),
theaterid NUMBER(2),
cinenum NUMBER(2),
custid NUMBER(2),
seats NUMBER(4) UNIQUE,
orderdate DATE
PRIMARY KEY(orderid, theaterid, cinenum),
FOREIGN KEY(theaterid, cinenum) REFERENCES Cinema(theaterid, cinenum),
FOREIGN KEY(custid) REFERENCES Customer(custid)
);

CREATE TABLE Customer (
custid NUMBER(2),
name VARCHAR2(40),
address VARCHAR2(50),
PRIMARY KEY(custid)
);

/* Theater, Cinema, Orders, Customer 데이터 생성 */
INSERT INTO Theater VALUES(1, '롯데', '잠실');
INSERT INTO Theater VALUES(2, '메가', '강남');
INSERT INTO Theater VALUES(3, '대한', '잠실');

INSERT INTO Cinema VALUES (1, 1, '어려운 영화', 15000, 48);
INSERT INTO Cinema VALUES (3, 1, '멋진 영화', 7500, 120);
INSERT INTO Cinema VALUES (3, 2, '재밌는 영화', 8000, 110);

INSERT INTO Orders VALUES (1, 3, 2, 3, 15, TO_DATE('2020-09-01','yyyy-mm-dd'));
INSERT INTO Orders VALUES (2, 3, 1, 4, 16, TO_DATE('2020-09-01','yyyy-mm-dd'));
INSERT INTO Orders VALUES (3, 1, 1, 9, 48, TO_DATE('2020-09-01','yyyy-mm-dd'));

INSERT INTO Customer VALUES (3, '홍길동', '강남');
INSERT INTO Customer VALUES (4, '김철수', '잠실');
INSERT INTO Customer VALUES (9, '박영희', '강남');

additional insert data
INSERT INTO Theater VALUES(4, '하나', '신촌');
INSERT INTO Cinema VALUES (4, 1, '엄청난 영화', 9000, 100);
INSERT INTO Orders VALUES (4, 4, 1, 3, 24, TO_DATE('2022-09-01','yyyy-mm-dd'));
INSERT INTO Customer VALUES (5, '조성혁', '신촌');


COMMIT;