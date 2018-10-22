package com.trainingcenter.bean;

import java.io.Serializable;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 16:40
 *
 * 中心简介，对应数据库（tab_core_introduce）表
 */
public class CoreIntroduce extends BaseEntity implements Serializable {
    /**
     *中心简介内容，对应数据库（content）字段
     */
    private String content;

    /**
     * 中心简介相关图片URLS，对应数据库（img_urls）字段
     */
    private String imgUrls;

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImgUrls() {
        return imgUrls;
    }

    public void setImgUrls(String imgUrls) {
        this.imgUrls = imgUrls;
    }

    @Override
    public String toString() {
        return "CoreIntroduce{" +
                "content='" + content + '\'' +
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