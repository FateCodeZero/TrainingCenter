package com.trainingcenter.bean;

import javax.validation.constraints.NotBlank;
import java.util.Date;

/**
 * @author Liutingwei
 * @date 2018-11-19 17:42
 */
public class StudentMien {
    /**
     * id，对应数据库（id）字段
     */
    @NotBlank(message = "学员风采id不能为空")
    private String id;

    /**
     * title 标题
     */
    private String title;
    /**
     *  imgs 学员风采图片
     */
    private String imgs;

    /**
     *  content 学员风采内容
     */
    private String content;

    /**
     *  remarks 学员风采备注
     */
    private String remarks;

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

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImgs() {
        return imgs;
    }

    public void setImgs(String imgs) {
        this.imgs = imgs;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
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

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    @Override
    public String toString() {
        return "StudentMien{" +
                "id='" + id + '\'' +
                ", title='" + title + '\'' +
                ", imgs='" + imgs + '\'' +
                ", content='" + content + '\'' +
                ", remarks='" + remarks + '\'' +
                ", createUserId='" + createUserId + '\'' +
                ", createDate=" + createDate +
                ", updateUserId='" + updateUserId + '\'' +
                ", updateDate=" + updateDate +
                '}';
    }
}
