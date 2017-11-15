package com.lanou.user.domain;

/**
 * Created by dllo on 17/11/14.
 */
public class Role_Privi {
    private int role_id;
    private int privilege_id;

    public Role_Privi() {
    }

    public Role_Privi(int role_id, int privilege_id) {

        this.role_id = role_id;
        this.privilege_id = privilege_id;
    }

    @Override
    public String toString() {
        return "Role_Privi{" +
                "role_id=" + role_id +
                ", privilege_id=" + privilege_id +
                '}';
    }

    public int getRole_id() {
        return role_id;
    }

    public void setRole_id(int role_id) {
        this.role_id = role_id;
    }

    public int getPrivilege_id() {
        return privilege_id;
    }

    public void setPrivilege_id(int privilege_id) {
        this.privilege_id = privilege_id;
    }
}
