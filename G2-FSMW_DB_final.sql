--Create DATABASE FoodManagement;

--Bảng [Admin]
Create table [Admin] (
userAdmin varchar(20) primary key,
password varchar(50),
fullName varchar(50),
birthday date,
email varchar(50),
phone varchar(20),
gender bit,
address varchar(50),
img varchar(50)
)

--Bảng Employee
Create table Employee(
userEmployee varchar(20) primary key,
password varchar(50),
fullName varchar(20),
birthday date,
email varchar(50),
phone varchar(20),
gender bit,
address varchar(50),
img varchar(50)
)

--Bảng Category
Create table Category(
id_category int IDENTITY(1,1) primary key,
name_category varchar(20),
img_category varchar(50)
)

--Bảng Food
Create table Food(
idFood int primary key,
name_food varchar(20),
price int,
quantity int,
pic varchar(200),
description varchar(300),
status bit,
id_category int foreign key References Category(id_category)
)


--Bảng EditingDetail
Create table EditingDetail(
userEmployee varchar(20) foreign key References Employee(userEmployee),
idFood int,
add_food varchar(200),
delete_food varchar(200),
update_food varchar(200),
date_editing date
)

Create table Customer(
userCus varchar(20) primary key,
password varchar(50),
fullName varchar(50),
birthday date,
email varchar(50),
phone varchar(20),
gender bit,
address varchar(50),
img varchar(50)
)

Create table Cart(
userCus varchar(20) foreign key References  Customer(userCus),
idFood int foreign key References Food(idFood),
quantity int,
price int
)


--Bảng Feedback
Create table Feedback(
userCus varchar(20) foreign key References Customer(userCus),
idFood int,
dateFeedback date,
feedback varchar(100),
rating decimal(3,1)
)

--Bảng Order
Create table [Order](
idOrder INT IDENTITY(1,1) primary key,
userCus varchar(20) foreign key References Customer(userCus),
orderDate date,
total_quantity int,
note varchar(100),
address varchar(50),
phone varchar(20),
Confirm nvarchar(20) default 'No',
)

--Bảng OrderFood
Create table OrderFood(
idOrder int foreign key References [Order](idOrder),
idFood int,
quantity int,
price int
)

--Bảng WorkingSchedules
create table WorkingSchedule(
id int primary key,
userEmployee varchar(20) foreign key References Employee(userEmployee),
fullName varchar(20),
Day date,
Time varchar(20)
)