package com.lanou.base.test;

import com.lanou.user.domain.Admin;
import com.lanou.user.domain.Privilege;
import com.lanou.user.domain.Role;
import com.lanou.user.mapper.AdminMapper;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 *  测试类.
 */
public class MainTest {


    private ApplicationContext context;
    private AdminMapper adminMapper;

    @Before
    public void init(){
        /*启动Spring容器*/
        context = new ClassPathXmlApplicationContext("spring-config.xml");

        /* 用户管理模块 */
        adminMapper = context.getBean(AdminMapper.class);
    }


    @Test
    public void selectTest(){
        Admin admin = new Admin();
        admin.setAdmin_code("jaso");
        admin.setPassword("123");
        Admin admin1 = adminMapper.verifyAdmin(admin);
        System.out.println("查到用户 : "+admin1);
        for (Role role : admin1.getRoleList()) {
            System.out.println("角色 : "+role);
            for (Privilege privilege : role.getPrivilegeList()) {
                System.out.println("权限 : "+privilege);
            }
        }
    }
}
