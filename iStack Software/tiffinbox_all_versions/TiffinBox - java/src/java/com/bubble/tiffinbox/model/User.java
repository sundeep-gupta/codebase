/*
 * Copyright (C) 2010 Bubble Inc., All Rights Reserved.
 */
package com.bubble.tiffinbox.model;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
/**
 *
 * @author bubble
 */
public class User {
    private String email;
    private String password;
    private String name;
    private String street1;
    private String street2;
    private String phone;
    private String area;
    private String city;
    private String country;
    private String role;
    /**
     * Default constructor. Do nothing.
     */
    public User() {
    }

    /**
     * Getter for <code>email</code>.
     *
     * @return email of user
     */
    public String getEmail() {
        return this.email;
    }
    /**
     * Setter for <code>email</code>.
     *
     * @param email - email address of user.
     * @throws IllegalArgumentException - when null argument / argument is not email.
     */
    public void setEmail(String email) {
        // TODO: Validate email
        if(email == null) {
            throw new IllegalArgumentException("Argument 'email' cannot be null.");
        }
        this.email = email;
    }
    /**
     * Getter for <code>password</code>
     * @return password
     */
    public String getPassword() {
        return this.password;
    }
    /**
     * Setter for <code>password</code>
     *
     * @param password
     * @throws IllegalArgumentException - when null argument / password does not match requirement
     */
    public void setPassword(String password) {
        if (password == null) {
            throw new IllegalArgumentException("Argument 'password' cannot be null.");
        }
        this.password = password;
    }

    /**
     * Getter method for name field.
     * @return name attribute of User instance.
     */
    public String getName() {
        return this.name;
    }

    /**
     * Setter method for parameter name.
     * @param name
     * @throws IllegalArgumentException - if argument passed is null
     */
    public void setName(String name) {
        if(name == null) {
            throw new IllegalArgumentException ("Argument 'name' cannot be null");
        }
        this.name = name;
    }

    /**
     * Getter method for phone field.
     * @return phone attribute of User instance.
     */
    public String getPhone() {
        return this.phone;
    }

    /**
     * Setter method for parameter phone.
     * @param phone
     * @throws IllegalArgumentException - if argument passed is null
     */
    public void setPhone(String phone) {
        if(phone == null) {
            throw new IllegalArgumentException ("Argument 'phone' cannot be null");
        }
        this.phone = phone;
    }

    /**
     * Getter method for street1 of user.
     *
     */
    public String getStreet1(String street1) {
        return this.street1;
    }

    /**
     * Setter method for <code>street1</code>/
     *
     * @param street1
     * @throws IllegalArgumentException - when null argument
     */
    public void setStreet1(String street1) {
        if(street1 == null) {
            throw new IllegalArgumentException ("Argument 'street1' cannot be null");
        }
        this.street1 = street1;
    }
    /**
     * Getter method for street1 of user.
     *
     */
    public String getStreet2(String street1) {
        return this.street2;
    }

    /**
     * Setter method for <code>street2</code>/
     *
     * @param street2
     * @throws IllegalArgumentException - when null argument
     */
    public void setStreet2(String street2) {
        if(street2 == null) {
            throw new IllegalArgumentException ("Argument 'street2' cannot be null");
        }
        this.street2 = street2;
    }
    /**
     * Getter method for street1 of user.
     *
     */
    public String getArea(String area) {
        return this.area;
    }

    /**
     * Setter method for <code>area</code>/
     *
     * @param area
     * @throws IllegalArgumentException - when null argument
     */
    public void setArea(String area) {
        if(area == null) {
            throw new IllegalArgumentException ("Argument 'area' cannot be null");
        }
        this.area = area;
    }
    /**
     * Getter method for city of user.
     *
     */
    public String getCity(String city) {
        return this.city;
    }

    /**
     * Setter method for <code>city</code>/
     *
     * @param city
     * @throws IllegalArgumentException - when null argument
     */
    public void setCity(String city) {
        if(city == null) {
            throw new IllegalArgumentException ("Argument 'city' cannot be null");
        }
        this.city = city;
    }
    /**
     * Getter method for country of user.
     *
     */
    public String getCountry(String country) {
        return this.country;
    }

    /**
     * Setter method for <code>country</code>/
     *
     * @param country
     * @throws IllegalArgumentException - when null argument
     */
    public void setCountry(String country) {
        if(country == null) {
            throw new IllegalArgumentException ("Argument 'country' cannot be null");
        }
        this.country = country;
    }

    public String getRole() { return this.role; }
    public void setRole(String role) {
        if (role.equals("admin")) {
            this.role = role;
        } else {
            this.role = "user";
        }
    }

    public void insert() throws UserRegistrationException {
        // TODO : Write the code to store record in database.
        if(this.exists()) {
            throw new UserRegistrationException("User already exists");
        }

    }

    /**
     * Validate the user and password from database.
     */
    public boolean validate() throws Exception {
        // TODO : write the code for checking if the user and password matches.
        Connection conn = null;
        try {
            conn = DBConnectionFactory.getConnection();
            if (conn == null) {
                return false;
            }
        } catch (Exception e) {
            throw new Exception("Failed to get database connection.", e);
        }
        PreparedStatement statement = conn.prepareStatement("SELECT * FROM USERS WHERE EMAIL = ? AND PASSWORD = ?");
        statement.setString(1, email);
        statement.setString(2, password);
        ResultSet result = statement.executeQuery();
        if (result.next() == false) {
            // FIXME :
            return false;
        }
        // TODO Update the current User object with the data we fetched.
        return true;
    }

    /**
     * Check if the given user exists or not.
     */
    public boolean exists() {
        return true;
    }
}
