--Reset All tables
drop table Staff cascade constraints;
drop table StaffRole cascade constraints;
drop table Station cascade constraints;
drop table Train cascade constraints;
drop table TrainType cascade constraints;
drop table Route cascade constraints;
drop table Service cascade constraints;
drop table ServiceDetail cascade constraints;
drop table Ticket cascade constraints;
drop table TrainHistory cascade constraints;
drop View drivers_roster;
drop View service_capacity;

--Create tables
Create Table StaffRole
(
Role_ID Integer NOT NULL,
Name Varchar(255) NOT NULL,
Salary Integer,
No_Employees Integer,
Primary Key(Role_ID),
Constraint check_no_employees Check(No_Employees>0)
);
Create Table Staff
(
Employee_No Integer NOT NULL,
Fname Varchar(255) NOT NULL,
Lname Varchar(255) NOT NULL,
Station_ID Integer  NOT NULL,
PPS Varchar(8) NOT NULL,
Role_ID Integer NOT NULL,
Primary Key(Employee_No),
Foreign Key(Role_ID) References StaffRole(Role_ID),
Constraint check_pps Check(Length(PPS)=8)
);
Create Table Station 
(
Station_ID Integer NOT NULL,
Name Varchar(255) NOT NULL,
Address Varchar(255),
No_Employees Integer,
Primary Key(Station_ID),
Constraint check_no_employees2 Check(No_Employees>0)
);
Create Table TrainType
(
Train_Type Varchar(255) NOT NULL,
Capacity Integer NOT NULL,
No_Carriages Integer,
Primary Key(Train_Type),
Constraint check_capacity Check(Capacity>=0),
Constraint check_no_carriages Check(No_Carriages>=0)
);
Create Table Train
(
Train_ID Integer NOT NULL,
Train_Type Varchar(255) NOT NULL,
Primary Key(Train_ID),
Foreign Key(Train_Type) References TrainType(Train_Type)
);
Create Table TrainHistory
(
Train_ID Integer NOT NULL,
Build_Date Date NOT NULL,
Last_Repair Date,
No_Repairs Integer,
Primary Key(Train_ID),
Foreign Key(Train_ID) References Train(Train_ID),
Constraint check_no_repairs Check(No_Repairs>=0)
);
Create Table Route
(
Route_ID Integer NOT NULL,
Start_Station Integer NOT NULL,
End_Station Integer NOT NULL,
Duration Integer,
Primary Key(Route_ID),
Foreign Key(Start_Station) References Station(Station_ID),
Foreign Key(End_Station) References Station(Station_ID)
);
Create Table Service
(
Service_ID Integer NOT NULL,
Station_ID Integer NOT NULL,
Dept_Time Varchar(255) NOT NULL,
Primary Key(Service_ID,Station_ID),
Foreign Key(Station_ID) References Station(Station_ID)
);
Create Table ServiceDetail
(
Service_ID Integer NOT NULL,
Route_ID Integer NOT NULL,
Period Varchar(2),
Train_ID Integer NOT NULL,
Driver_ID Integer NOT NULL,
Primary Key(Service_ID),
Foreign Key(Route_ID) References Route(Route_ID),
Foreign Key(Train_ID) References Train(Train_ID),
Foreign Key(Driver_ID) References Staff(Employee_No),
--Foreign Key(Service_ID) References Service(Service_ID),
Constraint period_check Check (Period in ('MF', 'SA','SU','BH'))
);
Create Table Ticket
(
Route_ID Integer NOT NULL,
Ticket_Type char NOT NULL,
Price Decimal(3,2) NOT NULL,
Primary Key(Route_ID,Ticket_Type),
Foreign Key(Route_ID) References Route(Route_ID) ,
Constraint type_check Check(Ticket_Type in('A', 'C', 'S'))
);

--Alters
Alter Table Staff Add unique(pps);
Alter Table Staff
Add Foreign Key(Station_ID) References Station(Station_ID);

--Inserts
Insert Into StaffRole Values(1,'Train Driver', 40000,24);
Insert Into StaffRole Values(2,'Station Controller', 60000,7);
Insert Into StaffRole Values(3,'Ticket Inspector', 38000,4);
Insert Into StaffRole Values(4,'Manager', NULL,2);
Insert Into StaffRole Values(5,'Director', NULL,2);

Insert Into Station Values(4,'Tara St', 'Tara St, Dublin 2',2);
Insert Into Station Values(1,'Heuston', 'Ushers, Dublin',18);
Insert Into Station Values(2,'Pearse', 'Westland Row, Dublin 2',3);
Insert Into Station Values(12,'Malahide', 'Malahide, Co.Dublin',2);
Insert Into Station Values(31,'Howth Junction', NULL,5);
Insert Into Station Values(3,'Connolly', 'North Dock, Dublin 1',34);
Insert Into Station Values(21,'Bray', NULL,1);

Insert Into Staff Values(1001,'Joesph','Miller',3,'2321344R',1);
Insert Into Staff Values(1023,'Jane','Mac',1,'5634441S',3);
Insert Into Staff Values(1004,'Adam','Fitzgerald',1,'8741344P',1);
Insert Into Staff Values(1014,'Thomas','Morgan',2,'2349044Q',2);
Insert Into Staff Values(1092,'Lea','Mirou',4,'0120044C',3);
Insert Into Staff Values(1002,'Cassandra','Hella',3,'7840534Q',5);
Insert Into Staff Values(1049,'Pierre','Gignac',12,'2420887C',4);

--Insert Into Values();
Insert Into TrainType Values('P22340A',760,6);
Insert Into TrainType Values('P22341B',500,4);
Insert Into TrainType Values('F660',0,0);
Insert Into TrainType Values('P22350A',900,8);
Insert Into TrainType Values('P892Q',232,4);

