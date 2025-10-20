package com.example.backendtest.model;

public class StatusDto {
    private int id;
    private String name;

    public StatusDto(int id, String name) {
        this.id = id;
        this.name = name;
    }
    public int getId() { return id; }
    public String getName() { return name; }
}
