package com.trainingcenter.bean;

import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Delete;
import com.trainingcenter.controller.validation.TC_Find;
import com.trainingcenter.controller.validation.TC_Update;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.Range;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
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
public class User implements Serializable,UserDetails {
    /**
     * ID，对应数据库（id）字段
     */
    @NotBlank(message = "id不能为空",groups = {TC_Update.class,TC_Delete.class,TC_Find.class})
    private String id;

    /**
     * 用户名，对应数据库（username）字段
     */
    @NotBlank(message = "账号不能为空",groups = {TC_Add.class,TC_Update.class})
    private String username;

    /**
     * 密码，对应数据库（password）字段
     */
    @NotBlank(message = "密码不能为空",groups = {TC_Add.class})
    @Length(min=6,max=18,message="密码长度必须在6~18位",groups = {TC_Add.class,TC_Update.class})
    private String password;

    /**
     * 用户登录IP，对应数据库（login_IP）字段
     */
    private String loginIP;

    /**
     * 用户锁定IP解锁标志，对应数据库（unlockedFlag）字段
     * （0：锁定，1：解锁）
     */
    @Range(min = -1,max = 1,message = "IP未锁定状态的范围只能在-1~1",groups = {TC_Update.class})
    private Integer unlockedFlag;

    /**
     * 账号使用状态，对应数据库（state）字段
     * （-1：已注销，0：已禁用，1：已启用）
     */
    @NotNull(message = "使用状态不能为空",groups = {TC_Add.class, TC_Update.class})
    @Range(min = -1,max = 1,message = "用户使用状态范围只能在-1~1",groups = {TC_Update.class})
    private Integer state;

    /**
     * 注册时间，对应数据库（register_time）字段
     */
    private Date registerTime;
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

    @Override
    public String getUsername() {
        return username;
    }

    /**
     * 账号是否未 过期
     * @return
     */
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    /**
     * 账号是否未 被锁定
     * @return
     */
    @Override
    public boolean isAccountNonLocked() {
        return this.unlockedFlag == 1;
    }

    /**
     * 登录凭证是否未 过期
     * @return
     */
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    /**
     * 账号是否已启用
     * @return
     */
    @Override
    public boolean isEnabled() {
        return this.state == 1;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Override
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

    public Integer getUnlockedFlag() {
        return unlockedFlag;
    }

    public void setUnlockedFlag(Integer unlockedFlag) {
        this.unlockedFlag = unlockedFlag;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Date getRegisterTime() {
        return registerTime;
    }

    public void setRegisterTime(Date registerTime) {
        this.registerTime = registerTime;
    }

    public Date getLastLoginTime() {
        return lastLoginTime;
    }

    public void setLastLoginTime(Date lastLoginTime) {
        this.lastLoginTime = lastLoginTime;
    }

    /**
     * 用户所含权限集合
     * @return
     */
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    public void setAuthorities(Collection<? extends GrantedAuthority> authorities) {
        this.authorities = authorities;
    }
}