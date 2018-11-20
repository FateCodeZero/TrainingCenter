package com.trainingcenter.bean;

import java.io.Serializable;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/18
 * Time: 4:52
 */
public class Resource extends BaseEntity implements Serializable {
    /**
     * 主键ID，对应数据库（id）字段
     */
    private String id;
    /**
     * 资源名称，对应数据库（name）字段
     */
    private String name;
    /**
     * 资源对应URL，对应数据库（url）字段
     */
    private String url;
    /**
     * 资源使用状态，对应数据库（state）字段
     * （1：已启用，0：已禁用，-1：已删除）
     */
    private Integer state;

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

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }
}