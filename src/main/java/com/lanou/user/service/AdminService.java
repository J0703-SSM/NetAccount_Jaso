package com.lanou.user.service;

import com.lanou.user.domain.Admin;

import java.util.List;

/**
 * Created by dllo on 17/11/11.
 */
public interface AdminService {

    Admin verifyAdmin(Admin admin);

    void updatePwd(Admin admin);

    void updateAdmin(Admin admin);

    List<Admin> findAll();

}
