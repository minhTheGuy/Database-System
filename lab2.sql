-- câu 1
create table Khoa
(
	Makhoa varchar(5) primary key,
	Tenkhoa varchar(20)
);

create table SinhVien
(
	Hosv varchar(15),
	Tensv varchar(15),
	Masv varchar(7),
	Ngaysinh smalldatetime,
	Phai varchar(3),
	Makhoa varchar(5),
	Primary key(Masv),
	Foreign key(Makhoa) references Khoa(Makhoa)
);
create table Monhoc
(
	Tenmh varchar(20),
	Mamh varchar(5),
	Sotiet int check(Sotiet > 0)
	Primary key(Mamh)
);
create table Ketqua
(
	Masv varchar(7),
	Mamh varchar(5),
	Lanthi int check(Lanthi > 0)
	Primary key(Lanthi),
	Foreign key(Masv) references Sinhvien(Masv),
	Foreign key(Mamh) references Monhoc(Mamh)
);

-- câu 2
alter table Ketqua drop [FK__Ketqua__Mamh__440B1D61], [FK__Ketqua__Masv__4316F928]
alter table Sinhvien drop [FK__SinhVien__Makhoa__398D8EEE]
-- câu 3
drop table SinhVien, Monhoc
-- câu 4


create table SinhVien
(
	Hosv varchar(15),
	Tensv varchar(15),
	Masv varchar(7),
	Ngaysinh smalldatetime,
	Phai varchar(3),
	Makhoa varchar(5),
	Primary key(Masv),
	Foreign key(Makhoa) references Khoa(Makhoa)
);

create table Monhoc
(
	Tenmh varchar(20),
	Mamh varchar(5),
	Sotiet int check(Sotiet > 0)
	Primary key(Mamh)
);

-- câu 5

insert into Khoa
select 'AVAN', 'Khoa Anh Van' Union all
select 'CNTT', 'Cong Nghe Thong Tin' Union all
select 'DTVT', 'Dien Tu Vien Thong' Union all
select 'QTKD', 'Quan Tri Kinh Doanh'

insert into Sinhvien(Hosv, Tensv, Masv, Ngaysinh, Phai, Makhoa) 
select 'Tran Minh', 'Son', 'S001', '1985-5-1','Nam', 'CNTT' Union all
select 'Nguyen Quoc', 'Bao', 'S002', '1986-6-15', 'Nam', 'CNTT' Union all
select 'Phan Anh', 'Tung', 'S003', '1983-12-20', 'Nam', 'QTKD' Union all
select 'Bui Thi Anh', 'Thu', 'S004', '1985-2-1', 'Nu', 'QTKD' Union all
select 'Le Thi Lan', 'Anh', 'S005', '1987-7-3', 'Nu', 'DTVT' Union all
select 'Nguyen Thi', 'Lam', 'S006', '1984-11-25', 'Nu', 'DTVT' Union all
select 'Pham Thi', 'Ha', 'S007', '1988-7-3', 'Nu', 'CNTT' Union all
select 'Tran The', 'Dung', 'S008', '1985-10-21', 'Nam', 'CNTT'

insert into Monhoc
values('Anh Van', 'AV', 45),
('Co So Du Lieu', 'CSDL', 45),
('Ky Thuat Lap Trinh', 'KTLT', 60),
('Ke Toan Tai Chinh', 'KTTC', 45),
('Toan Cao Cap', 'TCC', 60),
('Tin Hoc Van Phong', 'THVP', 30),
('Tri Tue Nhan Tao', 'TTNT', 45)

insert into Ketqua
select 'S001','CSDL', 1, 4 Union all
select 'S001', 'TCC', 1, 6 Union all
select 'S002', 'CSDL', 1, 3 Union all
select 'S002', 'CSDL', 2, 6 Union all
select 'S003', 'KTTC', 1, 5 Union all
select 'S004', 'AV', 1, 8 Union all
select 'S004', 'THVP', 1, 4 Union all
select 'S004', 'THVP', 2, 8 Union all
select 'S004', 'TCC', 2, 5 Union all
select 'S006', 'TCC', 1, 5 Union all
select 'S007', 'AV', 1, 2 Union all
select 'S007', 'AV', 2, 9 Union all
select 'S008', 'AV', 1, 7

-- câu 7
delete from Ketqua where Ketqua.Masv = 'S001'
