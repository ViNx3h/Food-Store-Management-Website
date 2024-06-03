/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author ADMIN
 */
public class Categorys {

    private int id_category;
    private String name_category;
    private String img_category;

    public Categorys() {
    }

    public Categorys(int id_category, String name_category, String img_category) {
        this.id_category = id_category;
        this.name_category = name_category;
        this.img_category = img_category;
    }

    public int getId_category() {
        return id_category;
    }

    public void setId_category(int id_category) {
        this.id_category = id_category;
    }

    public String getName_category() {
        return name_category;
    }

    public void setName_category(String name_category) {
        this.name_category = name_category;
    }

    public String getImg_category() {
        return img_category;
    }

    public void setImg_category(String img_category) {
        this.img_category = img_category;
    }

}
