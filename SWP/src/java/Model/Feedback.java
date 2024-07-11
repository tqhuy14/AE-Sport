/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.io.Serializable;

/**
 *
 * @author Admin
 */
public class Feedback implements Serializable {

    private static final long serialVersionUID = 1L;
    private int fe_ID;
    private String img;
    private String detal;
    private int user_ID;
    private int ratedStar;
    private String username;

    public Feedback() {
    }

    public Feedback(int fe_ID, String img, String detal, int user_ID) {
        this.fe_ID = fe_ID;
        this.img = img;
        this.detal = detal;
        this.user_ID = user_ID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getFe_ID() {
        return fe_ID;
    }

    public void setFe_ID(int fe_ID) {
        this.fe_ID = fe_ID;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getDetal() {
        return detal;
    }

    public void setDetal(String detal) {
        this.detal = detal;
    }

    public int getUser_ID() {
        return user_ID;
    }

    public void setUser_ID(int user_ID) {
        this.user_ID = user_ID;
    }

    public int getRatedStar() {
        return ratedStar;
    }

    public void setRatedStar(int ratedStar) {
        this.ratedStar = ratedStar;
    }

}
