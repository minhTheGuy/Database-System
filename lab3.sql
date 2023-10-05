create database QLNV

use QLNV

create table Phong
(
	MaPhong char(3) primary key, -- mã phòng ban
	TenPhong nvarchar(40), --Tên phòng ban
	DiaChi nvarchar(50), -- Địa chỉ phòng ban
	Tel char(10) -- số điện thoại
)

create table DMNN
(
	MaNN char(2) primary key, --Mã ngoại ngữ
	TenNN nvarchar(20) --Tên ngoại ngữ
)

create table NhanVien
(
	MaNV char(5) primary key, -- Mã nhân viên
	HoTen nvarchar(40), -- Họ và Tên
	GioiTinh char(3), -- Giới tính
	NgaySinh datetime, -- Ngày sinh
	Luong int, -- Lương chính
	MaPhong char(3), -- Mã phòng ban
	SDT char(10), -- Số điện thoại
	NgayBC datetime -- Ngày vào biên chế
)
alter table NhanVien add constraint FK_NhanVien_MaPhong Foreign key(MaPhong) references Phong(MaPhong)

create table TDNN
(
	MaNV char(5), -- Mã nhân viên
	MaNN char(2), -- Mã ngoại ngữ
	TDO char(1) -- Trình độ ngoại ngữ
)
alter table TDNN add constraint FK_TDNN_MaNV Foreign key(MaNV) references NhanVien(MaNV),
constraint FK_TDNN_MaNN Foreign key(MaNN) references DMNN(MaNN)

insert into Phong
select 'HCA', N'Hành chính tổ hợp', N'123, Láng Hạ, Đống Đa, Hà Nội', '04 8585793' Union all
select 'KDA', N'Kinh Doanh', N'123, Láng Hạ, Đống Đa, Hà Nội', '04 8574943' Union all
select 'KTA', N'Kỹ thuật', N'123, Láng Hạ, Đống Đa, Hà Nội', '04 9480485' Union all
select 'QTA', N'Quản trị',N'123, Láng Hạ, Đống Đa, Hà Nội', '04 8508585'

insert into DMNN
select '01',N'Anh' Union all
select '02',N'Nga' Union all
select '03', N'Pháp' Union all
select '04', N'Nhật' Union all
select '05', N'Trung Quốc' Union all
select '06', N'Hàn Quốc'

SET DATEFORMAT MDY

insert into NhanVien(MaNV,HoTen, GioiTinh, NgaySinh, Luong, MaPhong, NgayBC)
select 'HC001', N'Nguyễn Thị Hà', 'Nu', '8/27/1950', 2500000, 'HCA', '2/8/1975' Union all
select 'HC002', N'Trần Văn Nam', 'Nam', '6/12/1975', 3000000, 'HCA', '6/8/1997' Union all
select 'HC003', N'Nguyễn Thanh Huyền', 'Nu', '7/3/1978', 1500000, 'HCA', '9/24/1999' Union all
select 'KD001', N'Lê Tuyết Anh', 'Nu', '2/3/1977', 2500000, 'KDA', '10/2/2001' Union all
select 'KD002', N'Nguyễn Anh Tú', 'Nam', '7/4/1942' ,2600000 ,'KDA' ,'9/24/1999' Union all
select 'KD003' ,N'Phạm An Thái' ,'Nam' ,'5/9/1977' ,1600000 ,'KDA' ,'9/24/1999' Union all
select 'KD004' ,N'Lê Văn Hải' ,'Nam' ,'1/2/1976' ,2700000 ,'KDA' ,'6/8/1997' Union all
select 'KD005' ,N'Nguyễn Phương Minh' ,'Nam' ,'1/2/1980' ,2000000 ,'KDA' ,'10/2/2001' Union all
select 'KT001' ,N'Trần Đình Khâm' ,'Nam' ,'12/2/1981' ,2700000 ,'KTA' ,'1/1/2005' Union all
select 'KT002' ,N'Nguyễn Mạnh Hùng' ,'Nam' ,'8/16/1980' ,2300000 ,'KTA' ,'1/1/2005' Union all
select 'KT003' ,N'Phạm Thanh Sơn' ,'Nam' ,'8/20/1984' ,2000000 ,'KTA' ,'1/1/2005' Union all
select 'KT004' ,N'Vũ Thị Hoài' ,'Nu' ,'12/5/1980' ,2500000 ,'KTA' ,'10/2/2001' Union all
select 'KT005' ,N'Nguyễn Thu Lan' ,'Nu','10/5/1977',3000000,'KTA','10/2/2001' Union all
select 'KT006' ,N'Trần Hoài Nam' ,'Nam','7/2/1978',2800000,'KTA',' 6/8/1997' Union all
select 'KT007' ,N'Hoàng Nam Sơn','Nam','12/3/1940',3000000 ,'KTA','7/2/1965'Union all
select 'KT008',N'Lê Thu Trang','Nu','7/6/1950',2500000,'KTA','8/2/1968' Union all
select 'KT009',N'Khúc Nam Hải','Nam','7/22/1980',2000000,'KTA','1/1/2005' Union all
select 'KT010',N'Phùng Trung Dũng','Nam','8/28/1978',2200000,'KTA','9/24/1999'

