use QLDiem

--4.	Truy vấn sử dụng hàm kết hợp: max, min, count, sum, avg và gom nhóm
-- câu 4.2
select count(*) 'Tổng Sinh Viên', sum(case when Phai = 1 then 1 else 0 end) 'Sinh viên nữ' 
from DMSV

-- câu 4.5
select HoSV 'Họ sinh viên', TenSV 'Tên sinh viên', sv.MaSV 'Mã sinh viên', count(distinct Mamh) as 'Số môn học'
from KetQua kq, DMSV sv
where sv.MaSV = kq.Masv
group by HoSV, TenSV, sv.MaSV

--4.6
select khoa.TenKhoa 'Tên khoa',max(sv.Hocbong) 'Học bổng cao nhất'
from DMSV sv, DMKhoa khoa
where khoa.Makhoa = sv.Makhoa
group by khoa.TenKhoa

--4.8
select year(getdate())-year(NgaySinh) 'Tuổi',count(MaSV) 'Số sinh viên'
from DMSV
group by year(getdate())-year(NgaySinh)

--4.9
select kq.Mamh 'Mã môn học', Tenmh 'Tên môn học', Lanthi 'Lần thi', 
			sum(case when Diem >= 5 then 1 else 0 end) 'Đậu',
			sum(case when Diem < 5 then 1 else 0 end) 'Rớt' 
from KetQua kq, DMMH mh
where mh.Mamh = kq.Mamh and Lanthi = 1
group by Lanthi, kq.Mamh, Tenmh

--5.Truy vấn theo điều kiện gom nhóm.
--5.3
select mh.Mamh 'Mã môn học', Tenmh 'Tên môn học', count(distinct Masv) 'Số lượng' from DMMh mh, KetQua kq
where mh.Mamh = kq.MaMH
group by mh.MaMH, TenMH
having count(distinct Masv) > 3

--5.4
select TenMH 'Tên môn học' ,count(masv) 'Số sinh viên đậu'
from KetQua kq,DMMH mh
where kq.MaMH=mh.MaMH and LanThi=1 and Diem>=5
group by TenMH

--5.5
select TenSV 'Tên sinh viên', sv.MaSV 'Mã sinh viên', AVG(Diem) 'Điểm trung bình'
from DMSV sv, KetQua kq
where sv.MaSV = kq.Masv and Lanthi = 1 and Phai = 0
group by TenSV, sv.MaSV
having AVG(Diem) > 7

--5.6
select TenSV 'Tên Sinh Viên', sv.MaSV 'Mã Sinh Viên'
from DMSV sv, KetQua kq
where sv.MaSV = kq.Masv and kq.Lanthi = 1 and kq.Diem < 5
group by TenSV, sv.MaSV
having count(kq.Lanthi) > 2

--5.7
select TenKhoa 'Tên Khoa', khoa.Makhoa 'Mã Khoa'
from DMSV sv, DMKhoa khoa
where sv.Makhoa = khoa.Makhoa and Phai = 0
group by TenKhoa, khoa.Makhoa
having count(sv.MaSV) > 2

--6. Truy vấn con trả về một giá trị
--5.2
select DMSV.HoSV 'Họ sinh viên', DMSV.TenSV 'Tên sinh viên', KetQua.Diem 'Điểm cơ sở dữ liệu'
from DMSV, KetQua
where DMSV.MaSV = KetQua.Masv and KetQua.diem = (select max(KetQua.Diem) from KetQua where KetQua.Mamh = '01') and LanThi = 1
group by DMSV.HoSV, DMSV.TenSV, KetQua.Diem

--5.3
select DMSV.HoSV, DMSV.TenSV, DMSV.MaSV, year(GETDATE()) - year(DMSV.NgaySinh) 'Tuổi'
from DMSV
where NgaySinh = (select min(NgaySinh) from DMSV where DMSV.Makhoa = 'AV')

--5.4
select HoSV 'Họ sinh viên', TenSV 'Tên sinh viên', DMSV.MaSV 'Mã sinh viên', Lanthi 'Lần thi', Diem 'Điểm' from DMSV, KetQua
where DMSV.MaSV = KetQua.Masv and Diem = (select min(Diem) 
											from KetQua, DMSV 
											where Lanthi = 1 and Mamh = '05' and Makhoa = 'AV')