Insert Into Train Values(44, 'P22340A');
Insert Into Train Values(38, 'P22340A');
Insert Into Train Values(5, 'F660');
Insert Into Train Values(50, 'P22341B');
Insert Into Train Values(58, 'P22350A');


Insert Into TrainHistory Values(5,'22-march-2009', '11-november-2016', 24);
Insert Into TrainHistory Values(58,'05-dec-2015', NULL, NULL);
Insert Into TrainHistory Values(44,'22-jun-2012', '04-oct-2016', 5);
Insert Into TrainHistory Values(50,'17-jan-2015', NULL, 0);
Insert Into TrainHistory Values(38,'17-may-2010', '29-may-2016',12);

Insert Into Route Values(1,3,21,50);
Insert Into Route Values(2,2,12,28);
Insert Into Route Values(3,3,1,12);
Insert Into Route Values(4,21,3,50);
Insert Into Route Values(8,12,2,28);
Insert Into Route Values(10,1,3,12);

Insert Into Service values(21, 2, '10:00');
Insert Into Service values(21, 4, '10:04');
Insert Into Service values(21, 3, '10:09');
Insert Into Service values(21, 31, '10:20');
Insert Into Service values(21, 12, '10:28');
Insert Into Service values(45, 1, '08:18');
Insert Into Service values(45, 3, '08:31');
Insert Into Service values(87, 3, '17:40');
Insert Into Service values(87, 4, '17:43');
Insert Into Service values(87, 21, '18:30');
Insert Into Service values(101, 1, '20:00');
Insert Into Service values(101, 3, '20:12');
Insert Into Service values(12, 21, '13:40');
Insert Into Service values(12, 4, '13:43');
Insert Into Service values(12, 3, '14:30');

Insert Into ServiceDetail Values(21,2,'MF',38,1001);
Insert Into ServiceDetail Values(45,10,'SA',38,1004);
Insert Into ServiceDetail Values(87,1,'MF',58,1004);
Insert Into ServiceDetail Values(101,10,'SU',44,1001);
Insert Into ServiceDetail Values(12,4,'BH',50,1004);

Insert Into Ticket Values(2,'A',3.60);
Insert Into Ticket Values(2,'C',1.60);
Insert Into Ticket Values(2,'S',2.20);
Insert Into Ticket Values(4,'A',4.90);
Insert Into Ticket Values(4,'C',3.00);
Insert Into Ticket Values(4,'S',4.10);

--Security Measures
Create Role Director;
Create Role Manager;
Create Role Employee;

Grant Manager to Pierre Gignac;
Grant Director to Cassandra Hella;

--Views
Create View drivers_roster As 
Select Staff.Fname, Staff.Lname, ServiceDetail.Service_ID, ServiceDetail.Route_ID
From Staff, ServiceDetail
Where Staff.Employee_No=ServiceDetail.Driver_ID And Staff.Role_ID=1;

Create View service_capacity As
Select  ServiceDetail.Service_ID,TrainType.Capacity
From TrainType, ServiceDetail, Train
Where ServiceDetail.Train_ID=Train.Train_ID And Train.Train_Type=TrainType.Train_Type;

--Selects
Select Ticket.Ticket_Type ,Ticket.Price
From Ticket,ServiceDetail,Service
Where Service.Station_ID=2 And Service.Dept_Time='10:00' And ServiceDetail.Service_ID=Service.Service_ID 
And Ticket.Route_ID=ServiceDetail.Route_ID;

Select Train.Train_ID, TrainType.Train_Type, TrainHistory.No_Repairs
From Train, TrainHistory, TrainType
Where TrainHistory.No_Repairs >20 And TrainHistory.Train_ID=Train.Train_ID And Train.Train_Type= TrainType.Train_Type;

--Updates
Update StaffRole Set Salary =42500 Where Role_ID=1;

Update Staff Set Lname='Kelly' Where Employee_No=1023;

Update Ticket Set Price=1.40 Where Route_ID=2 And Ticket_Type='C';

--Triggers
Create or Replace Trigger update_noEmployees_Insert
Before Insert on Staff
For each Row
Declare
rId Number;
Begin
 rID := :NEW.Role_ID;
 Update StaffRole
 Set No_Employees = No_Employees +1
 Where Role_ID=rID;
End;
.
Run;

Create or Replace Trigger update_noEmployees_Delete
Before Delete on Staff
For each Row
Declare
rId Number;
Begin
 rID := :OLD.Role_ID;
 Update StaffRole
 Set No_Employees = No_Employees -1
 Where Role_ID=rID;
End;
.
Run;

--Test Triggers
Select StaffRole.No_Employees
From StaffRole
Where StaffRole.Role_ID=1;

Insert Into Staff Values(1074,'Keith','Hooper',1,'8741557O',1);

Select StaffRole.No_Employees
From StaffRole
Where StaffRole.Role_ID=1;

Delete from Staff 
Where Employee_No=1074;

Select StaffRole.No_Employees
From StaffRole
Where StaffRole.Role_ID=1;

Create or Replace Trigger update_noRepairs
After Update on TrainHistory
For each Row
Declare
lastR Date;
Begin
 lastR := :OLD.Last_Repair;
 Update TrainHistory
 Set No_Repairs = No_Repairs +1
 Where Last_Repair!=lastR;
End;
.
Run;

Select TrainHistory.No_Repairs
From TrainHistory
Where Train_ID='44';

Update TrainHistory Set Last_Repair='14-dec-2016' 
Where Train_ID='44';

Select TrainHistory.No_Repairs
From TrainHistory
Where Train_ID='44';