insert into TDNN
select 'HC001', '01' ,'A' Union all
select 'KD004' ,'05' ,'A' Union all
select 'HC001' ,'02' ,'B' Union all
select 'KD005' ,'01' ,'B' Union all
select 'HC002' ,'01' ,'C' Union all
select 'KD005' ,'02' ,'D' Union all
select 'HC003' ,'01' ,'D' Union all
select 'KD005' ,'04' ,'B' Union all
select 'KD001' ,'01' ,'C' Union all
select 'KT001' ,'01' ,'D' Union all
select 'KD001' ,'02' ,'B' Union all
select 'KT001' ,'04' ,'E' Union all
select 'KD002' ,'01' ,'D' Union all
select 'KT002' ,'01' ,'C' Union all
select 'KD002' ,'02' ,'A' Union all
select 'KT002' ,'02' ,'B' Union all
select 'KD003' ,'01' ,'B' Union all
select 'KT003' ,'01' ,'D' Union all
select 'KD003' ,'02' ,'C' Union all
select 'KT003' ,'03' ,'C' Union all
select 'KD004' ,'01' ,'C' Union all
select 'KT004' ,'01' ,'D' Union all
select 'KD004' ,'04' ,'A' Union all
select 'KT005' ,'01' ,'C'
-- Bài 3: 
insert into NhanVien(MaNV, HoTen, GioiTinh, NgaySinh, Luong, MaPhong, NgayBC)
values ('QT001', N'Nguyễn Huỳnh Đăng Minh', 'Nam', '12/13/2004', 150000, 'QTA', getdate())
insert into TDNN
values ('QT001', '01', 'C'),
		('QT001', '04', 'A')
select HoTen, Phong.TenPhong, DMNN.TenNN, Luong from NhanVien
join Phong
on Phong.MaPhong = NhanVien.MaPhong
join TDNN
on TDNN.MaNV = NhanVien.MaNV
join DMNN
on TDNN.MaNN = DMNN.MaNN

-- Bài 4:
-- c1: Đưa ra thông tin của nhân viên có mã số KT001?
select * from NhanVien
where MaNV = 'KT001'

-- c2: Hãy sửa họ tên nhân viên trên thành ký tự tiếng Việt (Unicode)
update NhanVien
set HoTen = N'Nguyễn Thị Hà' where MaNV = 'HC001'
update NhanVien 
set HoTen = N'Trần Văn Nam' where MaNV = 'HC002' 
update NhanVien
set HoTen = N'Nguyễn Thanh Huyền' where MaNV = 'HC003'
update NhanVien
set HoTen = N'Lê Tuyết Anh' where MaNV = 'KD001' 
update NhanVien
set HoTen = N'Nguyễn Anh Tú' where MaNV = 'KD002'
update NhanVien
set HoTen = N'Phạm An Thái' where MaNV = 'KD003'
update NhanVien 
set HoTen = N'Lê Văn Hải' where MaNV = 'KD004'
update NhanVien
set HoTen = N'Nguyễn Phương Minh' where MaNV = 'KD005'
update NhanVien
set HoTen = N'Trần Đình Khâm' where MaNV = 'KT001'
update NhanVien
set HoTen = N'Nguyễn Mạnh Hùng' where MaNV = 'KT002'
update NhanVien
set HoTen = N'Phạm Thanh Sơn' where MaNV = 'KT003'
update NhanVien
set HoTen = N'Vũ Thị Hoài' where MaNV = 'KT004'
update NhanVien
set HoTen = N'Nguyễn Thu Lan' where MaNV = 'KT005'
update NhanVien
set HoTen = N'Trần Hoài Nam' where MaNV = 'KT006' 
update NhanVien
set HoTen = N'Hoàng Nam Sơn' where MaNV = 'KT007'
update NhanVien
set HoTen = 'Lê Thu Trang' where MaNV = 'KT008'
update NhanVien
set HoTen = N'Khúc Nam Hải' where MaNV = 'KT009'
update NhanVien
set HoTen = 'Phùng Trung Dũng' where MaNV = 'KT010'
-- c3 : Đưa ra danh sách các sinh viên nữ
select * from NhanVien
where GioiTinh = 'Nu'

-- c4 : Tìm những nhân viên có họ Nguyễn
select * from NhanVien
where HoTen like N'Nguyễn%'

-- c5 : Đưa ra danh sách các nhân viên có tên chứa từ ‘Văn’
select * from NhanVien
where HoTen like N'%Văn%'

