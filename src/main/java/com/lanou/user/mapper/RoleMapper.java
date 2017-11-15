package com.lanou.user.mapper;

import com.lanou.user.domain.Privilege;
import com.lanou.user.domain.Role;
import com.lanou.user.domain.Role_Privi;

import java.util.List;

/**
 * Created by dllo on 17/11/13.
 */
public interface RoleMapper {
    List<Role> findAll();

    List<Privilege> findAllPrivi();

    void addRole(Role role);

    List<Integer> findById(int id);

    void delete(int id);

    Role findRoleById(int id);

    Role findByName(String name);

    void addPriviForRole(Role_Privi role_privi);

    void editRole(Role role1);

    void delePrivi(int id);
}
