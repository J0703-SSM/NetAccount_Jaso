package com.lanou.user.service.impl;

import com.lanou.user.domain.Admin;
import com.lanou.user.domain.Admin_Role;
import com.lanou.user.domain.Role;
import com.lanou.user.mapper.AdminMapper;
import com.lanou.user.service.AdminService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by dllo on 17/11/11.
 */

@Service("adminService")
public class AdminServiceImpl implements AdminService {
    /**
     * 持有的dao层对象
     */
    @Resource
    private AdminMapper adminMapper;


    /**
     * 登录验证查询
     * @param admin
     * @return
     */
    public Admin verifyAdmin(Admin admin) {
        return adminMapper.verifyAdmin(admin);
    }

    /**
     * 修改密码
     * @param admin
     */
    public void updatePwd(Admin admin) {
        adminMapper.updatePwd(admin);
    }

    /**
     * 修改信息
     * @param admin
     */
    public void updateAdmin(Admin admin) {
        adminMapper.updateAdmin(admin);
    }

    /**
     * 查询所有admin
     * @return
     */
    public List<Admin> findAll() {
        return adminMapper.findAll();
    }

    /**
     * 查询所有角色
     * @return
     */
    public List<Role> findAllRole() {
        return adminMapper.findAllRole();
    }

    /**
     * 根据登录名查管理员
     * @param admin_code
     * @return
     */
    public Admin findByAdminCode(String admin_code) {
        return adminMapper.findByAdminCode(admin_code);
    }

    /**
     * 添加管理员
     * @param admin
     */
    public void addAdmin(Admin admin) {
        adminMapper.addAdmin(admin);
    }

    /**
     * 给管理员添加角色
     * @param admin_role
     */
    public void addRoleForAdmin(Admin_Role admin_role) {
        adminMapper.addRoleForAdmin(admin_role);
    }

    /**
     * 删除管理员
     * @param id
     */
    public void deleteAdmin(int id) {
        adminMapper.deleteAdmin(id);
    }

    /**
     * 重置密码
     * @param id
     */
    public void resetPwd(int id) {
        adminMapper.resetPwd(id);
    }

    /**
     * 验证邮箱
     * @param email
     * @return
     */
    public Admin findByEmail(String email) {
        return adminMapper.findByEmail(email);
    }

    /**
     * 初始密码
     * @param email
     */
    public void updateByEmail(String email) {
        adminMapper.updateByEmail(email);
    }
}
