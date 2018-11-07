package com.trainingcenter.bean;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/5
 * Time: 20:36
 */

/**
 * 用户-权限对应信息维护类，对应数据库（tab_login_info_role）表
 */
public class LoginInfoRole extends BaseEntity{
    /**
     * 表id，对应数据库（id）字段
     */
    private String id;

    /**
     * 对应用户登录信息id，对应数据库（login_info_id）字段
     */
    private String loginInfoId;

    /**
     * 对应角色id，对应数据库（role_id）字段
     */
    private String roleId;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLoginInfoId() {
        return loginInfoId;
    }

    public void setLoginInfoId(String loginInfoId) {
        this.loginInfoId = loginInfoId;
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    @Override
    public String toString() {
        return "LoginInfoRole{" +
                "id='" + id + '\'' +
                ", loginInfoId='" + loginInfoId + '\'' +
                ", roleId='" + roleId + '\'' +
                ", remarks='" + remarks + '\'' +
                ", createUserId='" + createUserId + '\'' +
                ", createDate=" + createDate +
                ", updateUserId='" + updateUserId + '\'' +
                ", updateDate=" + updateDate +
                '}';
    }
}