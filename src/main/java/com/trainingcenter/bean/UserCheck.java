package com.trainingcenter.bean;

import java.io.Serializable;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 16:27
 *
 * 用户检查验证表，对应数据库（tab_user_check）表
 */
public class UserCheck implements Serializable {
    /**
     * ID，对应数据库（id）字段
     */
    private String id;

    /**
     * 用户名，对应数据库（username）字段
     */
    private String username;

    /**
     * 密码，对应数据库（password）字段
     */
    private String password;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}