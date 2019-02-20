package com.trainingcenter.utils;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/30
 * Time: 1:57
 */

import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.Map;

/**
 * 树节点工具类
 */
public class TreeNode implements Comparable<TreeNode> {
    private String id;//本节点id
    private String name;//本节点名称
    private String parentId;//本节点的父节点
    private Integer order;//本节点排序，可忽略
    private Integer level;//本节点层级
    private Map<String, Object> data;//本节点的其他数据

    private List<TreeNode> children; //子节点

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

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public List<TreeNode> getChildren() {
        return children;
    }

    public void setChildren(List<TreeNode> children) {
        this.children = children;
    }

    public Integer getOrder() {
        return order;
    }

    public void setOrder(Integer order) {
        this.order = order;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public Map<String, Object> getData() {
        return data;
    }

    public void setData(Map<String, Object> data) {
        this.data = data;
    }

    /**
     * 基于 order 属性排序
     *
     * @param node :节点排序
     * @return
     */
    @Override
    public int compareTo(TreeNode node) {
        return this.order - node.order;
    }
}