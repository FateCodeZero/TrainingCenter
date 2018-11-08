package com.trainingcenter.bean;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/29
 * Time: 17:03
 */

import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Delete;
import com.trainingcenter.controller.validation.TC_Find;
import com.trainingcenter.controller.validation.TC_Update;
import org.springframework.security.core.GrantedAuthority;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * 角色表，对应数据库（tab_role）
 */
public class Role extends BaseEntity implements Serializable,GrantedAuthority {
    /**
     * id，对应数据库（id）字段
     */
    @NotBlank(message = "id不能为空",groups = {TC_Delete.class,TC_Find.class})
    private String id;

    /**
     * 角色名称，对应数据库（name）字段
     */
    @NotBlank(message = "角色名称不能为空",groups = {TC_Add.class, TC_Update.class})
    private String name;

    /**
     * 角色描述，对应数据库（describe）字段
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
        return "Role{" +
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

    /**
     * 获取角色名称，security用
     *  按 security 的需求，所有角色必须有 ROLE_ 前缀
     * @return 返回角色名称
     */
    public String getAuthority() {
        return "ROLE_" + this.name;
    }
}