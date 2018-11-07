package com.trainingcenter.bean;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/29
 * Time: 17:08
 */

/**
 * 权限表，对应数据库（tab_permission）
 */
public class Permission extends BaseEntity implements Serializable {
    /**
     * id,对应数据库（id）字段
     */
    @NotBlank(message = "权限id不能为空")
    private String id;

    /**
     * 权限名称,对应数据库（name）字段
     */
    @NotBlank(message = "权限名称不能为空")
    private String name;

    /**
     * 权限描述,对应数据库（describe）字段
     */
    private String describe;

    /**
     * 权限对应资源url,对应数据库（url）字段
     */
    private String url;

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

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @Override
    public String toString() {
        return "Permission{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", describe='" + describe + '\'' +
                ", url='" + url + '\'' +
                ", remarks='" + remarks + '\'' +
                ", createUserId='" + createUserId + '\'' +
                ", createDate=" + createDate +
                ", updateUserId='" + updateUserId + '\'' +
                ", updateDate=" + updateDate +
                '}';
    }
}