-- c6 : Đưa ra những nhân viên có tuổi dưới 30? (Đưa ra cả thông tin tuổi trong kết quả)
select *, year(getdate()) - year(NgaySinh) 'Tuổi' from NhanVien
where year(getdate()) - year(NgaySinh) < 30

-- c7 : Đưa ra danh sách các nhân viên có tuổi nằm trong khoảng 25 đến 30 tuổi? (Đưa
-- ra cả thông tin tuổi trong kết quả)
select *, year(getdate()) - year(NgaySinh) 'Tuổi' from NhanVien
where year(getdate()) - year(NgaySinh) between 25 and 30

-- c8 : Đưa ra các mã nhân viên đã học các ngoại ngữ 01 ở trình độ C trở lên?
select MaNV from TDNN
where MaNN = '01' and TDO in ('A', 'B', 'C')

-- c9 : Đưa ra danh sách các nhân viên vào biên chế trước năm 2000?
select * from NhanVien
where year(NgayBC) < 2000

-- c10 : Đưa ra danh sách các nhân viên đã vào biên chế hơn 10 năm?
select * from NhanVien 
where year(getdate()) - year(NgayBC) > 10

-- c11 : Đưa ra danh sách các nhân viên năm nay đủ tuổi nghỉ hưu (Nam >=60 tuổi, Nữ >=55 tuổi)?
select *, year(getdate()) - year(NgaySinh)'Tuổi' from NhanVien
where (case
			when GioiTinh = 'Nam' then 60 - (year(getdate()) - year(NgaySinh))
			else 55 - (year(getdate()) - year(NgaySinh))
		end) <= 0 

-- c12 : Cho biết thông tin (Mã phòng, tên phòng, điện thoại liên hệ) về các phòng ban?
select MaPhong, TenPhong, Tel from Phong

-- c13 : Đưa ra thông tin (họ tên, ngày sinh, ngày vào biên chế) về 2 nhân viên đầu tiên
-- trong bảng nhân viên?
select top 2 * from NhanVien
order by year(NgayBC) asc

-- c14 : Cho biết mã nhân viên, họ tên, ngày sinh, lương của các nhân viên có lương nằm
-- trong khoảng từ 2000000 đồng đến 3000000 đồng?
select MaNV, HoTen, NgaySinh, Luong
from NhanVien
where Luong between 2000000 and 3000000

-- c15: Đưa ra danh sách các nhân viên chưa có số điện thoại?
select * from NhanVien
where SDT is null

-- c16: Đưa ra danh sách các nhân viên sinh nhật trong tháng 3
select * from NhanVien
where datepart(m, NgaySinh) = 3

-- c17: Hãy đưa ra danh sách nhân viên theo theo chiều tăng dần của lương?
select * from NhanVien
order by Luong asc

-- c18: Cho biết lương trung bình của phòng Kinh doanh?
select avg(Luong) 'Lương Trung Bình'
from Phong
join NhanVien
On NhanVien.MaPhong = Phong.MaPhong
where NhanVien.MaPhong = 'KDA'

-- c19 :Cho biết tổng số nhân viên và trung bình lương phòng Kinh doanh?
select count(MaNV) 'Tổng số nhân viên', avg(Luong) 'Trung Bình Lương'
from Phong
Join NhanVien
On Phong.MaPhong = NhanVien.MaPhong
where NhanVien.MaPhong = 'KDA'

-- c20 : Cho biết tổng lương của mỗi phòng?
select TenPhong, avg(Luong)
from Phong
Join NhanVien
On Phong.MaPhong = NhanVien.MaPhong
group by TenPhong

-- c21 : Cho biết các phòng có tổng lương lớn hơn 500.0000?
select TenPhong, sum(Luong) 'Tổng Lương'
from Phong
join NhanVien
On Phong.MaPhong = NhanVien.MaPhong
group by TenPhong
having sum(Luong) > 500000

-- c22 : Cho biết danh sách mã nhân viên, họ tên, mã phòng và tên phòng họ làm việc?
select MaNV, HoTen, Phong.MaPhong, TenPhong
from Phong
Join NhanVien
On Phong.MaPhong = NhanVien.MaPhong
group by MaNV, HoTen, Phong.MaPhong, TenPhong

-- c23 : Đưa ra danh sách tất cả các nhân viên cùng với thông tin về phòng ban của họ
-- (kể cả các nhân viên chưa ở phòng nào)?
select *
from NhanVien
left Join Phong
On Phong.MaPhong = NhanVien.MaPhong

-- c24 : Đưa ra danh sách tất cả các phòng cùng với thông tin về các nhân viên của các
-- phòng (kể cả các phòng chưa có nhân viên nào)?
select * 
from Phong
left Join NhanVien
On Phong.MaPhong = NhanVien.MaPhong