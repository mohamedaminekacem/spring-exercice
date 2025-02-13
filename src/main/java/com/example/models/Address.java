package com.example.models;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

@Embeddable
public class Address {

    @Column(name = "street")
    @Size(min = 2, max = 100, message = "Street must be between 2 and 100 characters")
    private String street;

    @Column(name = "city")
    @Size(min = 2, max = 50, message = "City must be between 2 and 50 characters")
    @Pattern(regexp = "^[A-Za-zÀ-ÖØ-öø-ÿ' -]+$", message = "City must contain only letters, spaces, hyphens, and apostrophes")
    private String city;

    @Column(name = "state")
    @Size(min = 2, max = 50, message = "State must be between 2 and 50 characters")
    private String state;

    @Column(name = "country")
    @Size(min = 2, max = 50, message = "Country must be between 2 and 50 characters")
    private String country;

    @Column(name = "zipCode")
    @Pattern(regexp = "\\d{4}", message = "Zip code must be exactly 4 digits")
    private String zipCode;

    // Default constructor
    public Address() {}

    // Parameterized constructor
    public Address(String street, String city, String state, String country, String zipCode) {
        this.street = street;
        this.city = city;
        this.state = state;
        this.country = country;
        this.zipCode = zipCode;
    }

    // Getters and Setters
    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    @Override
    public String toString() {
        return street + ", " + city + ", " + state + ", " + country + " " + zipCode;
    }
}
