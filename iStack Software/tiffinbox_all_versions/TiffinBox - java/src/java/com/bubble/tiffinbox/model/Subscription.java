/*
 * Copyright (C) 2010 Bubble Inc., All Rights ReservedTo change this template, choose Tools | Templates
 * Copyright (C) 2010 Bubble Inc., All Rights Reservedand open the template in the editor.
 */

package com.bubble.tiffinbox.model;

/**
 *
 * @author bubble
 * @version 1.0
 */
public class Subscription {

    private int id;

    private String name;

    private String desc;

    private int price;

    public Subscription(){}
    public void setId(int id) { this.id = id; }
    public void setDesc(String desc) { this.desc = desc; }
    public void setName(String name) { this.name = name; }
    public void setPrice(int price) { this.price = price; }
    public int getId() { return this.id; }
    public String getName() { return this.name; }
    public String getDesc() { return this.desc; }
    public int getPrice() { return this.price; }
    
}
