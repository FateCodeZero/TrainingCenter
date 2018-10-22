package com.trainingcenter.bean;

import java.io.Serializable;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 16:46
 *
 * 培训课程，对应数据库（tab_course）表
 */
public class Course extends BaseEntity implements Serializable{
    /**
     * 课程名称，对应数据库（name）字段
     */
    private String name;

    /**
     * 课程描述，对应数据库（describe）字段
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
        return "Course{" +
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