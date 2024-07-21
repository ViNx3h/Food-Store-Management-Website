/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.sql.Date;

/**
 *
 * @author lecon
 */
public class WorkingSchedule {

    private int id;
    private String userEmployee;
    private String fullName;
    private Date day;
    private String time;

    public WorkingSchedule() {
    }

    public WorkingSchedule(int id, String userEmployee, String fullName, Date day, String time) {
        this.id = id;
        this.userEmployee = userEmployee;
        this.fullName = fullName;
        this.day = day;
        this.time = time;
    }


    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserEmployee() {
        return userEmployee;
    }

    public void setUserEmployee(String userEmployee) {
        this.userEmployee = userEmployee;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public Date getDay() {
        return day;
    }

    public void setDay(Date day) {
        this.day = day;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

}
