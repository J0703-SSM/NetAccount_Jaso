package com.lanou.user.service.impl;

import com.lanou.user.domain.Admin;
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
}