group by DMSV.HoSV, DMSV.TenSV, DMSV.MaSV, KetQua.Lanthi, KetQua.Diem

--6. Truy vấn con trả về nhiều giá trị, sử dụng lượng từ IN, ALL, ANY, UNION, TOP
--6.2
select * from DMSV
where Hocbong > all (select HocBong from DMSV where Makhoa = 'AV')

--6.3
select * from DMSV
where Hocbong > any (select hocbong from DMSV where Makhoa = 'AV')

--6.4
select HoSV, TenSV, DMSV.Masv, Lanthi, Diem
from DMSV, KetQua
where DMSV.MaSV = KetQua.Masv and Lanthi = 2 and Mamh = '01' and Diem >  all (select Diem from KetQua where Mamh = '01' and Lanthi = 1)
group by DMSV.HoSv, DMSV.TenSV, DMSV.MaSV, KetQua.LanThi, KetQua.Diem

--7. Phép trừ

--7.2
select HoSV 'Họ sinh viên', TenSV 'Tên sinh viên', sv.MaSV 'Mã sinh viên', LanThi 'Lần thi', Diem 'Điểm'
from DMSV sv, KetQua kq
where sv.MaSV = kq.MaSV and Lanthi = 2 and not exists (select Lanthi 
															from KetQua 
															where Lanthi = 1 and KetQua.MaSV = sv.MaSV)
group by HoSV, TenSV, sv.MaSV, LanThi, Diem

--7.3
select TenMH 'Tên môn học', MaMH 'Mã môn học', DMMH.SoTiet 'Số tiết' from DMMH
where not exists (select sv.MaSV
					from DMSV sv, KetQua kq
					where kq.MaSV = sv.MaSV and sv.MaKhoa = 'AV' and DMMH.MaMH = kq.MaMH)
group by TenMH, MaMH, SoTiet

--7.4
select HoSV 'Họ sinh viên', TenSV 'Tên sinh viên', MaSV 'Mã sinh viên' from DMSV
where MaKhoa = 'AV' and not exists (select MaSV from KetQua
						where KetQua.MaSV = DMSV.MaSV and MaMH = '05')
group by HoSV, TenSV, DMSV.MaSV


create function thongkeSoLuongSV(@Makhoa char(2))
returns table as return
(select TenKhoa, khoa.MaKhoa, count(Masv) as 'Số Sinh Viên' from DMKhoa khoa, DMSV sv
where khoa.MaKhoa = sv.MaKhoa and khoa.MaKhoa = @Makhoa
group by TenKhoa, khoa.MaKhoa
)

select TenKhoa, [Số Sinh Viên] from thongKeSoLuongSV('AV')

use QuanLyKhoHang

create table tbl_KhoHang
(
	id int check(id >= 0),
	Mahang varchar(5) primary key,
	TenHang nvarchar(20),
	SoLuongTon int check(SoLuongTon >= 0)
)

create table tbl_DatHang
(
	id int primary key,
	MaHang varchar(5),
	SoLuongDat int check(SoLuongDat > 0),
	foreign key(MaHang) references tbl_KhoHang(MaHang)
)

insert into tbl_KhoHang
values (1, '1', 'Rau mùng tơi', 17)
insert into tbl_DatHang
values (1, '1', 5)
create trigger trig_DatHang on tbl_DatHang 
After insert as
begin
	update tbl_KhoHang
	set SoLuongTon = SoLuongTon - (
	select soLuongDat from inserted
	where MaHang = tbl_KhoHang.Mahang
	)
	from tbl_KhoHang
	join inserted on tbl_KhoHang.Mahang = inserted.MaHang
end
select * from tbl_KhoHang
insert into tbl_DatHang
values (2, '1', 15)

create procedure MyStoredProcedure as
set rowcount 10
select Diem from KetQua
Order by Diem desc
execute MyStoredProcedure


-- BÀI TẬP TUẦN 5 CỦA THẦY DZOAN 


use QuanLyHocPhan
create table HocPhan
(
	Mahp varchar(3) primary key,
	Tenhp nvarchar(20),
	Siso int
)
alter table HocPhan add constraint DF_HocPhan_SiSo default 0 for siso

