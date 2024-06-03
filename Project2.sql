

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
idFood varchar(20) primary key,
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
idFood varchar(20) foreign key References Food(idFood),
add_food bit,
delete_food bit,
update_food bit,
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

--Bảng Feedback
Create table Feedback(
userCus varchar(20) foreign key References Customer(userCus),
idFood varchar(20) foreign key References Food(idFood),
dateFeedback date,
feedback int
)
--Bảng Order
Create table [Order](
idOrder varchar(20) primary key,
userCus varchar(20) foreign key References Customer(userCus),
orderDate date,
total_quantity int,
note varchar(100),
status bit,
nameFood varchar(20),
address varchar(50),
phone varchar(20)
)
--Bảng OrderFood
Create table OrderFood(
idOrderFood varchar(20),
idOrder varchar(20) foreign key References [Order](idOrder),
idFood varchar(20) foreign key References Food(idFood),
quantity int,
price int
)

INSERT INTO Admin ( userAdmin,password, fullName, birthday,email,phone,gender,address,img)
VALUES 
('toan', CONVERT(VARCHAR(32), HASHBYTES('MD5', '123456'), 2),'Luu Truong Toan','2003-02-26','luutruongtoanltt@gmail.com','0949415422',1,'Ca Mau','image.jpg');