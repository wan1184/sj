<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>หอพักสุขใจ - ระบบจองห้องพัก</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Sarabun:wght@300;400;700&display=swap');
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Sarabun', sans-serif; }
        body { background: #f4f4f4; color: #333; text-align: center; margin: 0; padding: 0; }
        .hero { position: relative; width: 100%; height: 100vh; background: url('bg1.jpg') no-repeat center center/cover; transition: background 1s ease-in-out; }
        .overlay { position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.6); }
        .content { position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); text-align: center; color: white; }
        h1 { font-size: 3rem; font-weight: 700; margin-bottom: 10px; }
        p { font-size: 1.5rem; margin: 10px 0; font-weight: 300; }
        .btn { display: inline-block; padding: 10px 20px; font-size: 1rem; color: white; background: #2980b9; text-decoration: none; border-radius: 5px; transition: background 0.3s ease; }
        .btn:hover { background: #1a669a; }
        .container { width: 80%; max-width: 1200px; margin: 50px auto; text-align: center; }
        .room-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px; margin-top: 20px; }
        .room-card { background: white; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); padding: 20px; text-align: left; display: flex; align-items: center; gap: 15px; transition: transform 0.3s ease; }
        .room-card:hover { transform: scale(1.05); }
        .room-info { flex-grow: 1; }
        .room-type { font-size: 1.2rem; font-weight: bold; color: #2c3e50; }
        .room-price { color: #e67e22; font-weight: bold; }
        .book-btn { display: inline-block; padding: 8px 18px; font-size: 1rem; color: white; background: #2980b9; border: none; border-radius: 5px; cursor: pointer; transition: background 0.3s ease; }
        .book-btn:hover { background: #1a669a; }
        .form-container { text-align: left; margin-top: 20px; padding: 30px; background: white; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); width: 50%; margin: 20px auto; }
        .form-container input, .form-container select { width: 100%; padding: 12px; margin: 10px 0; border: 1px solid #ccc; border-radius: 5px; font-size: 1rem; }
        .form-container label { font-weight: bold; font-size: 1.1rem; }
        .form-container button { width: 100%; padding: 10px; font-size: 1.1rem; color: white; background: #2980b9; border: none; border-radius: 5px; cursor: pointer; transition: background 0.3s ease; }
        .form-container button:hover { background: #1a669a; }
        .payment-container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); margin: 20px auto; width: 50%; text-align: left; }
        .payment-container button { width: 100%; padding: 10px; font-size: 1.1rem; color: white; background: #27ae60; border: none; border-radius: 5px; transition: background 0.3s ease; }
        .payment-container button:hover { background: #1c7d47; }
        .payment-success { color: green; font-size: 1.5rem; font-weight: bold; margin-top: 20px; }
        .line-info { margin-top: 20px; font-size: 1.2rem; color: #2c3e50; }
        .line-info a { color: #2980b9; text-decoration: none; }
        .btn-container { display: flex; gap: 10px; justify-content: center; }
        .btn-container button { flex: 1; }
    </style>
</head>
<body>
    <div id="homepage">
        <div class="hero">
            <div class="overlay"></div>
            <div class="content">
                <h1>ยินดีต้อนรับสู่ หอพักสุขใจ</h1>
                <p>ห้องพักสะอาด ปลอดภัย บรรยากาศดี</p>
                <button class="btn" onclick="showBooking()">เข้าสู่เว็บไซต์</button>
            </div>
        </div>
    </div>
    <div id="bookingPage" style="display:none;">
        <div class="container">
            <h1>เลือกห้องพักของคุณ</h1>
            <div class="room-grid">
                <script>
                    for(let i=1; i<=20; i++){
                        let type=i<=10?"ห้องแอร์":"ห้องพัดลม";
                        let floor=i<=10?1:2;
                        let price=i<=10?2500:2000;
                        document.write(`
                            <div class="room-card">
                                <div class="room-info">
                                    <div class="room-type">${type} - ห้อง ${i}</div>
                                    <div>ชั้น ${floor}</div>
                                    <div class="room-price">${price} บาท/เดือน</div>
                                    <button class="book-btn" onclick="showRoomDetails(${i}, '${type}', ${floor}, ${price})">จอง!</button>
                                </div>
                            </div>
                        `);
                    }
                </script>
            </div>
        </div>
    </div>
    <div id="roomDetails" class="form-container" style="display:none;">
        <h2>กรุณากรอกข้อมูลเพื่อจองห้องพัก</h2>
        <form id="bookingForm">
            <label for="checkInDate">เลือกวันที่เช็คอิน:</label>
            <input type="date" id="checkInDate" name="checkInDate" required>
            
            <label for="name">ชื่อ:</label>
            <input type="text" id="name" name="name" required>
            
            <label for="surname">นามสกุล:</label>
            <input type="text" id="surname" name="surname" required>
            
            <label for="phone">เบอร์โทร:</label>
            <input type="tel" id="phone" name="phone" placeholder="XXX-XXX-XXXX" pattern="\d{3}-\d{3}-\d{4}" required>
            
            <label for="idCard">บัตรประชาชน:</label>
            <input type="text" id="idCard" name="idCard" placeholder="12312312121" required>
            
            <label for="email">อีเมล์:</label>
            <input type="email" id="email" name="email" required>
            
            <div class="btn-container">
                <button type="button" onclick="showPaymentPage()">ยืนยันการจอง</button>
                <button type="button" onclick="goBack()">ย้อนกลับ</button>
            </div>
        </form>
    </div>
    <div id="paymentPage" class="payment-container" style="display:none;">
        <h2>วิธีการชำระเงิน</h2>
        <p>จำนวนเงินที่ต้องชำระ: <span id="paymentAmount"></span> บาท</p>
        <div class="btn-container">
            <button onclick="paymentSuccess()">ชำระผ่านวอลเล็ท</button>
            <button onclick="paymentSuccess()">ชำระผ่านบัญชีธนาคารออนไลน์</button>
        </div>
        <div class="line-info">ติดต่อ Line: <a href="https://line.me/ti/p/@muwaneiei">@muwaneiei</a> เพื่อข้อมูลเพิ่มเติม</div>
    </div>
    <div id="paymentSuccess" class="payment-success" style="display:none;">
        <p>ชำระเงินสำเร็จแล้ว</p>
    </div>
    <script>
        let selectedRoomPrice = 0;
        function showBooking() { document.getElementById("homepage").style.display = "none"; document.getElementById("bookingPage").style.display = "block"; }
        function showRoomDetails(roomNumber, type, floor, price) { 
            selectedRoomPrice = price; 
            document.getElementById("bookingPage").style.display = "none"; 
            document.getElementById("roomDetails").style.display = "block"; 
        }
        function showPaymentPage() {
            if(document.getElementById("bookingForm").checkValidity()) { 
                document.getElementById("roomDetails").style.display = "none"; 
                document.getElementById("paymentPage").style.display = "block"; 
                document.getElementById("paymentAmount").innerText = selectedRoomPrice; 
            }
        }
        function paymentSuccess() { 
            document.getElementById("paymentPage").style.display = "none"; 
            document.getElementById("paymentSuccess").style.display = "block"; 
        }
        function goBack() { document.getElementById("roomDetails").style.display = "none"; document.getElementById("bookingPage").style.display = "block"; }
    </script>
</body>
</html>
