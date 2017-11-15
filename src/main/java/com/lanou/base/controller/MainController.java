package com.lanou.base.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 页面跳转控制器
 */

@Controller
public class MainController {
    //登录
    @RequestMapping("/login")
    public String login() {
        return "login";
    }
    //主页
    @RequestMapping("/index")
    public String index() {
        return "index";
    }
    //错误
    @RequestMapping("/error")
    public String error() {
        return "error";
    }
    //无权限
    @RequestMapping("/nopower")
    public String nopower() {
        return "nopower";
    }


    //角色
    @RequestMapping("/role_list")
    public String role_list() {
        return "role/role_list";
    }
    //管理员
    @RequestMapping("/admin_list")
    public String admin_list() {
        return "forward:user_admin/findAllAdmin";
    }
    //资费
    @RequestMapping("/fee_list")
    public String fee_list() {
        return "forward:cost/findAll";
    }
    //账务账号
    @RequestMapping("/account_list")
    public String account_list() {
        return "account/account_list";
    }
    //业务账号
    @RequestMapping("/service_list")
    public String service_list() {
        return "service/service_list";
    }
    //账单管理
    @RequestMapping("/bill_list")
    public String bill_list() {
        return "bill/bill_list";
    }
    //报表
    @RequestMapping("/report_list")
    public String report_list() {
        return "report/report_list";
    }
    //个人信息
    @RequestMapping("/user_info")
    public String user_info() {
        return "user/user_info";
    }
    //修改密码
    @RequestMapping("/user_modi_pwd")
    public String user_modi_pwd() {
        return "user/user_modi_pwd";
    }

    //添加角色
    @RequestMapping("/role_add")
    public String role_add() {
        return "role/role_add";
    }

    //添加资费
    @RequestMapping("/fee_add")
    public String fee_add(){return "fee/fee_add";}

}
