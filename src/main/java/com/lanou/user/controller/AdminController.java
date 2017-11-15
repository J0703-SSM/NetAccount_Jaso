package com.lanou.user.controller;

import com.lanou.base.util.VerifyCode;
import com.lanou.user.domain.Admin;
import com.lanou.user.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.List;

/**
 * Admin  控制器
 */

@RequestMapping("/user_admin")
@Controller
public class AdminController {

    /**
     * 持有的服务层对象
     */
    @Autowired
    @Qualifier("adminService")
    private AdminService adminService;


    //验证码内容
    private String verifyCodeText;

    /**
     * 验证码图片
     *
     * @return
     */
    @RequestMapping("/getVerifyCode")
    public void getVerifyCode(HttpServletRequest request,
                              HttpServletResponse response) throws IOException {
        VerifyCode verifyCode = new VerifyCode();
        BufferedImage image = verifyCode.getImage();
        verifyCodeText = verifyCode.getText().toLowerCase();
        verifyCode.output(image, response.getOutputStream());
    }

    /**
     * 登录
     */
    @RequestMapping("/login")
    public String login(
            @Validated
                    Admin admin,
            BindingResult result,
            String verifyCodeInput,
            Model model,
            HttpServletRequest request) {

        /*表单判空*/
        if (result.hasErrors()) {
            FieldError admin_code = result.getFieldError("admin_code");
            FieldError password = result.getFieldError("password");
            //回显错误信息
            model.addAttribute("nameError", admin_code);
            model.addAttribute("pwdError", password);
        }
        /*验证码判断*/
        if (!verifyCodeInput.trim().toLowerCase().equals(verifyCodeText) ||
                verifyCodeInput.trim().equals("")) {
            model.addAttribute("vcError", "*验证码错误");

        }
        if (!result.hasErrors() &&
                verifyCodeInput.trim().toLowerCase().equals(verifyCodeText) &&
                !verifyCodeInput.trim().equals("")) {
        /*验证用户*/
            Admin loginAdmin = adminService.verifyAdmin(admin);

            request.getServletContext().setAttribute("loginAdmin", loginAdmin);//将登陆信息存入域
            if (loginAdmin != null) {
                System.out.println("登录用户 : " + loginAdmin);
                return "index";
            } else {
                model.addAttribute("error", "*账号或密码错误");
            }
        }

        /*登录验证失败*/
        return "login";


    }


    /**
     * 退出登录
     */
    @RequestMapping("/quit")
    public String quit(HttpServletRequest request) {
        request.getServletContext().removeAttribute("loginAdmin");
        return "login";
    }

    /**
     * 修改个人信息
     */
    @RequestMapping("/edit_user_info")
    public void edit_user_info(HttpServletRequest request, Admin formAdmin) {
        //登陆的用户
        Admin admin = (Admin) request.getServletContext().getAttribute("loginAdmin");
        //修改信息
        admin.setName(formAdmin.getName());
        admin.setTelephone(formAdmin.getTelephone());
        admin.setEmail(formAdmin.getEmail());
        request.getServletContext().setAttribute("loginAdmin", admin);
        System.out.println("更新域中信息 :" + admin);
        //修改密码
        adminService.updateAdmin(admin);

    }

    /**
     * 修改密码
     */
    @RequestMapping("/update_user_pwd")
    public void update_user_pwd(HttpServletRequest request, Admin formAdmin) {
        //登陆的用户
        Admin admin = (Admin) request.getServletContext().getAttribute("loginAdmin");
        admin.setPassword(formAdmin.getPassword());//更新密码
        request.getServletContext().setAttribute("loginAdmin", admin);
        System.out.println("修改密码后域中信息 :" + admin);
        //修改密码
        adminService.updatePwd(admin);
    }

    /**
     * 查询所有admin
     */
    @RequestMapping("/findAllAdmin")
    public String findAllAdmin(HttpServletRequest request){
        
        List<Admin> adminList =adminService.findAll();

        System.out.println(adminList);
        request.getServletContext().setAttribute("adminList",adminList);
        return "admin/admin_list";
    }

}
