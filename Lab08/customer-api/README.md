# Customer API

## Student Information
- **Name:** Nguyễn Hà Thanh
- **Student ID:** ITITIU21144
- **Class:** Monday Morning Lab 

## API Endpoints

### Base URL
`http://localhost:8080/api/customers`

### Endpoints Implemented
- [x] GET /api/customers — Get all customers (pagination + sorting)
- [x] GET /api/customers/{id} — Get by ID
- [x] POST /api/customers — Create customer
- [x] PUT /api/customers/{id} — Update customer
- [x] PATCH /api/customers/{id} — Partial update
- [x] DELETE /api/customers/{id} — Delete customer
- [x] GET /api/customers/search?keyword={keyword} — Search
- [x] GET /api/customers/status/{status} — Filter by status
- [x] GET /api/customers/advanced-search — Filter by name/email/status

### Bonus Features
- [x] HATEOAS links on GET by ID
- [x] Rate limiting with Bucket4j (100 req/min per IP)

## How to Run
1. Create database: `customer_management`
2. Update `src/main/resources/application.properties` with your MySQL credentials
3. Build/run: `mvn spring-boot:run`
4. Test with Thunder Client/Postman or curl
5. (Optional) Import collection: `Customer_API.postman_collection.json`

## Testing
- Manual tests run via Thunder Client/Postman for CRUD, search, filters, pagination, sorting, PATCH, and error scenarios.
- Rate limiting validated by exceeding 100 req/min per IP (returns 429).

## Features Implemented
- DTO pattern for request/response
- Validation with `@Valid`
- Exception handling with `@RestControllerAdvice`
- Custom exceptions (404, 409) with structured error responses
- Search and filter (keyword, status, advanced multi-field)
- Pagination and sorting on list endpoint
- Partial update (PATCH)
- HATEOAS links in detail response
- Rate limiting (Bucket4j)

## Known Issues
- None observed

## Time Spent
- Approximately [3] hours
