package com.lanou.user.domain;

/**
 * Created by dllo on 17/11/16.
 */
public class Admin_Role {
    private int admin_id;
    private int role_id;

    public Admin_Role() {
    }



    public Admin_Role(int admin_id, int role_id) {

        this.admin_id = admin_id;
        this.role_id = role_id;
    }

    @Override
    public String toString() {
        return "Admin_Role{" +
                "admin_id=" + admin_id +
                ", role_id=" + role_id +
                '}';
    }

    public int getAdmin_id() {
        return admin_id;
    }

    public void setAdmin_id(int admin_id) {
        this.admin_id = admin_id;
    }

    public int getRole_id() {
        return role_id;
    }

    public void setRole_id(int role_id) {
        this.role_id = role_id;
    }
}
