package com.trainingcenter.bean;

import java.io.Serializable;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 16:58
 *
 * 培训动态表，对应数据库（tab_training_dynamic）表
 */
public class TrainingDynamic extends BaseEntity implements Serializable {
    /**
     * 培训动态标题，对应数据库（title）字段
     */
    private String title;

    /**
     * 培训动态内容，对应数据库（content）字段
     */
    private String content;

    /**
     * 培训动态图片相关URLS，对应数据库（img_urls）字段
     */
    private String imgUrls;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

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
        return "TrainingDynamic{" +
                "title='" + title + '\'' +
                ", content='" + content + '\'' +
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