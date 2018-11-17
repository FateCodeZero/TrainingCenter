package com.trainingcenter.bean;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/5
 * Time: 20:36
 */

import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Delete;
import com.trainingcenter.controller.validation.TC_Find;
import com.trainingcenter.controller.validation.TC_Update;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * 用户-权限对应信息维护类，对应数据库（tab_login_info_role）表
 */
public class UserRole implements Serializable{
    /**
     * 表id，对应数据库（id）字段
     */
    @NotBlank(message = "id不能为空",groups = {TC_Delete.class,TC_Find.class})
    private String id;

    /**
     * 对应用户登录信息id，对应数据库（user_id）字段
     */
    @NotBlank(message = "被授权用户不能为空",groups = {TC_Add.class, TC_Update.class})
    private String userId;

    /**
     * 对应角色id，对应数据库（role_id）字段
     */
    @NotBlank(message = "所授角色不能为空",groups = {TC_Add.class, TC_Update.class})
    private String roleId;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }
}