/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author admin
 */
public class Discount {
    private int discount_ID;
    private int discount_Amount;

    public Discount() {
    }

    public Discount(int discount_ID, int discount_Amount) {
        this.discount_ID = discount_ID;
        this.discount_Amount = discount_Amount;
    }

    public int getDiscount_ID() {
        return discount_ID;
    }

    public void setDiscount_ID(int discount_ID) {
        this.discount_ID = discount_ID;
    }

    public int getDiscount_Amount() {
        return discount_Amount;
    }

    public void setDiscount_Amount(int discount_Amount) {
        this.discount_Amount = discount_Amount;
    }

    
    
}
