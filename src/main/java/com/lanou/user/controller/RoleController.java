package com.lanou.user.controller;

import com.lanou.user.domain.Privilege;
import com.lanou.user.domain.Role;
import com.lanou.user.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Role 控制器
 */
@Controller
@RequestMapping("/user_role")
public class RoleController {

    /**
     * 持有的服务层对象
     */
    @Autowired
    @Qualifier("roleService")
    private RoleService roleService;

    /**
     * 显示所有角色信息
     */
    @RequestMapping("/findAllRole")
    public String findAll(Model model) {
        List<Role> roleList = roleService.findAll();
        model.addAttribute("roleList", roleList);
        return "role/role_list";
    }

    /**
     * 查询所有权限
     */
    @ResponseBody
    @RequestMapping("/findAllPrivi")
    public List<Privilege> findAllPrivi() {
        return roleService.findAllPrivi();
    }

    /**
     * 添加角色
     */
    @RequestMapping("/addRole")
    public void addRole(
            String[] privilegeList, HttpServletRequest request) {

        String[] values = request.getParameterValues("privilegeList");
        System.out.println(privilegeList);
//        System.out.println("添加角色名 :" + role.getName());
//
        //去重复
//        //添加角色
//        roleService.addRole(role);
        //添加权限对应
//        for (String s : privilegeList) {
//            System.out.println("复选框 : "+s);
//        }

    }

    /**
     * id查角色对应用户
     */
    @ResponseBody
    @RequestMapping("/selectByid")
    public int select(Role role) {
        System.out.println("要查询角色id : " + role.getId());
        List<Integer> list = roleService.findById(role.getId());

        System.out.println("此角色人数 : "+list.size());

        return list.size();
    }

    /**
     * 删除角色
     */
    @RequestMapping("/delByid")
    public void delete(Role role) {
        System.out.println("要删除角色id" + role.getId());
        roleService.deleteById(role.getId());
    }

    /**
     * 查询要编辑的角色
     */
    @RequestMapping("/findByid/{id}")
    public String findByid(
            @PathVariable
            int id,
            Model model){
        Role role = roleService.findRoleById(id);
        List<Privilege> allPrivi = roleService.findAllPrivi();

        model.addAttribute("role",role);
        model.addAttribute("allPrivi",allPrivi);
        return "role/role_modi";
    }

    /**
     * 编辑角色
     */
    @RequestMapping("/editRole")
    public void editRole(
            String[] privilegeList, HttpServletRequest request) {

        String[] values = request.getParameterValues("privilegeList");
        System.out.println(privilegeList);

    }

}
