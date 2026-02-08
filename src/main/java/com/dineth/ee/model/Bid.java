package com.dineth.ee.model;

import java.io.Serializable;
import java.util.Date;

public class Bid implements Serializable {
    private String itemId;
    private String bidderName;
    private double amount;
    private Date bidTime;

    public Bid(){}

    public Bid(String itemId, String bidderName, double amount) {
        this.itemId = itemId;
        this.bidderName = bidderName;
        this.amount = amount;
        this.bidTime = new Date();
    }

    public String getItemId() {
        return itemId;
    }

    public Date getBidTime() {
        return bidTime;
    }

    public void setBidTime(Date bidTime) {
        this.bidTime = bidTime;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getBidderName() {
        return bidderName;
    }

    public void setBidderName(String bidderName) {
        this.bidderName = bidderName;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }
}

