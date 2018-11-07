package com.trainingcenter.bean;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.Range;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.util.Collection;
import java.util.Date;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 16:27
 *
 * 用户检查验证表，对应数据库（tab_user_check）表
 */
public class LoginInfo implements Serializable,UserDetails {
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
     * 用户使用状态，对应数据库（state）字段
     * （-1：已注销，0：已禁用，1：已启用）
     */
    @Range(min = -1,max = 1,message = "用户使用状态范围只能在-1~1")
    private Integer state;

    /**
     * 用户锁定IP不锁定状态，对应数据库（is_locked）字段
     * （0：被锁定，1：不锁定）
     */
    @Range(min = -1,max = 1,message = "IP未锁定状态的范围只能在-1~1")
    private Integer isUnlocked;

    /**
     * 最后登录时间，对应数据库（last_login_time）字段
     */
    private Date lastLoginTime;

    /**
     * 用户所含角色集合
     */
    private Collection<? extends GrantedAuthority> authorities;

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

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Integer getIsUnlocked() {
        return isUnlocked;
    }

    public void setIsUnlocked(Integer isUnlocked) {
        this.isUnlocked = isUnlocked;
    }

    public Date getLastLoginTime() {
        return lastLoginTime;
    }

    public void setLastLoginTime(Date lastLoginTime) {
        this.lastLoginTime = lastLoginTime;
    }

    /**
     * 获取当前用户权限集合
     * @return
     */
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    /**
     * 设置用户权限
     * @param authorities
     */
    public void setAuthorities(Collection<? extends GrantedAuthority> authorities) {
        this.authorities = authorities;
    }

    /**
     * 账号是否未过期
     * @return
     */
    public boolean isAccountNonExpired() {
        return true;
    }

    /**
     * 账号是否未被锁住
     * @return
     */
    public boolean isAccountNonLocked() {
        return this.isUnlocked == 1;
    }

    /**
     * 登录凭证是否未过期
     * @return
     */
    public boolean isCredentialsNonExpired() {
        return true;
    }

    /**
     * 账号是否启用
     * @return
     */
    public boolean isEnabled() {
        return this.state == 1;
    }

    @Override
    public String toString() {
        return "LoginInfo{" +
                "id='" + id + '\'' +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", loginIP='" + loginIP + '\'' +
                ", state=" + state +
                ", isUnlocked=" + isUnlocked +
                ", lastLoginTime=" + lastLoginTime +
                ", authorities=" + authorities +
                '}';
    }
}