package com.trainingcenter.bean;

import java.io.Serializable;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 15:41
 *
 * 用户表，对应数据库（tab_user）表
 */
public class User extends BaseEntity implements Serializable {
    /**
     * 用户名，对应数据库（username）字段
     */
    private String username;

    /**
     * 用户昵称，对应数据库（nickname）字段
     */
    private String nickname;

    /**
     * 用户头像URL，对应数据库（head_portrait_url）字段
     */
    private String headPortraitUrl;

    /**
     * 性别，对应数据库（gender）字段
     */
    private Integer gender;

    /**
     * 手机号，对应数据库（phone）字段
     */
    private String phone;

    /**
     * 邮箱，对应数据库（email）字段
     */
    private String email;

    /**
     * 地址，对应数据库（address）字段
     */
    private String address;

    /**
     * 用户签名，对应数据库（signature）字段
     */
    private String signature;

    /**
     * 用户类型ID，对应数据库（user_type_id）字段
     */
    private String userTypeId;

    /**
     * 用户编码（教职工与学生独有，教职工为职工编号，学生为学号），
     * 对应数据库（user_type_id）字段
     */
    private String code;

    /**
     * 用户描述，对应数据库（describe）字段
     */
    private String describe;

    /**
     * 用户相关图片，对应数据库（img_urls）字段
     */
    private String imgUrls;

    /**
     * 用户使用状态，对应数据库（state）字段
     */
    private Integer state;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getHeadPortraitUrl() {
        return headPortraitUrl;
    }

    public void setHeadPortraitUrl(String headPortraitUrl) {
        this.headPortraitUrl = headPortraitUrl;
    }

    public Integer getGender() {
        return gender;
    }

    public void setGender(Integer gender) {
        this.gender = gender;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getSignature() {
        return signature;
    }

    public void setSignature(String signature) {
        this.signature = signature;
    }

    public String getUserTypeId() {
        return userTypeId;
    }

    public void setUserTypeId(String userTypeId) {
        this.userTypeId = userTypeId;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public String getImgUrls() {
        return imgUrls;
    }

    public void setImgUrls(String imgUrls) {
        this.imgUrls = imgUrls;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    @Override
    public String toString() {
        return "User{" +
                "username='" + username + '\'' +
                ", nickname='" + nickname + '\'' +
                ", headPortraitUrl='" + headPortraitUrl + '\'' +
                ", gender=" + gender +
                ", phone='" + phone + '\'' +
                ", email='" + email + '\'' +
                ", address='" + address + '\'' +
                ", signature='" + signature + '\'' +
                ", userTypeId='" + userTypeId + '\'' +
                ", code='" + code + '\'' +
                ", describe='" + describe + '\'' +
                ", imgUrls='" + imgUrls + '\'' +
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