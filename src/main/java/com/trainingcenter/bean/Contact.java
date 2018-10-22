package com.trainingcenter.bean;

import java.io.Serializable;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 16:36
 *
 * 联系方式表，对应数据库（tab_contact）表
 */
public class Contact extends BaseEntity implements Serializable {
    /**
     * 联系方式名称，对应数据库（name）字段
     */
    private String name;

    /**
     * 联系方式内容，对应数据库（content）字段
     */
    private String content;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return "Contact{" +
                "name='" + name + '\'' +
                ", content='" + content + '\'' +
                ", id='" + id + '\'' +
                ", remarks='" + remarks + '\'' +
                ", createUserId='" + createUserId + '\'' +
                ", createDate=" + createDate +
                ", updateUserId='" + updateUserId + '\'' +
                ", updateDate=" + updateDate +
                '}';
    }
}