package com.lanou.user.mapper;

import com.lanou.user.domain.Admin;
import com.lanou.user.domain.Admin_Role;
import com.lanou.user.domain.Role;

import java.util.List;

/**
 * Created by dllo on 17/11/10.
 */
public interface AdminMapper {

    Admin verifyAdmin(Admin admin);

    void updatePwd(Admin admin);

    void updateAdmin(Admin admin);

    List<Admin> findAll();

    List<Role> findAllRole();

    Admin findByAdminCode(String admin_code);

    void addAdmin(Admin admin);

    void addRoleForAdmin(Admin_Role admin_role);

    void deleteAdmin(int id);

    void resetPwd(int id);

    Admin findByEmail(String email);

    void updateByEmail(String email);
}
