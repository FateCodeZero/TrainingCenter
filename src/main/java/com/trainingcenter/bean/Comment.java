package com.trainingcenter.bean;

import java.io.Serializable;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 16:30
 *
 * 评论表（学员心声），对应数据库（tab_comment）表
 */
public class Comment extends BaseEntity implements Serializable {
    /**
     * 评论内容，对应数据库（content）字段
     */
    private String content;

    /**
     * 审核状态（-1：未审核，0：未通过，1通过）
     * 对应数据库（state）字段
     */
    private Integer state;

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    @Override
    public String toString() {
        return "Comment{" +
                "content='" + content + '\'' +
                ", state=" + state +
                ", id='" + id + '\'' +
                ", remarks='" + remarks + '\'' +
                ", createUserId='" + createUserId + '\'' +
                ", createDate=" + createDate +
                ", updateUserId='" + updateUserId + '\'' +
                ", updateDate=" + updateDate +
                '}';
    }
}