create table DangKy
(
	Masv varchar(7) primary key,
	Mahp varchar(3)
	foreign key(Mahp) references HocPHan(Mahp)
)
CREATE PROCEDURE themDangKy @MASV varchar(10), @MAHP varchar(3)
AS
BEGIN
  -- Kiểm tra xem học phần có đủ sĩ số chưa
  DECLARE @SISO int;
  SELECT @SISO = SISO FROM HOCPHAN WHERE MAHP = @MAHP;
  IF @SISO >= 50
  BEGIN
    -- Nếu đủ sĩ số, hiển thị thông báo và thoát
    PRINT N'Học phần này đã đủ sĩ số, không thể đăng ký';
    RETURN;
  END
  ELSE
  BEGIN
    -- Nếu chưa đủ sĩ số, chèn dữ liệu vào bảng DANGKY
    INSERT INTO DANGKY (MASV, MAHP) VALUES (@MASV, @MAHP);
    -- Cập nhật sĩ số của học phần
    UPDATE HOCPHAN SET SISO = SISO + 1 WHERE MAHP = @MAHP;
    -- Hiển thị thông báo thành công
    PRINT N'Đăng ký học phần thành công';
  END
END

insert into HocPhan(Mahp, Tenhp)
values ('K01', 'CSDL')
select * from HocPhan
insert into DangKy
values ('5220027', 'K01'),
('5220028', 'K01')

-- I) Proc 1.2 Viết stored procedure truyền vào số nguyên N in ra số lượng số chẵn 
-- từ 0 đến N và tổng các số chẵn này.
create procedure inSoChan @N int
as
begin 
	declare @tmp int
	set @tmp = 0
	while @tmp <= @N 
	begin
		if @tmp % 2 = 0
		begin
			print @tmp + ' '
		end
		set @tmp = @tmp + 2
	end
end
exec inSoChan 8
--3. Xây dựng SP tính điểm trung bình và xếp loại cho sinh viên thuộc lớp cho trước. Giả sử có các quan hệ như sau:

--SINHVIEN (MASV, HOTEN, DTB, XEPLOAI, LOP)
--MONHOC (MAMH, TENMH)
--KETQUA (MAMH, MASV, LANTHI, DIEM)
--trong đó:

--Điểm thi chỉ tính lần thi sau cùng.
--Xếp loại: Xuất sắc [9, 10], Giỏi [8, 8.9], Khá [7, 7.9], Trung bình [5.0, 6.9], Yếu [0,4.9].
--Kết quả xuất dạng tham số output, không ghi xuống CSDL
create database SP_3
use SP_3

create table SinhVien
(
	MaSV varchar(8) primary key,
	HoTen varchar(40),
	DTB float,
	XepLoai varchar(7),
	Lop varchar(5),
)

create table MonHoc
(
	Mamh varchar(5) primary key,
	TenMonHoc varchar(30)
)

create table KetQua
(
	Mamh varchar(5),
	Masv varchar(8),
	LanThi int,
	Diem float
	Primary key(Mamh, Masv, Lanthi)
)
alter table KetQua add constraint FK_KetQua_Mamh Foreign key(Mamh) references MonHoc(Mamh),
constraint FK_KetQua_MaSV Foreign key(Masv) references SinhVien(Masv)

CREATE PROCEDURE TinhDTB_XepLoai
@Lop varchar(5)
as
begin
	CREATE TABLE #TempTable (
        MASV varchar(8),
        HOTEN varchar(40),
        DTB float,
        XEPLOAI varchar(5)
    )
	declare @Masv varchar(8), @hoten varchar(40), @dtb float, @xeploai varchar(5)
	declare sv_cursor cursor for 
		select MaSV, HoTen from SinhVien where Lop = @Lop
	open sv_cursor
	fetch next from sv_cursor into @Masv, @Hoten
	while @@fetch_status = 0 
	begin 
		select @DTB = avg(Diem) from (
			select KetQua.Mamh, max(lanthi) as lanthi_max  from KetQua
			where @masv = ketqua.Masv
			group by KetQua.Mamh
			) as lanthi_cuoi 
			inner join KetQua
			on lanthi_cuoi.Mamh = ketqua.Mamh and lanthi_cuoi.lanthi_max = KetQua.LanThi
												and KetQua.Masv = @Masv
		if @DTB between 9 and 10 set @xeploai = 'xsac'
		else if @DTB between 8 and 8.9 set @xeploai = 'gioi'
		else if @DTB between 7 and 7.9 set @xeploai = 'kha'
		else if @DTB between 5 and 6.9 set @xeploai = 'tb'
		else set @xeploai = 'yeu'
		insert into #TempTable
		values (@Masv, @hoten, @dtb, @xeploai)
		fetch next from sv_cursor into @Masv, @HoTen
	end
	close sv_cursor
	deallocate sv_cursor
	select * from #TempTable
	drop table #TempTable
