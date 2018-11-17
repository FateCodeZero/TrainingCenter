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
     * 操作常量
     */
    public static final String CREATE = "CREATE";
    public static final String READ = "READ";
    public static final String UPDATE = "UPDATE";
    public static final String DELETE = "DELETE";

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
     * 权限对应资源ID，对应数据库（resource_id）字段
     */
    @NotBlank(message = "权限对应资源不能为空",groups = {TC_Add.class, TC_Update.class})
    private String resourceId;

    /**
     * 对某资源含有的操作权限（CREATE、READ、UPDATE、DELETE），各个操作间用英文逗号分分隔
     * 对应数据库字段（permission）
     */
    private String operations;

    /**
     * 权限描述,对应数据库（describe）字段
     */
    private String describe;

    /**
     * 对某资源含有的操作权限集合
     */
    private List<String> operationList;

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

    public String getResourceId() {
        return resourceId;
    }

    public void setResourceId(String resourceId) {
        this.resourceId = resourceId;
    }

    public String getOperations() {
        return operations;
    }

    public void setOperations(String operations) {
        this.operations = operations;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public List<String> getOperationList() {
        return Arrays.asList(this.operations.trim().split(","));
    }

    public void setOperationList(List<String> operationList) {
        this.operationList = operationList;
    }
}