package com.trainingcenter.bean;

import java.util.Date;

/**
 * @author Liutingwei
 * @date 2018-12-6 15:52
 */
public class Comment {
    private String id;
    private String title;
    private Integer state;
    private String content;

    private Integer replyCount;
    private Integer praiseCount;
    /**
     * 创建人ID，对应数据库各表的（createUserId）字段
     */
    private String createUserId;

    /**
     * 创建时间，对应数据库各表的（create_date）字段
     */
    private Date createDate;

    /**
     * 更新人ID，对应数据库各表的（updateUserId）字段
     */
    private String updateUserId;

    /**
     * 更新时间，对应数据库各表的（updateDate）字段
     */
    private Date updateDate;

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getReplyCount() {
        return replyCount;
    }

    public void setReplyCount(int replyCount) {
        this.replyCount = replyCount;
    }

    public Integer getPraiseCount() {
        return praiseCount;
    }

    public void setPraiseCount(int praiseCount) {
        this.praiseCount = praiseCount;
    }

    public String getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(String createUserId) {
        this.createUserId = createUserId;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getUpdateUserId() {
        return updateUserId;
    }

    public void setUpdateUserId(String updateUserId) {
        this.updateUserId = updateUserId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "Comment{" +
                "title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", replyCount=" + replyCount +
                ", praiseCount=" + praiseCount +
                ", createUserId='" + createUserId + '\'' +
                ", createDate=" + createDate +
                ", updateUserId='" + updateUserId + '\'' +
                ", updateDate=" + updateDate +
                '}';
    }
}

