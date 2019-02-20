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
 * 用户信息表，对应数据库（tab_user_info）表
 */
public class UserInfo implements Serializable {

    /**
     * id，对应数据库（id）字段
     */
    @NotBlank(message = "id不能为空",groups = {TC_Update.class,TC_Delete.class,TC_Find.class})
    private String id;

    /**
     * 用户名，对应数据库（username）字段
     */
    @NotBlank(message = "账号不能为空",groups = {TC_Add.class, TC_Update.class})
    private String username;

    /**
     * 用户昵称，对应数据库（nickname）字段
     */
    private String nickname;

    /**
     * 用户真实姓名，对应数据库（real_name）字段
     */
    private String realName;

    /**
     * 用户头像URL，对应数据库（portrait_img）字段
     */
    private String portraitImg;

    /**
     * 性别，对应数据库（gender）字段
     */
    @Range(min = 0,max = 1,message = "性别只能是0或1",groups = {TC_Add.class,TC_Update.class})
    private Integer gender;

    /**
     * 生日，对应数据库（birthday）字段
     */
    @Past(message = "生日必须是一个过去的日期",groups = {TC_Add.class,TC_Update.class})
    private Date birthday;

    /**
     * 地址，对应数据库（address）字段
     */
    private String address;

    /**
     * 邮政编码，对应数据库（postal_code）字段
     */
    private String postalCode;

    /**
     * 邮箱，对应数据库（email）字段
     */
    @Email(message = "邮箱格式不正确")
    private String email;

    /**
     * 手机号，对应数据库（phone）字段
     */
    @Pattern(regexp = " ^1[0-9]{10}$",message = "手机号码格式不正确",groups = {TC_Add.class,TC_Update.class})
    private String phone;

    /**
     * 用户签名，对应数据库（motto）字段
     */
    private String motto;

    /**
     * 个人简介，对应数据库（describe）字段
     */
    private String describe;

    /**
     * 用户相关图片，对应数据库（imgs）字段
     */
    private String imgs;

    /**
     * 工作单位（公司），对应数据库（company）字段
     */
    private String company;

    /**
     * 职位，对应数据库（position）字段
     */
    private String position;

    /**
     * 职业，对应数据库（career）字段
     */
    private String career;

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

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getPortraitImg() {
        return portraitImg;
    }

    public void setPortraitImg(String portraitImg) {
        this.portraitImg = portraitImg;
    }

    public Integer getGender() {
        return gender;
    }

    public void setGender(Integer gender) {
        this.gender = gender;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getMotto() {
        return motto;
    }

    public void setMotto(String motto) {
        this.motto = motto;
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

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getCareer() {
        return career;
    }

    public void setCareer(String career) {
        this.career = career;
    }
}