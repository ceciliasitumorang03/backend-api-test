package com.example.backendtest.service;

import org.springframework.stereotype.Service;
import java.util.*;
import com.example.backendtest.repository.TransactionRepository;
import com.example.backendtest.model.Transaction;
import com.example.backendtest.model.StatusDto;

@Service
public class TransactionService {
    private final TransactionRepository repo;

    public TransactionService(TransactionRepository repo) {
        this.repo = repo;
    }

    public Map<String, Object> getAllData() {
        Map<String, Object> response = new LinkedHashMap<>();
        List<Transaction> data = repo.findAll();
        List<StatusDto> status = List.of(
                new StatusDto(0, "SUCCESS"),
                new StatusDto(1, "FAILED")
        );
        response.put("data", data);
        response.put("status", status);
        return response;
    }
}
