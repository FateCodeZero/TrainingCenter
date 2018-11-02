package com.trainingcenter.bean;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/29
 * Time: 17:03
 */

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * 角色表，对应数据库（tab_role）
 */
public class Role extends BaseEntity implements Serializable{
    /**
     * id，对应数据库（id）字段
     */
    @NotBlank(message = "角色id不能为空")
    private String id;

    /**
     * 角色名称，对应数据库（name）字段
     */
    @NotBlank(message = "角色名称不能为空")
    private String name;

    /**
     * 角色描述，对应数据库（describe）字段
     */
    private String describe;

    /**
     * 角色所含权限ids，对应数据库（permission_ids）字段
     */
    private String permissionIds;

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

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public String getPermissionIds() {
        return permissionIds;
    }

    public void setPermissionIds(String permissionIds) {
        this.permissionIds = permissionIds;
    }

    @Override
    public String toString() {
        return "Role{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", describe='" + describe + '\'' +
                ", permissionIds='" + permissionIds + '\'' +
                ", remarks='" + remarks + '\'' +
                ", createUserId='" + createUserId + '\'' +
                ", createDate=" + createDate +
                ", updateUserId='" + updateUserId + '\'' +
                ", updateDate=" + updateDate +
                '}';
    }
}