-- 1. Tạo CSDL Demo_02
Create database Demo_02;
-- 2. Sử dụng CSDL Demo_02 để tạo bảng
use Demo_02;
/* 3. Tạo bảng danh mục sản phẩm Category gồm các trường sau:
	- Catalog_id: int, khóa chính, tự tăng
    - Catalog_name: Tên danh mục - varchar(100) - not null - duy nhất
    - Priority: Độ ưu tiên - int - có giá trị lớn hơn 0
    - Catalog_status: Trạng thái danh mục - bit - giá trị mặc định là 1
    - primary key = not null + unique
    CREATE TABLE [TableName](
		[ColumnName] [Datatype] [Constraints]
    )
*/
Create table Category(
	Catalog_id int primary key auto_increment,
    Catalog_name varchar(100) not null unique,
    Priority int check(Priority>0),
    Catalog_status bit default(1)
)
/*
	4.
	Category 1:N Product 
    --> thiết kế CSDL sử dụng khóa ngoại tại bảng N (Product)
    Tạo bảng Product gồm các trường sau:
    - Product_id: Mã sản phẩm - char(4) - Khóa chính
    - Product_name: tên sản phẩm - varchar(100) - not null - Duy nhất
    - Price: Giá sản phẩm - float - not null - giá trị >0
    - Descriptions: Mô tả sản phẩm - text
    - Catalog_id: Mã danh mục mà sản phẩm thuộc về - int - khóa ngoại tham chiếu tới Category(Catalog_id)
    - Product_status: Trạng thái sản phẩm - bit
*/
Create table Product(
	product_id char(4) primary key,
    product_name varchar(100) not null unique,
    price float not null check(price>0),
    descriptions text,
    catalog_id int,
    -- Thêm khóa ngoại bảng product: nhận tên mặc định
    -- foreign key (catalog_id) references Category(catalog_id),
    -- Thêm khóa ngoại theo tên mình đặt
    constraint fk_product_category foreign key(catalog_id) references Category(catalog_id),
    product_status bit
)
-- 4. Xóa bảng Product
drop table product;
-- 5. Sửa bảng product
Create table Product(
	product_id char(4) ,
    product_name varchar(100)
);
-- Thêm cột Price có kiểu dữ liệu là float vào bảng product
alter table product
	add column price float;
-- Thêm cột catalog_id có kiểu dữ liệu là int vào bảng product
alter table product
	add column catalog_id int;
-- Thêm cột product_status có kiểu dữ liệu là bit vào bảng product
alter table product
	add column product_status bit;
-- Sửa cột product_status thành descriptions
alter table product
	rename column product_status to descriptions;
-- Sửa kiểu dữ liệu của descriptions từ bit thành text
alter table product
	modify column descriptions text;
-- Thêm rằng buộc not null cho trường product_name
alter table product
	modify column product_name varchar(100) not null;
-- Thêm rằng buộc unique cho trường product_name
alter table product
	add unique(product_name);
-- Xóa rằng buộc unique cho trường product_name
alter table product
	drop constraint product_name;
    
/*
	Tạo bảng Sinhvien, Môn học, điểm trong bài toán quản lý điểm
    SinhVien: masv - khóa chính, tensv, tuoi, trang_thai
    MonHoc: maMH - Khóa chính, tenMH, trang_thai
    Diem: masv, maMh, Điểm
    SinhVien 1:N Diem
    MonHoc 1:N Diem
*/
create table sinhvien(
	masv char(4),
    tensv varchar(50),
    tuoi int,
    trang_thai bit,
    primary key(masv)
);
create table monhoc(
	mamh char(4) primary key,
    tenmh varchar(50) not null unique,
    trang_thai bit
);
create table diem(
	masv char(4) not null,
    mamh char(4) not null,
    diem float,
    -- Định nghĩa các khóa ngoại và khóa chính
    foreign key(masv) references sinhvien(masv),
    foreign key(mamh) references monhoc(mamh),
    primary key(masv,mamh)
)

