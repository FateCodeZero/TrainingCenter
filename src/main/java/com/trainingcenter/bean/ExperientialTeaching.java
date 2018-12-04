package com.trainingcenter.bean;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.util.Date;

/**
 * @author Liutingwei
 * @date 2018-11-6 15:40
 */
public class ExperientialTeaching implements Serializable {
    /**
     * id，对应数据库（id）字段
     */
    @NotBlank(message = "培训id不能为空")
    private String id;

    /**
     * title，对应数据库（id）字段
     */
    @NotBlank(message = "培训标题不能为空")
    private String title;

    /**
     *  content 培训内容
     */
    @NotBlank(message = "培训内容不能为空")
    private String content;

    /**
     *  imgs 培训图片
     */
    private String imgs;

    /**
     *  remarks 培训备注
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

    @Override
    public String toString() {
        return "ExperientialTeaching{" +
                "id='" + id + '\'' +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", imgs='" + imgs + '\'' +
                ", remarks='" + remarks + '\'' +
                ", createUserId='" + createUserId + '\'' +
                ", createDate=" + createDate +
                ", updateUserId='" + updateUserId + '\'' +
                ", updateDate=" + updateDate +
                '}';
    }

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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImgs() {
        return imgs;
    }

    public void setImgs(String imgs) {
        this.imgs = imgs;
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
}
