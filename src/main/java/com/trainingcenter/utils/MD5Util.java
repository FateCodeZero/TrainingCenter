package com.trainingcenter.utils;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/21
 * Time: 20:08
 * <p>
 * 1.MD5加密字符串（32位大写）
 * 2.MD5加密字符串（32位小写）
 * <p>
 */

public class MD5Util {
    /**
     * MD5加密字符串（32位大写）
     *
     * @param string 需要进行MD5加密的字符串
     * @return 加密后的字符串（小写）
     */
    public static String md5Encrypt(String string) {
        byte[] hash;
        try {
            hash = MessageDigest.getInstance("MD5").digest(string.getBytes("UTF-8"));
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("MD5加密失败！", e);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("UTF-8编码转换失败！", e);
        }
        StringBuilder hex = new StringBuilder(hash.length * 2);
        for (byte b : hash) {
            if ((b & 0xFF) < 0x10) hex.append("0");     //不足32位的前导加0
            hex.append(Integer.toHexString(b & 0xFF));
        }
        return hex.toString().toLowerCase();
    }
}