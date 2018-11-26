package com.trainingcenter.bean;

import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Delete;
import com.trainingcenter.controller.validation.TC_Find;
import com.trainingcenter.controller.validation.TC_Update;
import org.hibernate.validator.constraints.Range;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/18
 * Time: 4:52
 */
public class Resource extends BaseEntity implements Serializable {
    /**
     * 主键ID，对应数据库（id）字段
     */
    @NotBlank(message = "id不能为空",groups = {TC_Update.class,TC_Delete.class,TC_Find.class})
    private String id;

    /**
     * 资源名称，对应数据库（name）字段
     */
    @NotBlank(message = "资源名称不能为空",groups = {TC_Add.class, TC_Update.class})
    private String name;

    /**
     * 资源对应URL，对应数据库（url）字段
     */
    @NotBlank(message = "资源对应的URL不能为空",groups = {TC_Add.class, TC_Update.class})
    private String url;

    /**
     * 资源使用状态，对应数据库（state）字段
     * （1：已启用，0：已禁用，-1：已删除）
     */
    @NotNull(message = "使用状态不能为空",groups = {TC_Add.class, TC_Update.class})
    @Range(min = -1,max = 1,message = "用户使用状态范围只能在-1~1",groups = {TC_Update.class})
    private Integer state;

    /**
     * 资源描述，对应数据库（describe）字段
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

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }
}