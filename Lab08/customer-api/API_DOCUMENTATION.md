# Customer API Documentation

## Base URL
`http://localhost:8080/api/customers`

## Endpoints

### 1. Get All Customers (with pagination & sorting)
**GET** `/api/customers`

Query params:
- `page` (default: 0)
- `size` (default: 10)
- `sortBy` (default: `id`)
- `sortDir` (`asc`/`desc`, default: `asc`)

**Response:** 200 OK
```json
{
  "customers": [
    {
      "id": 1,
      "customerCode": "C001",
      "fullName": "John Doe",
      "email": "john@example.com",
      "phone": "+1-555-1234",
      "address": "123 Street",
      "status": "ACTIVE",
      "createdAt": "2024-11-03T10:00:00"
    }
  ],
  "currentPage": 0,
  "totalItems": 1,
  "totalPages": 1
}
```

### 2. Get Customer by ID
**GET** `/api/customers/{id}`

**Response:** 200 OK
```json
{
  "id": 1,
  "customerCode": "C001",
  "fullName": "John Doe",
  "email": "john@example.com",
  "phone": "+1-555-1234",
  "address": "123 Street",
  "status": "ACTIVE",
  "createdAt": "2024-11-03T10:00:00"
}
```

**Error 404 Not Found**
```json
{
  "timestamp": "2024-11-03T10:00:00",
  "status": 404,
  "error": "Not Found",
  "message": "Customer not found with id: 99",
  "path": "/api/customers/99"
}
```

### 3. Create Customer
**POST** `/api/customers`

Body (JSON):
```json
{
  "customerCode": "C001",
  "fullName": "John Doe",
  "email": "john@example.com",
  "phone": "+1-555-1234",
  "address": "123 Street",
  "status": "ACTIVE"
}
```

**Response:** 201 Created (returns created customer)

**Error 400 Validation**
```json
{
  "timestamp": "2024-11-03T10:00:00",
  "status": 400,
  "error": "Bad Request",
  "message": "Validation failed",
  "path": "/api/customers",
  "details": [
    "email: Email must be a valid email address",
    "customerCode: Customer code must start with 'C' followed by at least 3 digits"
  ]
}
```

**Error 409 Conflict (duplicate)**
```json
{
  "timestamp": "2024-11-03T10:00:00",
  "status": 409,
  "error": "Conflict",
  "message": "Email already exists",
  "path": "/api/customers"
}
```

### 4. Update Customer (full)
**PUT** `/api/customers/{id}`

Body: same fields as create (all required)

**Response:** 200 OK (returns updated customer)

### 5. Partial Update (PATCH)
**PATCH** `/api/customers/{id}`

Body (any subset of fields):
```json
{
  "fullName": "John Partially Updated"
}
```
**Response:** 200 OK (returns updated customer)

### 6. Delete Customer
**DELETE** `/api/customers/{id}`

**Response:** 200 OK
```json
{ "message": "Customer deleted successfully" }
```

### 7. Search by Keyword
**GET** `/api/customers/search?keyword=john`

**Response:** 200 OK (array of matching customers)

### 8. Filter by Status
**GET** `/api/customers/status/{status}`

`status` = `ACTIVE` or `INACTIVE`

**Response:** 200 OK (array of matching customers)

### 9. Advanced Search (optional params)
**GET** `/api/customers/advanced-search?name=John&email=gmail&status=ACTIVE`

All params optional; returns customers matching provided filters.

---

## Error Response Examples

- **400 Bad Request (validation)** – see example under Create.
- **404 Not Found** – see example under Get by ID.
- **409 Conflict (duplicate)** – see example under Create.
- **500 Internal Server Error**
```json
{
  "timestamp": "2024-11-03T10:00:00",
  "status": 500,
  "error": "Internal Server Error",
  "message": "Unexpected error",
  "path": "/api/customers"
}
```
