-- cau 1 :Tạo CSDL, các bảng và các khóa ngoại theo mô tả bên trên.

create database Quanlysinhvien;

use Quanlysinhvien

create table Khoa
(
	Makhoa varchar(4) primary key,
	Tenkhoa varchar(20)
)

create table SinhVien
(
	Hosv varchar(15),
	Tensv varchar(15),
	Masv varchar(4) primary key,
	Ngaysinh smalldatetime,
	Phai varchar(3),
	Makhoa varchar(4)
)

create table MonHoc
(
	Tenmh varchar(20),
	Mamh varchar(4) primary key,
	Sotiet int
)

create table KetQua
(
	Masv varchar(4),
	Mamh varchar(4),
	Lanthi int,
	Diem int
	constraint PK_Masv_Mamh_Lanthi Primary key(Masv, Mamh, Lanthi)
)

alter table SinhVien add constraint FK_SinhVien_Makhoa Foreign key(Makhoa) references Khoa(Makhoa)
alter table KetQua add constraint FK_KetQua_Masv Foreign key(Masv) references SinhVien(Masv),
constraint FK_KetQua_Mamh Foreign key(Mamh) references MonHoc(Mamh)

insert into Khoa
values('AVAN', 'Khoa Anh Van'),
('CNTT', 'Cong Nghe Thong Tin'),
('DTVT', 'Dien Tu Vien Thong'),
('QTKD', 'Quan Tri Kinh Doanh')

insert into SinhVien
select 'Tran Minh', 'Son', 'S001', '1/5/1985', 'Nam', 'CNTT' Union all
select 'Nguyen Quoc', 'Bao', 'S002', '15/1/1986', 'Nam', 'CNTT' Union all
select 'Phan Anh', 'Tung', 'S003', '20/12/1983', 'Nam', 'QTKD' Union all
select 'Bui Thi Anh', 'Thu', 'S004', '1/2/1985', 'Nu', 'QTKD' Union all
select 'Le Thi Lan', 'Anh', 'S005', '3/7/1987', 'Nu', 'DTVT' Union all
select 'Nguyen Thi', 'Lam', 'S006', '25/11/1984', 'Nu', 'CNTT' Union all
select 'Phan Thi', 'Ha', 'S007', '3/7/1988', 'Nu', 'CNTT' Union all
select 'Tran The', 'Dung', 'S008', '21/10/1985', 'Nam', 'CNTT'

insert into Monhoc
select 'Anh Van', 'AV', 45 Union all
select 'Co So Du Lieu', 'CSDL', 45 Union all
select 'Ky Thuat Lap Trinh', 'KTLT', 60 Union all
select 'Ke Toan Tai Chinh', 'KTTC', 45 Union all
select 'Toan Cao Cap', 'TCC', 60 Union all
select 'Tin Hoc Van Phong', 'THVP', 30 Union all
select 'Tri Tue Nhan Tao', 'TTNT', 45

insert into KetQua
select 'S001', 'CSDL', 1, 4 Union all
select 'S001', 'TCC', 1, 6 Union all
select 'S002', 'CSDL', 1, 3 Union all
select 'S002', 'CSDL', 2, 6 Union all
select 'S003', 'KTTC', 1, 5 Union all
select 'S004', 'AV', 1, 8 Union all
select 'S004', 'THVP', 1, 4 Union all
select 'S004', 'THVP', 2, 8 Union all
select 'S006', 'TCC', 1, 5 Union all
select 'S007', 'AV', 1, 2 Union all
select 'S007', 'AV', 2, 9 Union all
select 'S007', 'KTLT', 1, 6 Union all
select 'S008', 'AV', 1, 7


-- cau 2:

-- cau 2: Xóa các ràng buộc khóa ngoại tham chiếu đến bảng SINHVIEN và bảng MONHOC.
alter table KetQua drop constraint FK_KetQua_Masv, constraint FK_KetQua_Mamh
alter table SinhVien drop constraint FK_SinhVien_Makhoa

