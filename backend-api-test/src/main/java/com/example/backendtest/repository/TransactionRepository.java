package com.example.backendtest.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.backendtest.model.Transaction;

public interface TransactionRepository extends JpaRepository<Transaction, Long> {
}
