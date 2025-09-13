# Tạo Người Dùng

## Lưu Ý
- Để tạo được người dùng cần có `default.props`
- Cơ sở dữ liệu
- authUser.skipEmailValidation=true

## ⚙️ Cấu Hình

### Cài Đặt Cần Thiết

Chỉnh sửa `obp-api/src/main/resources/props/default.props`:

```properties
# Cấu hình cơ bản
connector=mapped
hostname=http://127.0.0.1:8080

# Cơ sở dữ liệu (H2 cho phát triển)
db.driver=org.h2.Driver
db.url=jdbc:h2:./lift_proto.db;NON_KEYWORDS=VALUE;DB_CLOSE_ON_EXIT=FALSE

# Xác thực Email (Phát triển)
authUser.skipEmailValidation=true

# Tính năng Sandbox
allow_sandbox_account_creation=true
allow_sandbox_data_import=true
consumers_enabled_by_default=true
```

### Cấu Hình Cơ Sở Dữ Liệu

#### H2 Database (Mặc định)
```properties
db.driver=org.h2.Driver
db.url=jdbc:h2:./lift_proto.db;NON_KEYWORDS=VALUE;DB_CLOSE_ON_EXIT=FALSE
```

#### PostgreSQL
```properties
db.driver=org.postgresql.Driver
db.url=jdbc:postgresql://localhost:5432/obpdb?user=obp&password=daniel.says
```

#### MySQL
```properties
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/dbname?user=your-username&password=your-password&verifyServerCertificate=false&useSSL=true&serverTimezone=UTC
```

## 📧 Bỏ Qua Xác Thực Email

Để mục đích phát triển, bạn có thể bỏ qua xác thực email:

### Phương pháp 1: File Props
```properties
# Trong default.props
authUser.skipEmailValidation=true
```

### Phương pháp 2: Biến Môi Trường
```bash
export OBP_AUTH_USER_SKIP_EMAIL_VALIDATION=true
```
