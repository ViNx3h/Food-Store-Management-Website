/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author ADMIN
 */
public class Cart {

    private String userCus;
    private int idFood;
    private int quantity;
    private int price;

    public Cart() {
    }

    public Cart(String userCus, int idFood, int quantity, int price) {
        this.userCus = userCus;
        this.idFood = idFood;
        this.quantity = quantity;
        this.price = price;
    }

    /**
     * @return the userCus
     */
    public String getCus_us() {
        return userCus;
    }

    /**
     * @param userCus the userCus to set
     */
    public void setCus_us(String userCus) {
        this.userCus = userCus;
    }

    /**
     * @return the idFood
     */
    public int getPro_id() {
        return idFood;
    }

    /**
     * @param idFood the idFood to set
     */
    public void setPro_id(int idFood) {
        this.idFood = idFood;
    }

    /**
     * @return the quantity
     */
    public int getQuantity() {
        return quantity;
    }

    /**
     * @param quantity the quantity to set
     */
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    /**
     * @return the price
     */
    public int getPrice() {
        return price;
    }

    /**
     * @param price the price to set
     */
    public void setPrice(int price) {
        this.price = price;
    }
}
