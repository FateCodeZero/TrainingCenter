package com.trainingcenter.bean;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/29
 * Time: 17:15
 */

/**
 * 权限资源表，对应数据库（tab_resource）表
 */
public class Resource extends BaseEntity implements Serializable{
    /**
     * id，对应数据库（id）字段
     */
    @NotBlank(message = "资源id不能为空")
    private String id;

    /**
     * 资源名称，对应数据库（name）字段
     */
    @NotBlank(message = "资源名称不能为空")
    private String name;

    /**
     * 资源描述，对应数据库（describe）字段
     */
    private String describe;

    /**
     * 资源对应url，对应数据库（url）字段
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
        return "Resource{" +
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