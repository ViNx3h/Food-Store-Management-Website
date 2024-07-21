/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.sql.Date;

/**
 *
 * @author ADMIN
 */
public class Bills {

    private int idOrder;
    private String userCus;
    private Date orderDate;
    private int total_quantity;
    private String note;
    private String address;
    private String phone;
    private String confirm;

    public Bills() {
    }

    public Bills(int idOrder, String userCus, Date orderDate, int total_quantity, String note, String address, String phone) {
        this.idOrder = idOrder;
        this.userCus = userCus;
        this.orderDate = orderDate;
        this.total_quantity = total_quantity;
        this.note = note;
        this.address = address;
        this.phone = phone;
    }

    public Bills(String userCus, Date orderDate, int total_quantity, String note, String address, String phone, String confirm) {
        this.userCus = userCus;
        this.orderDate = orderDate;
        this.total_quantity = total_quantity;
        this.note = note;
        this.address = address;
        this.phone = phone;
        this.confirm = confirm;
    }

    public String getConfirm() {
        return confirm;
    }

    public void setConfirm(String confirm) {
        this.confirm = confirm;
    }

    public int getIdOrder() {
        return idOrder;
    }

    public void setIdOrder(int idOrder) {
        this.idOrder = idOrder;
    }

    public String getUserCus() {
        return userCus;
    }

    public void setUserCus(String userCus) {
        this.userCus = userCus;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public int getTotal_quantity() {
        return total_quantity;
    }

    public void setTotal_quantity(int total_quantity) {
        this.total_quantity = total_quantity;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}
