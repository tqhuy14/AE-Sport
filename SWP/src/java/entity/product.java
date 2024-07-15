/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import Model.Category;
import Model.Discount;
import Model.Feedback;
import java.util.ArrayList;

/**
 *
 * @author Hoàng Sơn
 */
public class product {

    private int productID;
    private ArrayList<Feedback> feedback;
    private double price;
    private ArrayList<img> image;
    private String description;
    private String status;
    private sport sport;
    private int typeID;
    private String productName;
    private Brand brand;
    private int quantity_sold;
    private Discount discount;
    private Category cate;
    private SubCategory subCate;
    
    
    
    public product() {
    }

    public Category getCate() {
        return cate;
    }

    public void setCate(Category cate) {
        this.cate = cate;
    }

    public SubCategory getSubCate() {
        return subCate;
    }

    public void setSubCate(SubCategory subCate) {
        this.subCate = subCate;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public ArrayList<Feedback> getFeedback() {
        return feedback;
    }

    public void setFeedback(ArrayList<Feedback> feedback) {
        this.feedback = feedback;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public ArrayList<img> getImage() {
        return image;
    }

    public void setImage(ArrayList<img> image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public sport getSport() {
        return sport;
    }

    public void setSport(sport sport) {
        this.sport = sport;
    }

    public int getTypeID() {
        return typeID;
    }

    public void setTypeID(int typeID) {
        this.typeID = typeID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public int getQuantity_sold() {
        return quantity_sold;
    }

    public void setQuantity_sold(int quantity_sold) {
        this.quantity_sold = quantity_sold;
    }

    public Discount getDiscount() {
        return discount;
    }

    public void setDiscount(Discount discount) {
        this.discount = discount;
    }

}
