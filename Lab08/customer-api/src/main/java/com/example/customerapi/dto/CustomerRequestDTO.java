package com.example.customerapi.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

public class CustomerRequestDTO {

    // customerCode: Not blank, 3-20 chars, pattern ^C\d{3,}$
    @NotBlank(message = "Customer code must not be blank")
    @Size(min = 3, max = 20, message = "Customer code must be between 3 and 20 characters")
    @Pattern(
        regexp = "^C\\d{3,}$",
        message = "Customer code must start with 'C' followed by at least 3 digits"
    )
    private String customerCode;

    // fullName: Not blank, 2-100 chars
    @NotBlank(message = "Full name must not be blank")
    @Size(min = 2, max = 100, message = "Full name must be between 2 and 100 characters")
    private String fullName;

    // email: Not blank, valid email format
    @NotBlank(message = "Email must not be blank")
    @Email(message = "Email must be a valid email address")
    private String email;

    // phone: Pattern ^\+?[0-9]{10,20}$
    @Pattern(
        regexp = "^\\+?[0-9]{10,20}$",
        message = "Phone number must be 10-20 digits, optionally starting with +"
    )
    private String phone;

    // address: Max 500 chars
    @Size(max = 500, message = "Address must be at most 500 characters")
    private String address;

    // status: dạng String theo template (ACTIVE / INACTIVE)
    @NotBlank(message = "Status must not be blank")
    @Pattern(
        regexp = "ACTIVE|INACTIVE",
        message = "Status must be either ACTIVE or INACTIVE"
    )
    private String status;

    /* ================= Constructors ================= */

    public CustomerRequestDTO() {
    }

    public CustomerRequestDTO(String customerCode,
                              String fullName,
                              String email,
                              String phone,
                              String address,
                              String status) {
        this.customerCode = customerCode;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.status = status;
    }

    /* ================= Getters & Setters ================= */

    public String getCustomerCode() {
        return customerCode;
    }

    public void setCustomerCode(String customerCode) {
        this.customerCode = customerCode;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
