package com.trainingcenter.bean;

import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Delete;
import com.trainingcenter.controller.validation.TC_Find;
import com.trainingcenter.controller.validation.TC_Update;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.util.Arrays;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/29
 * Time: 17:08
 */

/**
 * 权限表，对应数据库（tab_permission）
 */
public class Permission extends BaseEntity implements Serializable {
    /**
     * id,对应数据库（id）字段
     */
    @NotBlank(message = "id不能为空",groups = {TC_Delete.class,TC_Find.class})
    private String id;

    /**
     * 权限名称,对应数据库（name）字段
     */
    @NotBlank(message = "权限名称不能为空",groups = {TC_Add.class, TC_Update.class})
    private String name;

    /**
     * 权限描述,对应数据库（describe）字段
     */
    private String describe;

    /**
     * 权限对应资源url,对应数据库（url）字段
     */
    private String url;

    /**
     * 对某资源含有的操作权限（CREATE、READ、UPDATE、DELETE），各个操作间用英文逗号分分隔
     * 对应数据库字段（permission）
     */
    private String operation;

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

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getOperation() {
        return operation;
    }

    public void setOperation(String operation) {
        this.operation = operation;
    }

    /**
     * 获取权限操作的 list 形式
     * @return
     */
    public List<String> getOperations() {
        return Arrays.asList(this.operation.trim().split(","));
    }

    @Override
    public String toString() {
        return "Permission{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", describe='" + describe + '\'' +
                ", url='" + url + '\'' +
                ", operation='" + operation + '\'' +
                ", remarks='" + remarks + '\'' +
                ", createUserId='" + createUserId + '\'' +
                ", createDate=" + createDate +
                ", updateUserId='" + updateUserId + '\'' +
                ", updateDate=" + updateDate +
                '}';
    }
}