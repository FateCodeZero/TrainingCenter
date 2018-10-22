package com.trainingcenter.bean;

import java.io.Serializable;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 16:50
 *
 * 新闻资讯，对应数据库（tab_news_information）表
 */
public class NewsInformation extends BaseEntity implements Serializable {
    /**
     * 资讯标题，对应数据库（title）字段
     */
    private String title;

    /**
     * 资讯内容，对应数据库（content）字段
     */
    private String content;

    /**
     * 资讯相关图片URLS，对应数据库（img_urls）字段
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
        return "NewsInformation{" +
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