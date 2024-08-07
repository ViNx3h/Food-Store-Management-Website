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
public class Customers {

    private String userCus;
    private String password;
    private String fullName;
    private Date birthday;
    private String email;
    private String phone;
    private boolean gender;
    private String address;
    private String img;

    public Customers() {
    }

    public Customers(String userCus, String password) {
        this.userCus = userCus;
        this.password = password;
    }

    public Customers(String userCus, String password, String fullName, Date birthday, String email, String phone, boolean gender, String address, String img) {
        this.userCus = userCus;
        this.password = password;
        this.fullName = fullName;
        this.birthday = birthday;
        this.email = email;
        this.phone = phone;
        this.gender = gender;
        this.address = address;
        this.img = img;
    }

    public Customers(String userCus, String password, String fullName, Date birthday, String email, String phone, boolean gender, String address) {
        this.userCus = userCus;
        this.password = password;
        this.fullName = fullName;
        this.birthday = birthday;
        this.email = email;
        this.phone = phone;
        this.gender = gender;
        this.address = address;
    }

    public String getUserCus() {
        return userCus;
    }

    public void setUserCus(String userCus) {
        this.userCus = userCus;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

}
