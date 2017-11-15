package com.lanou.base.util;

/**
 * Created by dllo on 17/11/14.
 */
public class PageExt {
    private int pc;//当前页
    private int ps;//每页记录数

    public PageExt() {
    }

    public PageExt(int pc) {

        this.pc = pc;
    }

    public PageExt(int pc, int ps) {

        this.pc = pc;
        this.ps = ps;
    }

    @Override
    public String toString() {
        return "PageExt{" +
                "pc=" + pc +
                ", ps=" + ps +
                '}';
    }

    public int getPc() {
        return pc;
    }

    public void setPc(int pc) {
        this.pc = pc;
    }

    public int getPs() {
        return ps;
    }

    public void setPs(int ps) {
        this.ps = ps;
    }
}
