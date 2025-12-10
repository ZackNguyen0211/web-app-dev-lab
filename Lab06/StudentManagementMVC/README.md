# Lab 06 - Authentication & Authorization

## STUDENT INFORMATION:

- **Name:** Nguyễn Hà Thanh
- **Student ID:** ITITIU21144
- **Class:** Monday Morning Lab

---

## COMPLETED EXERCISES:

- [x] Exercise 1: Database & User Model
- [x] Exercise 2: User Model & DAO
- [x] Exercise 3: Login/Logout Controllers
- [x] Exercise 4: Views & Dashboard
- [x] Exercise 5: Authentication Filter
- [x] Exercise 6: Admin Authorization Filter
- [x] Exercise 7: Role-Based UI
- [x] Exercise 8: Change Password

---

## AUTHENTICATION COMPONENTS:

### Models:

- `User.java` - User entity with id, username, password, fullName, role, active, createdAt, lastLogin

### DAOs:

- `UserDAO.java` - Database operations: authenticate(), getUserById(), getUserByUsername(), createUser(), updatePassword(), saveRememberToken(), getUserByToken(), deleteRememberToken()

### Controllers:

- `LoginController.java` - Handle login (GET/POST), session creation, remember me functionality
- `LogoutController.java` - Handle logout, session invalidation, token cleanup
- `DashboardController.java` - Display dashboard with user info and statistics
- `ChangePasswordController.java` - Handle password change with BCrypt validation
- `ThemeController.java` - Handle theme preference (light/dark mode)

### Filters:

- `AuthFilter.java` - Intercept all requests, enforce authentication, handle remember me auto-login
- `AdminFilter.java` - Enforce admin-only actions (new, insert, edit, update, delete)

### Views:

- `login.jsp` - Login form with remember me checkbox and theme switcher
- `dashboard.jsp` - Main dashboard with user info, statistics, quick actions, theme switcher
- `student-list.jsp` - Student list with role-based UI, search, filter, sort
- `change-password.jsp` - Change password form with validation

---

## TEST CREDENTIALS:

### Admin:

- Username: `admin`
- Password: `password123`

### Regular User:

- Username: `john`
- Password: `password123`

---

## FEATURES IMPLEMENTED:

### Core Features:

- User authentication with BCrypt password hashing
- Session-based user management
- Login/Logout functionality
- Dashboard with student statistics
- Authentication filter for protected pages
- Admin authorization filter for sensitive operations
- Role-based UI elements (admin-only buttons)
- Change password with current password verification

### Bonus Features:

- **Cookie Utility Class** - Reusable utility for cookie CRUD operations
- **Remember Me Functionality** - 30-day persistent login with token-based authentication
- **Theme Preference** - Light/Dark mode with Bootstrap 5.3, saved in cookies (1-year expiration)

---

## SECURITY MEASURES:

### Password Security:

- BCrypt hashing for all passwords (never stored in plaintext)
- Password strength validation (minimum 8 characters)
- Current password verification before change
- Password confirmation matching

### Session Security:

- Session regeneration after login
- Session invalidation on logout
- 30-minute session timeout
- User info stored in session (not cookies)

### SQL Injection Prevention:

- PreparedStatement for all database queries
- Parameterized queries separate from SQL code

### XSS Prevention:

- JSTL automatic HTML escaping
- Cookie httpOnly flag (JavaScript cannot access)
- Output encoding for user-generated content

### Cookie Security:

- httpOnly flag for XSS protection
- Secure flag for HTTPS-only transmission
- Domain restriction to application path
- Appropriate expiration times

### Input Validation:

- Theme validation (only 'light' or 'dark')
- Username validation against database
- Password minimum length enforcement
- Required field validation

---

## KNOWN ISSUES:

- No email verification for user registration
- No password reset functionality
- No HTTPS requirement (runs on HTTP for testing)
- Limited password policy (only minimum length, no complexity requirements)
- No account lockout after failed login attempts
- No audit logging for user actions

---

## BONUS FEATURES:

### BONUS 1: Cookie Utility Class (5 points)

- Reusable utility class with static methods:
  - `createCookie()` - Create secure cookie with httpOnly flag
  - `getCookieValue()` - Retrieve cookie value safely
  - `hasCookie()` - Check cookie existence
  - `deleteCookie()` - Delete cookie by setting maxAge=0
  - `updateCookie()` - Update existing cookie
  - `getCookieIntValue()` - Get integer cookie value
  - `createSecureCookie()` - Create domain-specific cookie

### BONUS 2: Remember Me Functionality (5 points)

