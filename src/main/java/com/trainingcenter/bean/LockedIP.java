package com.trainingcenter.bean;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/12/3
 * Time: 19:28
 */

import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Delete;
import com.trainingcenter.controller.validation.TC_Find;
import com.trainingcenter.controller.validation.TC_Update;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * IP锁定类，对应数据库（tab_lock_ip）表，
 * 只要出现在该表内的IP都会被锁住
 */
public class LockedIP extends BaseEntity implements Serializable{
    /**
     * 主键id，对应数据库（id）字段
     */
    private String id;

    /**
     * 被锁定IP地址，对应数据库（IP）
     */
    @NotBlank(message = "iP不能为空",groups = {TC_Add.class,TC_Update.class})
    private String IP;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIP() {
        return IP;
    }

    public void setIP(String IP) {
        this.IP = IP;
    }
}