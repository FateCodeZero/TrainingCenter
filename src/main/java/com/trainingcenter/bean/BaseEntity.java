package com.trainingcenter.bean;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 15:36
 *
 * 数据库公共字段
 */
public class BaseEntity implements Serializable {

    /**
     * 备注，对应数据库各表的（remarks）字段
     */
    protected String remarks;

    /**
     * 创建人ID，对应数据库各表的（create_user_id）字段
     */
    protected String createUserId;

    /**
     * 创建时间，对应数据库各表的（create_date）字段
     */
    protected Date createDate;

    /**
     * 更新人ID，对应数据库各表的（update_user_id）字段
     */
    protected String updateUserId;

    /**
     * 更新时间，对应数据库各表的（update_date）字段
     */
    protected Date updateDate;

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