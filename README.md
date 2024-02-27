# backend-cloud-app
app.py สำหรับสร้าง route
controller.py สำหรับจัดการ string สำหรับ query หรืออื่นๆ

เราจะใช้ Dockerfile อันเดิมที่เราสร้าง
เราจะเปลี่ยนจาก docker run เปลี่ยนเป็นการ run จาก docker-compose.yml
เราจะ start service ด้วย (bulid และ run docker image)
    - docker-compose up -d --build
    - docker-compose down
    // only build
    - docker-compose build

start:
    - docker-compose up -d --build

หมายเหตุ ถ้าจะรัน python หรือติดตั้งต่างๆ ให้รันใน environment only (env)
เข้า ->  cd backend-cloud-app 
        env\Scripts\activate
ออก ->  deactivate