- UUID-based token generation on login
- Token stored in database with 30-day expiration
- Auto-login on subsequent visits via cookie validation
- Token cleanup on logout
- Secure cookie with httpOnly and secure flags

### BONUS 3: User Theme Preference (3 points)

- Light/Dark theme toggle on login and dashboard pages
- Bootstrap 5.3 native theme support with `data-bs-theme` attribute
- Theme preference saved in cookie (1-year expiration)
- Complete CSS styling for both themes
- Smooth theme transitions across all pages

---

## TIME SPENT:

Approximately **8-9 hours** total:

- Exercise 1-7: ~6 hours
- Exercise 8: ~45 minutes
- Bonus 1: ~30 minutes
- Bonus 2: ~60 minutes
- Bonus 3: ~90 minutes

---

## TESTING NOTES:

### Authentication Testing:

1. **Valid login:** Tested with admin/john credentials → Session created, redirected to dashboard
2. **Invalid login:** Wrong password → Error message displayed, no session created
3. **Session timeout:** Waited 30+ minutes → Redirected to login when accessing protected page
4. **Logout:** Session invalidated, redirected to login with success message

### Authorization Testing:

1. **Admin access:** Login as admin → Add/Edit/Delete buttons visible and functional
2. **User access:** Login as john → Add/Edit/Delete buttons hidden, direct access blocked with error message
3. **Admin filter:** User trying to access `/student?action=new` → Error displayed, action blocked

### Remember Me Testing:

1. **Checkbox checked:** Token created, cookie saved → Browser closed and reopened → Auto-login successful
2. **Checkbox unchecked:** No token created → Browser closed → Login required
3. **Logout with remember me:** Token deleted from database and cookie removed → No auto-login

### Theme Testing:

1. **Login page:** Switched between Light/Dark → Theme applied immediately, persisted after refresh
2. **Dashboard:** Theme dropdown functional → Theme applies to all elements (navbar, cards, buttons)
3. **All pages:** Theme persists across login, dashboard, student-list, change-password
4. **Persistence:** Browser closed and reopened → Theme preference maintained (1-year cookie)

### Password Change Testing:

1. **Valid change:** Current password correct, new password 8+ chars, confirmation matches → Success
2. **Wrong current password:** Error message displayed
3. **Short password:** Less than 8 characters → Error displayed
4. **Mismatched confirmation:** Error displayed
5. **Login with new password:** Old password fails, new password succeeds

### Search & Filter Testing:

1. **Search by code/name/email:** Results filtered correctly
2. **Filter by major:** Dropdown filters students by selected major
3. **Sort by column:** Click headers → Sort ascending/descending with indicator (▲/▼)
4. **Clear filters:** "Show All" and "Clear Filter" buttons restore full list

### Security Testing:

1. **XSS:** Attempted `<script>alert('xss')</script>` in username → Properly escaped, not executed
2. **SQL Injection:** Tried `admin' OR '1'='1` → Login failed, not bypassed
3. **Session security:** Manually deleted session cookie → Redirected to login

---

**Last Updated:** December 10, 2025  
**Status:** ✅ Complete - All exercises and bonus features implemented  
**Compilation:** ✅ SUCCESS - 14 source files, 0 errors

- Methods: Constructors, getters/setters, utility methods (isAdmin(), isUser(), toString())
- Implements Serializable for session storage

#### Data Access Objects (DAO)

- **`UserDAO.java`** (`com.student.dao`)

  - **Core Methods:**
    - `authenticate(username, password)` - BCrypt password verification
    - `getUserById(id)` - Retrieve user by ID
    - `getUserByUsername(username)` - Retrieve user by username
    - `createUser(user)` - Insert new user
    - `updatePassword(userId, newPassword)` - Update hashed password
  - **Remember Me Methods:**
    - `saveRememberToken(userId, token)` - Save remember token to database
    - `getUserByToken(token)` - Retrieve user from remember token (checks expiration)
    - `deleteRememberToken(token)` - Remove token on logout
  - **Database Connection:** MySQL with PreparedStatement (SQL injection prevention)

- **`StudentDAO.java`** (`com.student.dao`)
  - Full CRUD operations for Student management
  - Search, filter, and sort functionality
  - Pagination support

#### Controllers

- **`LoginController.java`** (`com.student.controller`)

  - **doGet():** Display login form, redirect authenticated users to dashboard
  - **doPost():** Authenticate user, create session, handle remember me checkbox
  - Features: Session regeneration, role-based redirect, token generation

- **`LogoutController.java`** (`com.student.controller`)

  - **doGet():** Invalidate session, delete remember token, redirect to login
  - Features: Token cleanup, cookie deletion

