    -- // select toàn bộ phường đã join--------------------------------------------------
SELECT 
    ward.Ward_id, 
    ward.Name AS Ward_Name, 
    district.Name AS District_Name, 
    city.Name AS City_Name
FROM 
    ward 
    INNER JOIN district ON ward.District = district.District_id
    INNER JOIN city ON district.City = city.City_id;



-- //insert buyer--------------------------------------------------
    INSERT INTO buyers (Name, Gender, Birth, Phone, Email, Password, Address, Ward, role) 
VALUES 
('Nguyễn Văn A', 1, '1990-01-01 00:00:00', '0123456789', 'nguyenvana@example.com', '123123', '123 Đường A', 1,   1),
('Trần Thị B', 2, '1992-02-02 00:00:00', '0987654321', 'tranthib@example.com', '123123', '456 Đường B', 2, 1),
('Lê Văn C', 1, '1988-03-03 00:00:00', '0123456790', 'levanc@example.com', '123123', '789 Đường C', 3, 1),
('Phạm Thị D', 2, '1995-04-04 00:00:00', '0987654320', 'phamthid@example.com',  '123123', '321 Đường D', 4,  1),
('Ngô Văn E', 1, '1985-05-05 00:00:00', '0123456791', 'ngovane@example.com','123123', '654 Đường E', 1, 1);

