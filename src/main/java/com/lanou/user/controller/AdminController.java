package com.lanou.user.controller;

import com.lanou.base.util.VerifyCode;
import com.lanou.mail.Mail;
import com.lanou.mail.MailUtils;
import com.lanou.user.domain.Admin;
import com.lanou.user.domain.Admin_Role;
import com.lanou.user.domain.Privilege;
import com.lanou.user.domain.Role;
import com.lanou.user.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.mail.MessagingException;
import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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


            if (loginAdmin != null) {
                System.out.println("登录用户 : " + loginAdmin);
                request.getServletContext().setAttribute("loginAdmin", loginAdmin);//将登陆信息存入域
            /*将权限存入域*/
                Map<String,String> map = new HashMap();
                for (Role role : loginAdmin.getRoleList()) {
                    for (Privilege privilege : role.getPrivilegeList()) {
                        map.put(privilege.getId()+"",privilege.getName());
                    }
                }
                for (String s : map.keySet()) {
                    System.out.println("privi : "+s);
                }
                request.getServletContext().setAttribute("loginPrivi",map);
            /*----------*/
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
    public String findAllAdmin(HttpServletRequest request) {

        List<Admin> adminList = adminService.findAll();

        request.getServletContext().setAttribute("adminList", adminList);
        return "admin/admin_list";
    }

    /**
     * 查询所有角色
     */
    @RequestMapping("/findAllRole")
    public String findAllRole(Model model) {
        List<Role> roleList = adminService.findAllRole();
        model.addAttribute("roleList", roleList);
        return "admin/admin_add";
    }

    /**
     * 添加管理员
     */
    @RequestMapping("/addAdmin")
    public String addAdmin(int[] role, Admin admin, HttpServletRequest request) {
        //登录名唯一
        Admin admin1 = adminService.findByAdminCode(admin.getAdmin_code());
        if (admin1 == null) {
            //添加管理员信息
            Date date = new Date();
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
            df.format(date);
            admin.setEnrolldate(date);
            adminService.addAdmin(admin);
            //回查管理员id
            int newId = adminService.findByAdminCode(admin.getAdmin_code()).getId();
            //根据管理员id,添加角色
            if (role.length != 0) {
                for (int i : role) {
                    Admin_Role admin_role = new Admin_Role(newId, i);
                    adminService.addRoleForAdmin(admin_role);
                }
            }
            return "redirect:findAllAdmin";
        }

        return "forward:findAllRole";

    }

    /**
     * 删除
     */
    @RequestMapping("/deleteAdmin")
    public void deleteAdmin(Admin admin) {
        adminService.deleteAdmin(admin.getId());
    }

    /**
     * 重置密码
     */
    @RequestMapping("/resetPwd")
    public void resetPwd(int id) {
        adminService.resetPwd(id);
    }

    /**
     * 忘记密码
     * 验证邮箱
     */
    @ResponseBody
    @RequestMapping("/verifyEmail")
    public int verifyEmail(String email){
        Admin admin = adminService.findByEmail(email);
        if (admin != null){
            return 1;
        }
        return 0;
    }
    /**
     * 忘记密码
     * 发邮件&初始密码
     */
    @ResponseBody
    @RequestMapping("/sendEmail")
    public int sendEmail(String email){
        System.out.println("发送邮件到 :"+email);
        try {
        /*   1>. 得到 session   */
            Session session = MailUtils.createSession("smtp.163.com","xinrugao@163.com", "why1993521");
        /*   2>.创建邮件对象   */
            Mail mail = new Mail("xinrugao@163.com",email,"FROM.Jaso.wei",
                    "<h1>NetAccount</h1><hr><br><h2>确认您的信息:</h2><br><h2>账号: jaso</h2>" +
                            "<h2>新的初始密码 : 123456</h2><h4>*为了账户安全,建议您尽快修改初始密码.</h4>");
        /*  3>.发送    */
            MailUtils.send(session,mail);


        } catch (MessagingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        //修改数据库
        adminService.updateByEmail(email);
        System.out.println("send success !");
        return 1;
    }


}