-- cau 3: Xóa bảng KHOA và MONHOC.
drop table Khoa, MonHoc
-- cau 4:Tạo lại các bảng và các khóa ngoại đã xóa ở câu 2 và 3.
create table Khoa
(
	Makhoa varchar(4) primary key,
	Tenkhoa varchar(20)
)
create table MonHoc
(
	Tenmh varchar(20),
	Mamh varchar(4) primary key,
	Sotiet int
)
alter table SinhVien add constraint FK_SinhVien_Makhoa Foreign key(Makhoa) references Khoa(Makhoa)
alter table KetQua add constraint FK_KetQua_Masv Foreign key(Masv) references SinhVien(Masv),
constraint FK_KetQua_Mamh Foreign key(Mamh) references MonHoc(Mamh)

-- cau 5:Nhập dữ liệu cho tất cả các bảng.

insert into Khoa
values('AVAN', 'Khoa Anh Van'),
('CNTT', 'Cong Nghe Thong Tin'),
('DTVT', 'Dien Tu Vien Thong'),
('QTKD', 'Quan Tri Kinh Doanh')

insert into SinhVien
select 'Tran Minh', 'Son', 'S001', '1/5/1985', 'Nam', 'CNTT' Union all
select 'Nguyen Quoc', 'Bao', 'S002', '15/1/1986', 'Nam', 'CNTT' Union all
select 'Phan Anh', 'Tung', 'S003', '20/12/1983', 'Nam', 'QTKD' Union all
select 'Bui Thi Anh', 'Thu', 'S004', '1/2/1985', 'Nu', 'QTKD' Union all
select 'Le Thi Lan', 'Anh', 'S005', '3/7/1987', 'Nu', 'DTVT' Union all
select 'Nguyen Thi', 'Lam', 'S006', '25/11/1984', 'Nu', 'CNTT' Union all
select 'Phan Thi', 'Ha', 'S007', '3/7/1988', 'Nu', 'CNTT' Union all
select 'Tran The', 'Dung', 'S008', '21/10/1985', 'Nam', 'CNTT'

insert into Monhoc
select 'Anh Van', 'AV', 45 Union all
select 'Co So Du Lieu', 'CSDL', 45 Union all
select 'Ky Thuat Lap Trinh', 'KTLT', 60 Union all
select 'Ke Toan Tai Chinh', 'KTTC', 45 Union all
select 'Toan Cao Cap', 'TCC', 60 Union all
select 'Tin Hoc Van Phong', 'THVP', 30 Union all
select 'Tri Tue Nhan Tao', 'TTNT', 45

insert into KetQua
select 'S001', 'CSDL', 1, 4 Union all
select 'S001', 'TCC', 1, 6 Union all
select 'S002', 'CSDL', 1, 3 Union all
select 'S002', 'CSDL', 2, 6 Union all
select 'S003', 'KTTC', 1, 5 Union all
select 'S004', 'AV', 1, 8 Union all
select 'S004', 'THVP', 1, 4 Union all
select 'S004', 'THVP', 2, 8 Union all
select 'S006', 'TCC', 1, 5 Union all
select 'S007', 'AV', 1, 2 Union all
select 'S007', 'AV', 2, 9 Union all
select 'S007', 'KTLT', 1, 6 Union all
select 'S008', 'AV', 1, 7

-- cau 6:Sửa số tiết của môn “Tri Tue Nhan Tao” lai 30 tiet.
update MonHoc
set Sotiet = 30
where Tenmh = 'Tri Tue Nhan Tao'

-- cau 7: Xóa kết quả của sinh viên S001.
delete from KetQua
where Masv = 'S001'
-- cau 8: Chèn lại các bộ của sinh viên S001 vừa xóa ở câu 7.
insert into KetQua
select 'S001', 'CSDL', 1, 4 Union all
select 'S001', 'TCC', 1, 6

-- cau 9: Sửa sinh viên "Nguyen Thi Lam" thành "Nguyen Van Lam" và phái thành "Nam".
update SinhVien
set Hosv = 'Nguyen Van', Tensv = 'Lam', Phai = 'Nam'
where Hosv = 'Nguyen Thi' and Phai = 'Nu'

-- cau 10: Chuyển sinh viên "Le Thi Lan Anh" sang khoa CNTT.
update SinhVien
set Makhoa = 'CNTT'
where Hosv = 'Le Thi Lan' and Tensv = 'Anh'
