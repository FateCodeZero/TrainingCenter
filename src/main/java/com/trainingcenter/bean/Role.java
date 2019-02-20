package com.trainingcenter.bean;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/29
 * Time: 17:03
 */

import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Delete;
import com.trainingcenter.controller.validation.TC_Find;
import com.trainingcenter.controller.validation.TC_Update;
import org.hibernate.validator.constraints.Range;
import org.springframework.security.core.GrantedAuthority;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Collection;

/**
 * 角色表，对应数据库（tab_role）
 */
public class Role extends BaseEntity implements Serializable,GrantedAuthority {
    /**
     * id，对应数据库（id）字段
     */
    @NotBlank(message = "id不能为空",groups = {TC_Update.class,TC_Delete.class,TC_Find.class})
    private String id;

    /**
     * 角色名称，对应数据库（name）字段
     */
    @NotBlank(message = "角色名称不能为空",groups = {TC_Add.class, TC_Update.class})
    private String name;

    /**
     * 使用状态，对应数据库（state）字段
     * （1：已启用，0：已禁用，-1：已删除）
     */
    @NotNull(message = "使用状态不能为空",groups = {TC_Add.class, TC_Update.class})
    @Range(min = -1,max = 1,message = "用户使用状态范围只能在-1~1",groups = {TC_Update.class})
    private Integer state;

    /**
     * 角色描述，对应数据库（describe）字段
     */
    private String describe;

    /**
     * 角色所含的全部权限
     */
    private Collection<Permission> permissions;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public Collection<Permission> getPermissions() {
        return permissions;
    }

    public void setPermissions(Collection<Permission> permissions) {
        this.permissions = permissions;
    }

    /**
     * 获取角色名称，security用
     *  按 security 的需求，所有角色必须有 ROLE_ 前缀
     * @return 返回角色名称
     */
    public String getAuthority() {
        return "ROLE_" + this.name;
    }
}