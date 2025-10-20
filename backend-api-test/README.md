# Backend API Test

Proyek ini dibuat sesuai tugas: API berbasis OOP (Java Spring Boot) dengan:
- Protocol: HTTP
- Method: GET
- Data format: JSON
- Response sesuai `viewData.json`
- Data diambil dari database (H2 in-memory) dengan `data.sql`

## Menjalankan
1. Jalankan perintah:
```
mvn spring-boot:run
```
2. Endpoint:
```
GET http://localhost:8080/api/transactions
```

Data example sudah dimasukkan lewat `src/main/resources/data.sql`.
