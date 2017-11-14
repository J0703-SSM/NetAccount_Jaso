package com.lanou.user.domain;

import java.util.List;

/**
 * 角色
 */
public class Role {
    private int id;
    private String name;//角色名称

    //多权限
    private List<Privilege> privilegeList;

    public List<Privilege> getPrivilegeList() {
        return privilegeList;
    }

    public void setPrivilegeList(List<Privilege> privilegeList) {
        this.privilegeList = privilegeList;
    }

    public Role() {
    }

    public Role(String name) {

        this.name = name;
    }

    public Role(int id, String name) {

        this.id = id;
        this.name = name;
    }

    @Override
    public String toString() {
        return "Role{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
