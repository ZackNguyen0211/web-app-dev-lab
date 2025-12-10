STUDENT INFORMATION:
Name: Nguyễn Hà Thanh
Student ID: ITITIU21144
Class: Monday Morning Lab

COMPLETED EXERCISES:
[x] Exercise 5: Search
[x] Exercise 6: Validation
[x] Exercise 7: Sorting & Filtering
[ ] Exercise 8: Pagination
[ ] Bonus 1: Export Excel

MVC COMPONENTS:
- Model: Student.java
- DAO: StudentDAO.java
- Controller: StudentController.java
- Views: student-list.jsp, student-form.jsp

FEATURES IMPLEMENTED:
- Full CRUD operations (Create, Read, Update, Delete)
- Search across multiple fields (student_code, full_name, email)
- Server-side validation for:
  • Student Code (required + pattern)
  • Full Name (required + length)
  • Email (format check)
  • Major (required)
- Sorting by columns (ID, Code, Name, Email, Major)
- Sort order toggle (ASC/DESC)
- Filter by Major (dropdown)
- Combined sort + filter logic
- Clean UI:
  • Search bar with “Show All”
  • Sort arrows (▲ ▼) depending on direction
  • Major filter dropdown with preserved state
  • Styled layout, buttons, forms, and tables

KNOWN ISSUES:
- No major issues found during testing
(Essential CRUD, search, filter, and sort all work correctly)

EXTRA FEATURES:
- Improved UI styling (gradients, spacing, flexbox layout)
- Search keyword preserved in input field
- “Show All” button appears only when searching
- Selected major remains after filtering

TIME SPENT:
~ 4–5 hours
