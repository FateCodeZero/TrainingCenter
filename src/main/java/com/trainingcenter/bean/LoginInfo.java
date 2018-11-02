package com.trainingcenter.bean;

import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 16:27
 *
 * 用户检查验证表，对应数据库（tab_user_check）表
 */
public class LoginInfo implements Serializable {
    /**
     * ID，对应数据库（id）字段
     */
    @NotBlank(message = "登录信息id不能为空")
    private String id;

    /**
     * 用户名，对应数据库（username）字段
     */
    @NotBlank(message = "账号不能为空")
    @Email(message = "邮箱格式不正确")
    private String username;

    /**
     * 密码，对应数据库（password）字段
     */
    @NotBlank(message = "密码不能为空")
    @Length(min=6,max=18,message="密码长度必须在6~18位")
    private String password;

    /**
     * 用户登录IP，对应数据库（login_IP）字段
     */
    private String loginIP;

    /**
     * 最后登录时间，对应数据库（last_login_time）字段
     */
    private Date lastLoginTime;

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

    public String getLoginIP() {
        return loginIP;
    }

    public void setLoginIP(String loginIP) {
        this.loginIP = loginIP;
    }

    public Date getLastLoginTime() {
        return lastLoginTime;
    }

    public void setLastLoginTime(Date lastLoginTime) {
        this.lastLoginTime = lastLoginTime;
    }

    @Override
    public String toString() {
        return "LoginInfo{" +
                "id='" + id + '\'' +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", loginIP='" + loginIP + '\'' +
                ", lastLoginTime=" + lastLoginTime +
                '}';
    }
}