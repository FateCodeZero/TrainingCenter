package com.trainingcenter.bean;

import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Delete;
import com.trainingcenter.controller.validation.TC_Find;
import com.trainingcenter.controller.validation.TC_Update;
import org.hibernate.validator.constraints.Range;

import javax.validation.constraints.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 15:41
 *
 * 用户表，对应数据库（tab_user）表
 */
public class User implements Serializable {

    /**
     * id，对应数据库（id）字段
     */
    @NotBlank(message = "id不能为空",groups = {TC_Delete.class,TC_Find.class})
    private String id;

    /**
     * 用户名，对应数据库（username）字段
     */
    @NotBlank(message = "账号不能为空",groups = {TC_Add.class, TC_Update.class})
    @Email(message = "邮箱格式不正确",groups = {TC_Add.class, TC_Update.class})
    private String username;

    /**
     * 用户昵称，对应数据库（nickname）字段
     */
    private String nickname;

    /**
     * 用户头像URL，对应数据库（head_portrait）字段
     */
    private String headPortrait;

    /**
     * 用户真实姓名，对应数据库（real_name）字段
     */
    private String realName;

    /**
     * 生日，对应数据库（birthday）字段
     */
    @Past(message = "生日必须是一个过去的日期")
    private Date birthday;

    /**
     * 性别，对应数据库（gender）字段
     */
    @Range(min = 0,max = 1,message = "性别只能是0或1")
    private Integer gender;

    /**
     * 手机号，对应数据库（phone）字段
     */
    @Pattern(regexp = " ^1[0-9]{10}$",message = "手机号码格式不正确")
    private String phone;

    /**
     * 邮箱，对应数据库（email）字段
     */
    @Email(message = "邮箱格式不正确")
    private String email;

    /**
     * 地址，对应数据库（address）字段
     */
    private String address;

    /**
     * 用户签名，对应数据库（motto）字段
     */
    private String motto;

    /**
     * 用户类型ID，对应数据库（user_type_id）字段
     */
    private String userTypeId;

    /**
     * 用户编码（教职工与学生独有，教职工为职工编号，学生为学号，其他用户该字段为空）
     * 对应数据库（user_code）字段
     */
    private String userCode;

    /**
     * 用户描述，对应数据库（describe）字段
     */
    private String describe;

    /**
     * 用户相关图片，对应数据库（imgs）字段
     */
    private String imgs;

    /**
     * 用户使用状态，对应数据库（state）字段
     * 1：启用
     * 0：禁用
     * -1：已注销
     */
    @Range(min = -1,max = 1,message = "用户使用状态码只能是-1~1")
    private Integer state;

    /**
     * 注册时间，对应数据库（register_time）字段
     */
    private Date registerTime;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

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

    public String getHeadPortrait() {
        return headPortrait;
    }

    public void setHeadPortrait(String headPortrait) {
        this.headPortrait = headPortrait;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
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

    public String getMotto() {
        return motto;
    }

    public void setMotto(String motto) {
        this.motto = motto;
    }

    public String getUserTypeId() {
        return userTypeId;
    }

    public void setUserTypeId(String userTypeId) {
        this.userTypeId = userTypeId;
    }

    public String getUserCode() {
        return userCode;
    }

    public void setUserCode(String userCode) {
        this.userCode = userCode;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public String getImgs() {
        return imgs;
    }

    public void setImgs(String imgs) {
        this.imgs = imgs;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Date getRegisterTime() {
        return registerTime;
    }

    public void setRegisterTime(Date registerTime) {
        this.registerTime = registerTime;
    }

    @Override
    public String toString() {
        return "User{" +
                "id='" + id + '\'' +
                ", username='" + username + '\'' +
                ", nickname='" + nickname + '\'' +
                ", headPortrait='" + headPortrait + '\'' +
                ", realName='" + realName + '\'' +
                ", birthday=" + birthday +
                ", gender=" + gender +
                ", phone='" + phone + '\'' +
                ", email='" + email + '\'' +
                ", address='" + address + '\'' +
                ", motto='" + motto + '\'' +
                ", userTypeId='" + userTypeId + '\'' +
                ", userCode='" + userCode + '\'' +
                ", describe='" + describe + '\'' +
                ", imgs='" + imgs + '\'' +
                ", state=" + state +
                ", registerTime=" + registerTime +
                '}';
    }
}