package com.lanou.user.service.impl;

import com.lanou.user.domain.Privilege;
import com.lanou.user.domain.Role;
import com.lanou.user.mapper.RoleMapper;
import com.lanou.user.service.RoleService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by dllo on 17/11/13.
 */
@Service("roleService")
public class RoleServiceImpl implements RoleService {

    /**
     * 持有的dao层对象
     */
    @Resource
    private RoleMapper roleMapper;

    /**
     * 查询所有角色信息
     * @return
     */
    public List<Role> findAll() {
        return roleMapper.findAll();
    }

    /**
     * 查询所有权限
     * @return
     */
    public List<Privilege> findAllPrivi() {
        return roleMapper.findAllPrivi();
    }

    /**
     * 添加角色
     * @param role
     */
    public void addRole(Role role) {
        roleMapper.addRole(role);
    }

    /**
     * id查用户
     * @param id
     * @return
     */
    public List<Integer> findById(int id) {
        return roleMapper.findById(id);
    }

    /**
     * 删除
     * @param id
     */
    public void deleteById(int id) {
        roleMapper.delete(id);
    }

    /**
     * 根据id查角色信息
     * @param id
     * @return
     */
    public Role findRoleById(int id) {
        return roleMapper.findRoleById(id);
    }
}
