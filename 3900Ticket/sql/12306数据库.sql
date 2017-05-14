/*       12306���ݿ�     */

--��վ��
CREATE TABLE station(
    s_ID VARCHAR2(8), --վ����
    s_name VARCHAR2(12)  PRIMARY KEY,  --վ����
    condition VARCHAR2(10) DEFAULT 'ʹ����' NOT NULL --վ��״̬
);
CREATE SEQUENCE seq_station_sID  START WITH 1001 INCREMENT BY 1;

create or replace trigger tri_station
before insert on station
for each row
begin
    select 'D'||seq_station_sID.nextval into :new.s_ID from dual;
end;

--�������
CREATE TABLE traininfo(
    t_ID VARCHAR2(10),  --�𳵱��
    t_init VARCHAR2(12) constraint I_trani REFERENCES station(s_name), --��ʼ����
    init_ID  INT,  --��ʼ��Ϊ����վ
    t_dest VARCHAR2(12) constraint D_trani REFERENCES station(s_name),  --Ŀ�ĵ���
    dest_ID INT,  --Ŀ�ĵ�Ϊ����վ
    soft_seat INT  default 0  CHECK ( soft_seat>=0),  --������
    hard_seat INT  DEFAULT 0 CHECK (hard_seat>=0),  --Ӳ����
    t_seat  INT  DEFAULT 0 CHECK (t_seat>=0), --Ӳ����
    soft_price NUMBER(7,2) NOT NULL, --���Լ۸� 
    hard_price NUMBER(7,2) NOT NULL,  --Ӳ�Լ۸�
    seat_price NUMBER(7,2) NOT NULL, --Ӳ���۸�
    start_time  VARCHAR2(16) NOT NULL,      --��ʼʱ��
    end_time   VARCHAR2(16) NOT NULL    --����ʱ��
    --dates CHAR(16),  --����
    --note VARCHAR2(200), --��ע
    --condition VARCHAR2(20) DEFAULT '��������' --״̬
);

--���ܱ�
create table train (
       t_ID  varchar(6) ,--�𳵺�
       start_day VARCHAR2(25) ,      --��ʼʱ��
       end_day VARCHAR2(25),      --����ʱ��
       soft_seat  int DEFAULT 0 CHECK (soft_seat>=0),   --����
       hard_seat int DEFAULT 0 CHECK (hard_seat>=0),  --Ӳ��
       t_seat  INT  DEFAULT 0 CHECK ( t_seat>=0),  --Ӳ��
       condition  VARCHAR2(10) DEFAULT '��ʼ����',  --״̬
       times INT --�涨����ʱ��
);

--�˿Ͷ�����
create table ticketOrder(
       IDs VARCHAR2(50) PRIMARY KEY,
       accountId VARCHAR2(20),   --references customers(accountId), --12306�˺�
       c_name varchar2(15),--�˿���
       c_ID varchar2(18) , --�˿����֤��
       t_ID varchar2(20),--����
       t_init varchar2(50),--��ʼ��
       init_ID  INT ,  --��ʼ��Ϊ����վ
       t_dest varchar2(50),--Ŀ�ĵ�
       dest_ID INT,  --Ŀ�ĵ�Ϊ����վ   
       seat_kind Varchar2(10), --��λ����
       seat_Id varchar2(20),--��λ��
       condition varchar2(10) DEFAULT'δ����', --����״̬  
       past  VARCHAR2(25)DEFAULT '��', --����ʱ��
       datet VARCHAR2(25),  --�˳�����
       datep VARCHAR2(25), --��Ʊ����  
       note VARCHAR2(100),--��ע
       price Number(7,2)   --Ʊ��  
);

CREATE SEQUENCE seq_ticketOrder_IDs  START WITH 1 INCREMENT BY 1;

create or replace trigger tri_ticketOrder
before insert on ticketOrder
for each row
begin
    select to_char(SYSDATE,'YYYYMMDDHHmmss')||seq_ticketOrder_IDs.nextval into :new.IDs from dual;
end;

--�˿���Ϣ��
create table customers(
       cname varchar2(50) ,--�˿���
       c_ID varchar2(18) , --�˿����֤�� 
       accountId varchar2(20) not null unique,--12306�˺�
       sex varchar2(3)  constraint aaaa check(sex in('��','Ů')), --�Ա�
       e_pwd varchar2(40), --��¼���� 
       p_pwd varchar2(40) ,--֧������
       email VARCHAR2(30) NOT NULL, --�û������
       question VARCHAR2(30) NOT NULL, --�ܱ�����
       answer VARCHAR2(20)  , --�ܱ���
       school Varchar2(30) DEFAULT '��', --�˿�ѧУ
       stu_ID Varchar2(10) DEFAULT '��', --�˿�ѧ����
       isStudent Varchar2(2) DEFAULT 'n'   --�Ƿ������ѧ��Ʊ
);
--����Ա��
CREATE TABLE admins(
    a_ID VARCHAR2(12)PRIMARY KEY,  --����ԱID
    a_pwd VARCHAR2(40) NOT NULL, --����Ա����
    a_name VARCHAR2(10) DEFAULT 'admin' --����Ա����
);

--����Ϣ�����
CREATE TABLE t_daily_report(
    times  VARCHAR2(20),  --�޸�ʱ��
    a_ID  VARCHAR2(12),--�����ԱID
    t_ID VARCHAR2(6), --�𳵺�
    start_dates VARCHAR2(25),  --����
    end_dates VARCHAR2(25) DEFAULT '��',
    note VARCHAR2(200),--��ע
    defect VARCHAR2(20) --ë��
);

--վ����Ϣ����� 
CREATE TABLE s_daily_report(
    start_dates VARCHAR2(25),  --����
    end_dates VARCHAR2(25) DEFAULT '��',
    times  VARCHAR2(20),  --�޸�ʱ��
    s_ID VARCHAR2(8), --վ����
    a_ID  VARCHAR2(12),--�����ԱID
    s_name VARCHAR2(6), --վ����
    note VARCHAR2(200),--��ע
    defect VARCHAR2(20) --ë��
);

--��ϵ�˱�
CREATE TABLE linkman(
    L_ID varchar2(18) CHECK(L_ID LIKE '__________________'),
    L_name VARCHAR2(15),
   isStudent Varchar2(2) DEFAULT '��',   --�Ƿ������ѧ��Ʊ
    accountId varchar2(20) REFERENCES customers(accountId),
    school Varchar2(30) DEFAULT '��', --�˿�ѧУ
    stu_ID Varchar2(10) DEFAULT '��' --�˿�ѧ����
);


insert into admins(a_ID,a_pwd,a_name)values('A1001','a','����');
insert into admins(a_ID,a_pwd,a_name)values('A1002','a','����');
insert into admins(a_ID,a_pwd,a_name)values('A1003','a','�޲���');
