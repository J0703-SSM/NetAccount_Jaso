package com.lanou.user.domain;

/**
 * 权限
 */
public class Privilege {
    private int id;
    private String name;//权限名称

    public Privilege() {
    }

    public Privilege(String name) {

        this.name = name;
    }

    public Privilege(int id, String name) {

        this.id = id;
        this.name = name;
    }

    @Override
    public String toString() {
        return "Privilege{" +
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
