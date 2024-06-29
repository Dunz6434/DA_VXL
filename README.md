- Đây là đồ án vi xử lý - vi điều khiển, thiết kế xe tự hành sử dụng cảm biến hồng ngoại.
- Sơ đồ mạch:
  ![image](https://github.com/Dunz6434/DA_VXL/assets/152241773/501c561e-0af5-4749-9509-f0dd08872f88)
- Linh kiện:
  + Vi điều khiển AT89C52 sử dụng nguồn 5V.
  + Module điều khiển động cơ L298 với chân băm xung A, 4 chân input 1,2,3,4 và chân băm xung B lần lượt nối với P0.0 -> P0.5 sử dụng nguồn điện 12V.
  + Module cảm biến hồng ngoại IR Obstacle Sensor gửi tín hiệu 1 về vi điều khiển nếu phát hiện vật cản.
  + Gồm 4 motor, 2 motor điều khiển bởi chân băm xung A, 2 motor điều khiển bởi chân băm xung B.
  + Thạch anh hoạt động với tần số là 11.0592MHz.
  + Button chọn hướng trái phải.
- Mô tả hoạt động:
  + Khi không có tín hiệu hồng ngoại, xe bắt đầu chạy thẳng với Duty Cycle là 35%.
  + Khi có tín hiệu hồng ngoại, xe sẽ lùi lại cho đến khi không phát hiện vật cản.
  + Nếu nút chọn hướng không được nhấn, xe sẽ tự động rẽ trái trong 0.25s.
  + Nếu phát hiện vật cản xe sẽ tiếp tục lùi lại và rẽ trái cho đến khi xe không phát hiện vật cản thì sẽ chạy thẳng với tốc độ ban đầu.
  + Nếu nút chọn hướng được nhấn, xe sẽ rẽ phải thay vì rẽ trái. Chỉ khi nút nhấn được thả thì xe mới quay lại rẽ trái
    
