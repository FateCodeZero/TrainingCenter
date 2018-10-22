package com.trainingcenter.bean;

import java.io.Serializable;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 17:01
 *
 * 用户类型，对应数据库（tab_user_type）表
 */
public class UserType extends BaseEntity implements Serializable{
    /**
     * 用户类型名称，对应数据库（name）字段
     */
    private String name;

    /**
     * 用户类型描述，对应数据库（describe）字段
     */
    private String describe;

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

    @Override
    public String toString() {
        return "UserType{" +
                "name='" + name + '\'' +
                ", describe='" + describe + '\'' +
                ", id='" + id + '\'' +
                ", remarks='" + remarks + '\'' +
                ", createUserId='" + createUserId + '\'' +
                ", createDate=" + createDate +
                ", updateUserId='" + updateUserId + '\'' +
                ", updateDate=" + updateDate +
                '}';
    }
}
