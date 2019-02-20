package com.trainingcenter.bean;

import javax.validation.constraints.NotBlank;
import java.util.Date;

/**
 * @author Liutingwei
 * @date 2018-11-7 15:45
 */
public class Advertisement {
    /**
     * id，对应数据库（id）字段
     */
    @NotBlank(message = "广告id不能为空")
    private String id;

    /**
     *  imgs 广告图片
     */
    private String imgs;

    /**
     *  describe 广告描述
     */
    private String describe;

    /**
     * url，对应数据库（id）字段
     */

    @NotBlank(message = "广告链接不能为空")
    private String url;

    /**
     * start: 广告开始时间
     */
    @NotBlank(message = "广告开始时间不能为空")
    private String start;
    /**
     * end: 广告结束时间
     */
    @NotBlank(message = "广告结束时间不能为空")
    private String end;

    /**
     *  remarks 广告备注
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
        return "Advertisement{" +
                "id='" + id + '\'' +
                ", imgs='" + imgs + '\'' +
                ", describe='" + describe + '\'' +
                ", url='" + url + '\'' +
                ", start=" + start +
                ", end=" + end +
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

    public String getImgs() {
        return imgs;
    }

    public void setImgs(String imgs) {
        this.imgs = imgs;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getEnd() {
        return end;
    }

    public void setEnd(String end) {
        this.end = end;
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