- **`DashboardController.java`** (`com.student.controller`)

  - Display main dashboard with student statistics
  - User info and role display
  - Quick action buttons

- **`ChangePasswordController.java`** (`com.student.controller`) - **NEW (Exercise 8)**

  - **doGet():** Display change password form
  - **doPost():** Validate current password, validate new password (8+ chars), hash with BCrypt, update via DAO
  - Features: Password strength validation, confirmation matching

- **`ThemeController.java`** (`com.student.controller`) - **NEW (BONUS 3)**

  - Handle theme preference selection (light/dark)
  - Save preference to cookie (1-year expiration)
  - Validate theme values (security: prevent injection)

- **`StudentController.java`** (`com.student.controller`)
  - Handle CRUD operations for students
  - Search, filter, sort functionality
  - Action routing (list, new, insert, edit, update, delete)

#### Filters

- **`AuthFilter.java`** (`com.student.filter`)

  - **Purpose:** Intercept all requests, enforce authentication
  - **Public URLs:** /login, /logout, static resources (.css, .js, .png, .jpg, .jpeg, .gif)
  - **Protected URLs:** All others require authenticated session
  - **Features:**
    - Session management
    - Remember me cookie validation for auto-login
    - Redirect unauthenticated users to login with original request URI
    - URL pattern matching for public resources

- **`AdminFilter.java`** (`com.student.filter`)
  - **Purpose:** Enforce admin-only actions
  - **Protected Actions:** new, insert, edit, update, delete (student operations)
  - **Features:**
    - Role-based action blocking
    - Error message display for unauthorized access
    - Allows admins to perform CRUD; regular users can only view
    - Transparent filter chain for allowed actions

#### Utility Classes

- **`PasswordHashGenerator.java`** (`com.student.util`)

  - Utility for generating BCrypt password hashes during testing
  - Used to create initial test user hashes

- **`CookieUtil.java`** (`com.student.util`) - **NEW (BONUS 1)**
  - Static methods for cookie management:
    - `createCookie(response, name, value, maxAge)` - Create secure cookie with httpOnly flag
    - `getCookieValue(request, name)` - Retrieve cookie value safely
    - `hasCookie(request, name)` - Check cookie existence
    - `deleteCookie(response, name)` - Delete cookie by setting maxAge=0
    - `updateCookie(response, name, value, maxAge)` - Update existing cookie
  - **Bonus methods:**
    - `getCookieIntValue(request, name, defaultValue)` - Get integer cookie value
    - `createSecureCookie(response, name, value, maxAge, domain)` - Create domain-specific cookie
  - Security: XSS prevention (httpOnly=true), HTTPS enforcement (secure=true)

#### Views (JSP Templates)

- **`login.jsp`**

  - Professional gradient design (purple to violet)
  - Username/password input fields
  - Remember me checkbox for 30-day persistent login
  - Demo credentials display for testing
  - **NEW (BONUS 3):** Light/Dark theme toggle buttons
  - Error/success message display
  - Responsive design

- **`dashboard.jsp`**

  - Navigation bar with user info and role badge
  - Welcome message
  - Student statistics card
  - Quick action buttons (View All, Add New, Search)
  - Role-based UI (Add button only for admin)
  - **NEW (BONUS 3):** Theme switcher dropdown in navbar with Bootstrap 5.3

- **`student-list.jsp`**

  - Navbar with user info and logout
  - Search functionality by code/name/email
  - Filter by major with dropdown
  - Sortable columns (ID, Code, Name, Email, Major)
  - Edit/Delete buttons (admin only)
  - Responsive table design
  - **NEW (BONUS 3):** Dark theme support with Bootstrap 5.3

- **`change-password.jsp`** - **NEW (Exercise 8)**

  - Form for changing password
  - Current password verification
  - New password with confirmation
  - Password requirements info box (8+ chars, match confirmation)
  - Error message display
  - **NEW (BONUS 3):** Dark theme support

- **`student-form.jsp`** - Add/Edit student form
- **`student-search.jsp`** - Search results page

### Database Schema

#### `users` Table

```sql
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    role ENUM('admin', 'user') DEFAULT 'user',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    INDEX idx_username (username)
);
```

#### `remember_tokens` Table - **NEW (BONUS 2)**

```sql
CREATE TABLE remember_tokens (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    token VARCHAR(255) UNIQUE NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_token (token),
    INDEX idx_expires_at (expires_at),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
```

#### `students` Table

```sql
CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_code VARCHAR(20) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    major VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_student_code (student_code)
);
```