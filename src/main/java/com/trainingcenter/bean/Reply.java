package com.trainingcenter.bean;

import java.util.Date;

/**
 * @author Liutingwei
 * @date 2018-12-6 16:00
 */
public class Reply {
    private String id;
    private String commentId;
    private String content;

    private Long praiseCount;
    /**
     * 创建人ID，对应数据库各表的（createUserId）字段
     */
    private String createUserId;

    /**
     * 创建时间，对应数据库各表的（create_date）字段
     */
    private Date createDate;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCommentId() {
        return commentId;
    }

    public void setCommentId(String commentId) {
        this.commentId = commentId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Long getPraiseCount() {
        return praiseCount;
    }

    public void setPraiseCount(Long praiseCount) {
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

    @Override
    public String toString() {
        return "Reply{" +
                "id='" + id + '\'' +
                ", comment_id='" + commentId + '\'' +
                ", content='" + content + '\'' +
                ", praiseCount=" + praiseCount +
                ", createUserId='" + createUserId + '\'' +
                ", createDate=" + createDate +
                '}';
    }
}
