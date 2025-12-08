package com.example.customerapi.service;

import com.example.customerapi.dto.CustomerRequestDTO;
import com.example.customerapi.dto.CustomerResponseDTO;
import com.example.customerapi.entity.Customer;
import com.example.customerapi.entity.CustomerStatus;
import com.example.customerapi.exception.DuplicateResourceException;
import com.example.customerapi.exception.ResourceNotFoundException;
import com.example.customerapi.repository.CustomerRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Transactional
public class CustomerServiceImpl implements CustomerService {

    private final CustomerRepository customerRepository;

    public CustomerServiceImpl(CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
    }

    @Override
    public List<CustomerResponseDTO> getAllCustomers() {
        return customerRepository.findAll()
                .stream()
                .map(this::convertToResponseDTO)
                .collect(Collectors.toList());
    }

    @Override
    public CustomerResponseDTO getCustomerById(Long id) {
        Customer customer = customerRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Customer not found with id: " + id));
        return convertToResponseDTO(customer);
    }

    @Override
    public CustomerResponseDTO createCustomer(CustomerRequestDTO requestDTO) {
        if (customerRepository.existsByCustomerCode(requestDTO.getCustomerCode())) {
            throw new DuplicateResourceException("Customer code already exists");
        }
        if (customerRepository.existsByEmail(requestDTO.getEmail())) {
            throw new DuplicateResourceException("Email already exists");
        }

        Customer customer = convertToEntity(requestDTO);
        Customer saved = customerRepository.save(customer);
        return convertToResponseDTO(saved);
    }

    @Override
    public CustomerResponseDTO updateCustomer(Long id, CustomerRequestDTO requestDTO) {
        Customer existing = customerRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Customer not found with id: " + id));

        if (!existing.getEmail().equals(requestDTO.getEmail())) {
            Optional<Customer> emailOwner = customerRepository.findByEmail(requestDTO.getEmail());
            if (emailOwner.isPresent() && !emailOwner.get().getId().equals(id)) {
                throw new DuplicateResourceException("Email already exists");
            }
        }

        existing.setCustomerCode(requestDTO.getCustomerCode());
        existing.setFullName(requestDTO.getFullName());
        existing.setEmail(requestDTO.getEmail());
        existing.setPhone(requestDTO.getPhone());
        existing.setAddress(requestDTO.getAddress());
        existing.setStatus(parseStatus(requestDTO.getStatus()));

        Customer updated = customerRepository.save(existing);
        return convertToResponseDTO(updated);
    }

    @Override
    public void deleteCustomer(Long id) {
        Customer existing = customerRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Customer not found with id: " + id));
        customerRepository.delete(existing);
    }

    private CustomerResponseDTO convertToResponseDTO(Customer customer) {
        return new CustomerResponseDTO(
                customer.getId(),
                customer.getCustomerCode(),
                customer.getFullName(),
                customer.getEmail(),
                customer.getPhone(),
                customer.getAddress(),
                customer.getStatus() != null ? customer.getStatus().name() : null,
                customer.getCreatedAt()
        );
    }

    private Customer convertToEntity(CustomerRequestDTO dto) {
        Customer customer = new Customer();
        customer.setCustomerCode(dto.getCustomerCode());
        customer.setFullName(dto.getFullName());
        customer.setEmail(dto.getEmail());
        customer.setPhone(dto.getPhone());
        customer.setAddress(dto.getAddress());
        customer.setStatus(parseStatus(dto.getStatus()));
        return customer;
    }

    private CustomerStatus parseStatus(String status) {
        return status == null ? CustomerStatus.ACTIVE : CustomerStatus.valueOf(status.toUpperCase());
    }
}
