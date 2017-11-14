package com.lanou.user.mapper;

import com.lanou.user.domain.Admin;

import java.util.List;

/**
 * Created by dllo on 17/11/10.
 */
public interface AdminMapper {

    Admin verifyAdmin(Admin admin);

    void updatePwd(Admin admin);

    void updateAdmin(Admin admin);

    List<Admin> findAll();
}
