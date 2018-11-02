package com.trainingcenter.bean;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 17:01
 *
 * 用户类型，对应数据库（tab_user_type）表
 */
public class UserType extends BaseEntity implements Serializable{

    /**
     * id，对应数据库（id）字段
     */
    @NotBlank(message = "用户类型id不能为空")
    private String id;

    /**
     * 用户类型名称，对应数据库（name）字段
     */
    @NotBlank(message = "用户类型名称不能为空")
    private String name;

    /**
     * 用户类型描述，对应数据库（describe）字段
     */
    private String describe;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    @Override
    public String toString() {
        return "UserType{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", describe='" + describe + '\'' +
                ", remarks='" + remarks + '\'' +
                ", createUserId='" + createUserId + '\'' +
                ", createDate=" + createDate +
                ", updateUserId='" + updateUserId + '\'' +
                ", updateDate=" + updateDate +
                '}';
    }
}
