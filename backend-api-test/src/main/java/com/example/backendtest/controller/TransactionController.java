package com.example.backendtest.controller;

import org.springframework.web.bind.annotation.*;
import com.example.backendtest.service.TransactionService;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class TransactionController {
    private final TransactionService service;

    public TransactionController(TransactionService service) {
        this.service = service;
    }

    @GetMapping("/transactions")
    public Map<String, Object> getTransactions() {
        return service.getAllData();
    }
}