end
-- Gọi SP với mã lớp là CNTT1 để kiểm tra kết quả
EXEC TinhDTB_XepLoai 'CNTT1'
insert into SinhVien
values ('52200277', 'DM', 8.5, 'Gioi', 'CNTT1'),
('52200278', 'AM', 7.5, 'Gioi', 'CNTT1'),
('52200279', 'EM', 6.5, 'Kha', 'CNTT1')
insert into MonHoc
values ('CSDL', 'CO SO DU LIEU'),
('TCC', 'TOAN CAO CAP'),
('TR', 'TRIET HOC'),
('THVP', 'Tin Hoc Van Phong')
insert into KetQua
values ('CSDL', '52200277', 1, 7.6),
('CSDL', '52200277', 2, 9.2),
('TCC', '52200278', 1, 5.5),
('TCC', '52200277', 1, 7.6),
('TCC', '52200278', 2, 9.5)

exec TinhDTB_XepLoai 'CNTT1'

create table nhanvien
(
	manv nvarchar (10) primary key,
	honv nvarchar (20),
	tennv nvarchar (20),
	luong smallint,
	phai bit,
	ngaysinh smalldatetime,
	macv varchar (10),
	madv varchar (10)
)
create table donvi
(
	madv varchar (10) primary key,
	tendv nvarchar (10),
	chucnang nvarchar (20)
)
create table chucvu
(
	macv varchar (10) primary key,
	tencv nvarchar (10),
	muctrocap float
)
alter table nhanvien add constraint fk_nhanvien_donvi foreign key (madv) references donvi (madv)
alter table nhanvien add constraint fk_nhanvien_chucvu foreign key (macv) references chucvu (macv)
set dateformat DMY
insert into donvi (madv, tendv, chucnang) values ('KT', 'Kế toán', 'Kiểm kê tc')
insert into donvi (madv, tendv, chucnang) values ('CV', 'Cố vấn', 'Cố vấn kt')
insert into chucvu (macv, tencv, muctrocap) values ('QL', 'Quản lí', 2.0)
insert into chucvu (macv, tencv, muctrocap) values ('NV', 'Nhân viên', 1.5)
insert into nhanvien (manv, honv, tennv, luong, phai, ngaysinh, macv, madv) values ('001',N'Nguyễn Hoàng', N'Huy', 1000, 0,'21/07/2004','QL','KT')
insert into nhanvien (manv, honv, tennv, luong, phai, ngaysinh, macv, madv) values ('002',N'Nguyễn Nhật', N'Minh', 2000, 0,'21/08/2004','NV','KT')
insert into nhanvien (manv, honv, tennv, luong, phai, ngaysinh, macv, madv) values ('003',N'Nguyễn Thị', N'Kiều', 1000, 0,'21/09/2004','NV','CV')
insert into nhanvien (manv, honv, tennv, luong, phai, ngaysinh, macv, madv) values ('004',N'Lê Thị Nhật', N'Anh', 1000, 0,'21/10/2004','NV','CV')
go
create function fn_thongke_donvi (@dv varchar (10))
returns @bangthongke table (madv varchar (10) , soluong int)
as
begin 
if (@dv not in (select madv from donvi))
	insert into @bangthongke select nhanvien.madv, count (manv) from nhanvien inner join donvi on nhanvien.madv = donvi.madv group by nhanvien.madv
else
	insert into @bangthongke select nhanvien.madv, count (manv) from nhanvien inner join donvi on nhanvien.madv = donvi.madv where @dv = nhanvien.madv group by nhanvien.madv
	return 
end
go
select * from dbo.fn_thongke_donvi('CV')

go
create function fn_Danhsachnhanvien (@macv varchar (10))
returns table as return (select * from nhanvien where @macv = macv)
go
select * from dbo.fn_Danhsachnhanvien('QL')
