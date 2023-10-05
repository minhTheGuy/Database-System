create database quanlythuctap;
use quanlythuctap;

--I. cơ sở dữ liệu quanlythuctap
--Sinhvien (masv, tên, quê quán, ngày sinh, học lực)
--Detai (madt, tên đề tài, chủ nhiệm đề tài, kinh phí)
--Sinhvien_Detai (masv, madt, nơi thực tập, quảng đường, kết quả)
--


--1. Tạo các table với các ràng buộc:
--a. Khóa chính, khóa ngoại

create table SinhVien
(
	masv char(4),
	hoTen nvarchar(40),
	noiSinh nvarchar(30),
	ngaySinh smalldatetime,
	hocLuc float
	primary key(masv)
)

create table DeTai
(
	madt char(5),
	Tendt nvarchar(40),
	chuNhiem nvarchar(40),
	kinhPhi int,
	primary key(madt)
)

create table SinhVien_DeTai
(
	masv char(4),
	madt char(5),
	noiThucTap nvarchar(40),
	quangDuong int,
	ketQua float
	primary key(masv, madt)
)
alter table SinhVien_DeTai add constraint FK_SinhVienDeTai_Masv Foreign key(masv) references SinhVien(Masv)
							,constraint FK_SinhVienDeTai_Madt Foreign key(Madt) references DeTai(Madt)
--b. Tạo Defaut: 0 cho cột KP
alter table DeTai add constraint DF_KinhPhi Default 0 for KinhPhi

--c. Tạo Check >= 0 và <= 10 cho cột HL và KQ, kinhphi < 100 000 000 cho cột KP
alter table SinhVien add constraint Check_HL check(HL >= 0 and HL <= 10)
alter table SinhVien_DeTai add constraint Check_KQ check(KQ >= 0 and KQ <= 10)

--d. Thực hiện thêm dữ liệu cho các table, mỗi table ít nhất 5 dòng dữ liệu.

insert into SinhVien
values('A001', N'Nguyễn Huỳnh Đăng Minh', N'TP HCM', '13/12/2004', 5),
('A002', N'Minh Nguyễn Huỳnh', N'An Giang', '14/12/2004', 6),
('A003', N'Nguyễn Minh Đăng', N'Kiên Giang', '4/1/2003', 8),
('A004', N'Nguyễn Huỳnh', N'Tiền Giang', '11/11/2003', 8),
('A005', N'Lê Huỳnh Thảo Minh', N'Hà Giang', '12/12/2002', 9),
('A006', N'Lê Hoàng Minh', N'An Giang', '14/12/2004', 8.6),
('A007', N'Hà Phạm Ngọc Minh', N'Hà Giang', '21/9/1999', 8.3),
('A008', N'Lê Hoàng Tú', N'Hải Phòng', '30/3/1980', 9.2),
('A009', N'Minh Phạm', N'Hải Phòng', '27/9/1979', 9.8),
('A010', N'Hoàng Minh', N'Hà Nội','21/8/2003', 8.3),
('A011', N'Phạm Hoàng', N'Hà Nội', '11/5/2002', 9.1),
('A012', N'Cao Lê Minh Giám', N'Lâm Đồng', '8/8/2004', 9.3),
('A013', N'Hoàng Thị Thuỳ Minh', N'TP HCM', '11/3/2002', 8.3)

insert into DeTai
values ('DT001', N'Phần mềm dịch thuật tài liệu triết học', 'Th.s Minh', 1000000),
('DT002', N'Thiết kế microservice bằng Spring boot', 'TS Minh', 100000000),
('DT003', N'Thuật toán phân tích thói quen chi tiêu', N'Th.s Đăng', 10000),
('DT004', N'Phát triển AI mô phỏng một triết gia', N'GS Huỳnh', 100000000),
('DT005', N'Nghiên cứu xác suất sinh viên rớt môn', N'Th.s Nguyễn', 10000000),
('DT006', N'Thiết kế giải thuật định vị gps','TS Minh', 1000000000)

