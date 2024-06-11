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
public class EditingDetail {
    private String userEmployee;
    private int idFood;
    private String add_food,delete_food,update_food;
    private Date date_editing;

    public EditingDetail() {
    }

    public EditingDetail(String userEmployee, int idFood, String add_food, String delete_food, String update_food, Date date_editing) {
        this.userEmployee = userEmployee;
        this.idFood = idFood;
        this.add_food = add_food;
        this.delete_food = delete_food;
        this.update_food = update_food;
        this.date_editing = date_editing;
    }

    public String getUserEmployee() {
        return userEmployee;
    }

    public void setUserEmployee(String userEmployee) {
        this.userEmployee = userEmployee;
    }

    public int getIdFood() {
        return idFood;
    }

    public void setIdFood(int idFood) {
        this.idFood = idFood;
    }

    public String getAdd_food() {
        return add_food;
    }

    public void setAdd_food(String add_food) {
        this.add_food = add_food;
    }

    public String getDelete_food() {
        return delete_food;
    }

    public void setDelete_food(String delete_food) {
        this.delete_food = delete_food;
    }

    public String getUpdate_food() {
        return update_food;
    }

    public void setUpdate_food(String update_food) {
        this.update_food = update_food;
    }

    public Date getDate_editing() {
        return date_editing;
    }

    public void setDate_editing(Date date_editing) {
        this.date_editing = date_editing;
    }
    
}
