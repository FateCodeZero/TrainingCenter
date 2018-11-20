package com.trainingcenter.bean;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/29
 * Time: 16:57
 */

import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Delete;
import com.trainingcenter.controller.validation.TC_Find;
import com.trainingcenter.controller.validation.TC_Update;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.util.Date;

/**
 * 系统日志，对应数据库（tab_sys_log）
 */
public class SysLog implements Serializable {
    /**
     * id，对应数据库（id）字段
     */
    @NotBlank(message = "id不能为空",groups = {TC_Delete.class,TC_Find.class})
    private String id;

    /**
     * 操作人id，对应数据库（op_user_id）字段
     */
    @NotBlank(message = "操作人id不能为空",groups = {TC_Add.class, TC_Update.class})
    private String opUserId;

    /**
     * 操作内容，对应数据库（op_content）字段
     */
    private String opContent;

    /**
     * 操作类型（添加、修改、删除），对应数据库（op_type）字段
     */
    @NotBlank(message = "操作类型不能为空",groups = {TC_Add.class, TC_Update.class})
    private String opType;

    /**
     * 操作时间，对应数据库（op_date）字段
     */
    private Date opTime;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOpUserId() {
        return opUserId;
    }

    public void setOpUserId(String opUserId) {
        this.opUserId = opUserId;
    }

    public String getOpContent() {
        return opContent;
    }

    public void setOpContent(String opContent) {
        this.opContent = opContent;
    }

    public String getOpType() {
        return opType;
    }

    public void setOpType(String opType) {
        this.opType = opType;
    }

    public Date getOpTime() {
        return opTime;
    }

    public void setOpTime(Date opTime) {
        this.opTime = opTime;
    }
}