insert into SinhVien_DeTai
values ('A001', 'DT001', 'Dai Hoc MINH', 3, 6),
('A002', 'DT002', 'Dai Hoc Ton Duc Thang', 10, 9),
('A003', 'DT003', 'Dai Hoc Ton Duc Thang', 4, 8),
('A004', 'DT004', 'Cao Dang Minh', 12, 7),
('A004', 'DT005', 'Dai Hoc Ton Duc Thang', 6, 10),
('A005', 'DT005', 'Dai Hoc Ton Duc Thang', 3, 10),
('A006', 'DT005', 'Dai Hoc Ton Duc Thang', 200, 8.5),
('A007', 'DT005', 'Dai Hoc Ton Duc Thang', 150, 8.6),
('A003', 'DT004', 'Dai Hoc Ton Duc Thang', 32, 8.3),
('A012', 'DT002', 'Dai Hoc Da Lat', 15, 7.3)

insert into SinhVien_DeTai
values ('A001', 'DT001', N'Lâm Đồng', 3, 6),
('A002', 'DT002', N'An Giang', 10, 9),
('A003', 'DT003', N'Bến Tre', 4, 8),
('A004', 'DT004', N'Kiên Giang', 12, 7),
('A004', 'DT005', N'Tiền Giang', 6, 10),
('A005', 'DT005', N'Vĩnh Long', 3, 10),
('A006', 'DT005', N'Cần Thơ', 200, 8.5),
('A007', 'DT005', N'Tây Ninh', 150, 8.6),
('A003', 'DT004', N'Kiên Giang', 32, 8.3),
('A012', 'DT002', N'Lâm Đồng', 15, 7.3),
('A009', 'DT002', N'TP HCM', 250, 9.5)



--2. Tạo các bảng ảo (view) cho các yêu cầu sau, tên của View theo dạng: cau2_<số
--thứ tự>, ví dụ: “cau2_a”
--a. Cho biết sv <20 tuổi và có HL >8.5.

create view cau2_a as
select * 
from SinhVien
where year(getdate()) - year(ngaySinh) < 20 and hocLuc > 8.5
select * from cau2_a
--b. Thông tin về đề tài có KP > 1 triệu đồng
create view cau2_b as
select *
from DeTai
where kinhPhi > 1000000
select * from cau2_b
--c. Danh sách sinh viên <20 tuổi, học lực và thực tập >8
create view cau2_c as
select SinhVien.masv, SinhVien.hoTen, SinhVien.ngaySinh, SinhVien.noiSinh, SinhVien.hocLuc, SinhVien_DeTai.ketQua
from SinhVien
inner join SinhVien_DeTai
on SinhVien.masv = SinhVien_DeTai.masv
where hocLuc > 8 and ketQua > 8
group by SinhVien.masv, SinhVien.hoTen, SinhVien.ngaySinh, SinhVien.noiSinh, SinhVien.hocLuc, SinhVien_DeTai.ketQua
select * from cau2_c

--d. Danh sách các chủ nhiệm đề tài có sinh viên quê ở TPHCM tham gia
create view cau2_d as 
select chuNhiem from DeTai
inner join SinhVien_DeTai
on DeTai.madt = SinhVien_DeTai.madt
inner join SinhVien
on SinhVien_DeTai.masv = SinhVien.masv
where SinhVien.noiSinh = 'TP HCM'
group by chuNhiem

--e. Cho thông tin về sinh viên sinh trước năm 1980 và quê ở Hải Phòng
create view cau2_e as 
select *
from SinhVien
where year(ngaySinh) < 1980 and noiSinh = N'Hải Phòng'
select * from cau2_c
--f. Điểm trung bình của sinh viên quê ở Hà Nội

create view cau2_f as
select noiSinh, avg(hocLuc) 'Điểm trung bình'
from SinhVien
where noiSinh = N'Hà Nội'
group by noiSinh

select * from cau2_d

--g. Số tỉnh có sinh viên đến thực tập theo đề tài 5
create view cau2_g as
select SinhVien_DeTai.madt, count(distinct noiSinh) 'Số tỉnh' from SinhVien
inner join SinhVien_DeTai
on SinhVien.masv = SinhVien_DeTai.masv
where madt = 'DT005'
group by SinhVien_DeTai.madt

select * from cau2_g
--h. Danh sách các tỉnh và số sinh viên quê ở tỉnh đó, nhóm theo quê quán
create  view cau2_h as
select distinct noiSinh, count(masv) 'Số sinh viên' from SinhVien
group by noiSinh

