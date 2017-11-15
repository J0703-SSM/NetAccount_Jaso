package com.lanou.user.service.impl;

import com.lanou.user.domain.Privilege;
import com.lanou.user.domain.Role;
import com.lanou.user.domain.Role_Privi;
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

    /**
     * 根据名称查角色
     * @param name
     * @return
     */
    public Role findByName(String name) {
        return roleMapper.findByName(name);
    }

    /**
     * 添加权限
     * @param role_privi
     */
    public void addPriviForRole(Role_Privi role_privi) {
        roleMapper.addPriviForRole(role_privi);
    }

    /**
     * 编辑角色
     * @param role1
     */
    public void editRole(Role role1) {
        roleMapper.editRole(role1);
    }

    /**
     * 删权限
     * @param id
     */
    public void delePrivi(int id) {
        roleMapper.delePrivi(id);
    }


}
