package com.trainingcenter.utils;

import org.codehaus.jackson.map.ObjectMapper;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/19
 * Time: 20:19
 */

/**
 * 使用单列模式获取 JackSon 的 ObjectMapper 对象
 */
public class JackSonUtils {
    private JackSonUtils(){
    }

    /**
     * Initialization on Demand Holder. 这种方法使用内部类来做到延迟加载对象，
     * 在初始化这个内部类的时候，JLS(Java Language Sepcification)会保证这个类的线程安全。
     * 这种写法最大的美在于，完全使用了Java虚拟机的机制进行同步保证，没有一个同步的关键字。
     */
    private static class ObjectMapperHolder{
        public final static ObjectMapper instance = new ObjectMapper();
    }

    public static ObjectMapper getObjectMapper(){
        return ObjectMapperHolder.instance;
    }
} 