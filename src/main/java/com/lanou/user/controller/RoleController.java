package com.lanou.user.controller;

import com.lanou.user.domain.Privilege;
import com.lanou.user.domain.Role;
import com.lanou.user.domain.Role_Privi;
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
import java.util.Arrays;
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
    @ResponseBody
    @RequestMapping("/addRole")
    public int addRole(
            @RequestParam(value = "privilegeList[]")
                    int[] privilegeList,
            @RequestParam(value = "name")
                    String name) {

        //去重复
        Role role = roleService.findByName(name);
        if (role == null) {
            //添加角色
            Role newRole = new Role();
            newRole.setName(name);
            roleService.addRole(newRole);
            //添加权限对应
            for (int i : privilegeList) {

                Role_Privi role_privi = new Role_Privi();
                role_privi.setRole_id(roleService.findByName(name).getId());
                role_privi.setPrivilege_id(i);
                roleService.addPriviForRole(role_privi);
            }


            return 1;
        }
        //名字重复,保存失败
        return 0;


    }

    /**
     * id查角色对应用户
     */
    @ResponseBody
    @RequestMapping("/selectByid")
    public int select(Role role) {
        System.out.println("delete : "+role.getId());
        List<Integer> list = roleService.findById(role.getId());

        return list.size();
    }

    /**
     * 删除角色
     */
    @RequestMapping("/delByid")
    public void delete(Role role) {
        roleService.deleteById(role.getId());
    }

    /**
     * 查询要编辑的角色
     */
    @RequestMapping("/findByid/{id}")
    public String findByid(
            @PathVariable
                    int id,
            Model model) {
        Role role = roleService.findRoleById(id);

        List<Privilege> allPrivi = roleService.findAllPrivi();

        model.addAttribute("role", role);
        model.addAttribute("allPrivi", allPrivi);
        return "role/role_modi";
    }

    /**
     * 编辑角色
     */
    @ResponseBody
    @RequestMapping("/editRole")
    public int editRole(
            @RequestParam(value = "privilegeList[]")
                    int[] privilegeList,
            @RequestParam(value = "name")
                    String name,
            @RequestParam(value = "id")
                    int id) {

        //去重复
        Role role = roleService.findByName(name);
        Role role1 = roleService.findRoleById(id);
        if (role == null || role.getName().equals(role1.getName())) {
            //编辑角色
            role1.setName(name);
            roleService.editRole(role1);
            //添加权限对应
            roleService.delePrivi(role1.getId());
            for (int i : privilegeList) {

                Role_Privi role_privi = new Role_Privi();
                role_privi.setRole_id(role1.getId());
                role_privi.setPrivilege_id(i);
                roleService.addPriviForRole(role_privi);
            }


            return 1;
        }
        //名字重复,保存失败
        return 0;

    }

}