select * from cau2_h

--3. Tạo các truy vấn sau:
--a. Các đề tài từ 2 sinh viên trở lên đăng ký tham gia.
select DeTai.madt, Tendt, chuNhiem, kinhPhi from DeTai
inner join SinhVien_DeTai
on DeTai.madt = SinhVien_DeTai.madt
group by DeTai.madt, Tendt, chuNhiem, kinhPhi
having count(masv) >= 2

--b. Danh sách các sinh viên học giỏi hơn sinh viên ở TPHCM
select * from SinhVien
where noiSinh <> 'TP HCM' and hocLuc > all(select hocLuc 
												from SinhVien
												where noiSinh = 'TP HCM')

--c. Cộng thêm thêm 2 điểm thực tập cho sinh viên quê ở Lâm Đồng, điểm kết quả cuối
update SinhVien_DeTai
set ketQua = ketQua + (case
						when masv in (select masv from SinhVien
													where noiSinh = N'Lâm Đồng') 
													and masv + 2 < 10
																				then 2
						when masv in (select masv from SinhVien
													where noiSinh <> N'Lâm Đồng') then 0
					
--cùng không được vượt quá 10, nếu vượt quá 10 thì chỉ lấy 10 điểm.
--d. Cho biết danh sách các sinh viên thực tập tại quê nhà
select SinhVien.hoTen, SinhVien.masv, SinhVien.noiSinh, SinhVien.ngaySinh, SinhVien.hocLuc
from SinhVien
inner join SinhVien_DeTai
on SinhVien.noiSinh = SinhVien_DeTai.noiThucTap
group by SinhVien.hoTen, SinhVien.masv, SinhVien.noiSinh, SinhVien.ngaySinh, SinhVien.hocLuc
--e. Các đề tài không có sinh viên nào tham gia
use quanlythuctap
select DeTai.madt, Tendt, chuNhiem, kinhPhi from DeTai
inner join SinhVien_DeTai
on DeTai.madt = SinhVien_DeTai.madt
where DeTai.madt not in (select SinhVien_DeTai.madt from SinhVien_DeTai)
group by DeTai.madt, Tendt, chuNhiem, kinhPhi
--f. Danh sách các đề tài có sinh viên học giỏi nhất lớp tham gia

select DeTai.madt, Tendt, chuNhiem, kinhPhi from DeTai
join SinhVien_DeTai
on SinhVien_DeTai.madt = DeTai.madt
join SinhVien
on SinhVien_DeTai.masv = SinhVien.masv
where SinhVien.hocLuc = (select max(hocLuc) from SinhVien)
group by DeTai.madt, Tendt, chuNhiem, kinhPhi
--g. Danh sách các đề tài không có sinh viên học kém nhất lớp tham gia
select DeTai.madt, Tendt, chuNhiem, kinhPhi from DeTai
join SinhVien_DeTai
on SinhVien_DeTai.madt = DeTai.madt
join SinhVien
on SinhVien_DeTai.masv = SinhVien.masv
where SinhVien.hocLuc not in (select min(hocLuc) from SinhVien)
--h. Danh sách các sinh vien thực tập theo đề tài có kinh phí > 1/5 tổng kinh phí cho các đề tài
select hoTen, SinhVien.masv, noiSinh, ngaySinh, hocLuc from SinhVien
inner join SinhVien_DeTai
on SinhVien_DeTai.masv = SinhVien.masv
inner join DeTai
on SinhVien_DeTai.madt = DeTai.madt
where kinhPhi > sum(select kinhPhi from DeTai) / 5
--i. Danh sách các sinh viên có điểm học tập cao hơn điểm thực tập trung bình của đề tài có mã số là 1
select SinhVien.hoTen, SinhVien.masv, SinhVien.noiSinh, SinhVien.ngaySinh, SinhVien.hocLuc from SinhVien
join SinhVien_DeTai
on SinhVien.masv = SinhVien_DeTai.masv
group by SinhVien.hoTen, SinhVien.masv, SinhVien.noiSinh, SinhVien.ngaySinh, SinhVien.hocLuc
having SinhVien.hocLuc > avg(SinhVien_DeTai.ketQua)




