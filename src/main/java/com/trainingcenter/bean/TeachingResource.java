package com.trainingcenter.bean;

import java.io.Serializable;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 16:52
 *
 * 教学资源，对应数据库（tab_teaching_resource）表
 */
public class TeachingResource extends BaseEntity implements Serializable{
    /**
     * 教学资源名称，对应数据库（name）字段
     */
    private String name;

    /**
     * 教学资源描述，对应数据库（describe）字段
     */
    private String describe;

    /**
     * 教学资源相关图片URLS，对应数据库（img_urls）字段
     */
    private String imgUrls;

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

    public String getImgUrls() {
        return imgUrls;
    }

    public void setImgUrls(String imgUrls) {
        this.imgUrls = imgUrls;
    }

    @Override
    public String toString() {
        return "TeachingResource{" +
                "name='" + name + '\'' +
                ", describe='" + describe + '\'' +
                ", imgUrls='" + imgUrls + '\'' +
                ", id='" + id + '\'' +
                ", remarks='" + remarks + '\'' +
                ", createUserId='" + createUserId + '\'' +
                ", createDate=" + createDate +
                ", updateUserId='" + updateUserId + '\'' +
                ", updateDate=" + updateDate +
                '}';
    }
}