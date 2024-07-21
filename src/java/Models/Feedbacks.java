/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.sql.Date;

/**
 *
 * @author VINH
 */
public class Feedbacks {

    private String userCus;
    private int idFood;
    private Date dateFeedback;
    private String feedback;
    private double rating;

    public Feedbacks() {
    }

    public Feedbacks(String userCus, int idFood, Date dateFeedback, String feedback, double rating) {
        this.userCus = userCus;
        this.idFood = idFood;
        this.dateFeedback = dateFeedback;
        this.feedback = feedback;
        this.rating = rating;
    }

    public String getUserCus() {
        return userCus;
    }

    public void setUserCus(String userCus) {
        this.userCus = userCus;
    }

    public int getIdFood() {
        return idFood;
    }

    public void setIdFood(int idFood) {
        this.idFood = idFood;
    }

    public Date getDateFeedback() {
        return dateFeedback;
    }

    public void setDateFeedback(Date dateFeedback) {
        this.dateFeedback = dateFeedback;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

}
