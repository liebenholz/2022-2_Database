/* Oracle 12c 이상의 CDB 환경에서 사용. 사용자 이름 c## 추가 */
DROP USER c##sales CASCADE;
CREATE USER c##sales IDENTIFIED BY sales DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp PROFILE DEFAULT;
GRANT CONNECT, RESOURCE TO c##sales;
GRANT CREATE VIEW, CREATE SYNONYM TO c##sales;
GRANT UNLIMITED TABLESPACE TO c##sales;
ALTER USER c##sales ACCOUNT UNLOCK;

/* 여기서부터는 주문 계정으로 접속 */
conn c##sales/sales;

CREATE TABLE Salesperson (
name VARCHAR2(40),
age NUMBER(4),
salary NUMBER(8),
PRIMARY KEY(name)
);

CREATE TABLE Order (
ordernum NUMBER(2),
custname VARCHAR2(40),
salesperson VARCHAR2(40) REFERENCES Salesperson.name,
amount NUMBER(8),
PRIMARY KEY(custname, salesperson),
FOREIGN KEY(custname) REFERENCES Customer.name,
FOREIGN KEY(custname) REFERENCES Salesperson.name
);

CREATE TABLE Customer (
name VARCHAR2(40),
city VARCHAR2(40),
industrytype VARCHAR2(80),
PRIMARY KEY(name)
);

/* Salesperson, Orders, Customer 데이터 생성 */
INSERT INTO Salesperson VALUES('TOM', 28, 30000);
INSERT INTO Salesperson VALUES('JERRY', 24, 25000);
INSERT INTO Salesperson VALUES('SPIKE', 32, 20000);

INSERT INTO Orders VALUES (1, 'SARAH', 'TOM', 20);
INSERT INTO Orders VALUES (2, 'MATT', 'TOM', 10);
INSERT INTO Orders VALUES (3, 'JIM', 'JERRY', 10);
INSERT INTO Orders VALUES (4, 'MATT', 'JERRY', 10);
INSERT INTO Orders VALUES (5, 'SARAH', 'JERRY', 30);
INSERT INTO Orders VALUES (6, 'JIM', 'SPIKE', 15);

INSERT INTO Customer VALUES ('JIM', 'LA', 'MECHANIC');
INSERT INTO Customer VALUES ('MATT', 'NY', 'MECHANIC');
INSERT INTO Customer VALUES ('SARAH', 'LA', 'THERAPHY');

COMMIT;