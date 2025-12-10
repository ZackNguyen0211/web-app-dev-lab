# Product Management System

## Student Information
- **Name:** Nguyễn Hà Thanh
- **Student ID:** ITITIU21144
- **Class:** Monday Morning Lab 

## Technologies Used
- Spring Boot 3.3.x
- Spring Data JPA
- MySQL 8.0
- Thymeleaf
- Maven

## Setup Instructions
1. Import project into VS Code (or your preferred IDE).
2. Create database: `product_management`.
3. Update `src/main/resources/application.properties` with your MySQL credentials.
4. Run: `mvn spring-boot:run`.
5. Open browser: http://localhost:8080/products.

## Completed Features
- [x] CRUD operations
- [x] Search functionality
- [x] Advanced search with filters
- [x] Validation
- [x] Sorting
- [x] Pagination
- [x] REST API (Bonus)

## Project Structure
- `src/main/java/com/example/productmanagement` — application code (config, controllers, services, repository, entities)
- `src/main/resources/templates` — Thymeleaf templates
- `src/main/resources/application.properties` — application configuration

## Database Schema
See `product_management.sql` for database structure.

## Known Issues
- Image upload writes to local `uploads/` folder; ensure the app has write permissions in the run directory.
- Database connection requires `allowPublicKeyRetrieval=true` in JDBC URL for some MySQL setups.
- No authentication/authorization; all operations are open.

## Time Spent
Approximately [3] hours

## Screenshots
See `Lab07-Picture-Nguyễn Hà Thanh-ITITIU21144.pdf`.
