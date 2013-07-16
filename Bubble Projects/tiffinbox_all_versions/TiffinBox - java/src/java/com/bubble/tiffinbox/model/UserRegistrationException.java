/*
 * Copyright (C) 2010 Bubble Inc., All Rights Reserved.
 */
package com.bubble.tiffinbox.model;

/**
 *
 * @author bubble
 * @version 1.0
 *
 */
public class UserRegistrationException extends Exception {
    /**
     * Creates a new instance of <code>UserRegistrationException</code> without detail message.
     */
    public UserRegistrationException() {
    }

    /**
     * Constructs an instance of <code>UserRegistrationException</code> with the specified detail message.
     * @param msg the detail message.
     */
    public UserRegistrationException(String msg) {
        super(msg);
    }

    /**
     * Constructs an instance of <code>UserRegistrationException</code> with the specified detail message.
     * @param msg the detail message.
     * @param cause actual cause of the exception
     */
    public UserRegistrationException(String msg, Throwable cause) {
        super(msg, cause);
    }
}
