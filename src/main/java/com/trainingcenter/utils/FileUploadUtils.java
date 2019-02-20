package com.trainingcenter.utils;

import com.trainingcenter.exception.UploadException;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/12/11
 * Time: 21:02
 */
public class FileUploadUtils {

    /**
     * 上传 request 解析，获取文件上传表单项与普通表单项的集合
     * @param request：HttpServletRequest
     * @param maxSize : 限制总上传文件的大小，单位MB
     * @return Map<String,Object> map :
     *      key：fileItems，文件表单项
     *      key：ordinaryItems：普通表单项
     */
    public static Map<String,Object> uploadRequestAnalysis(HttpServletRequest request, long maxSize){
        /**
         * 执行上传操作
         * 1、判断表单是否支持上传，即判断表单的提交类型是否为enctype=multipart/form-data
         * 2、创建文件上传工厂对象：DiskFileItemFactory
         * 3、创建表单解析器对象：ServletFileUpload（核心对象）
         * 4、解析request对象，并得到一个表单项的List集合
         * 5、迭代（遍历）表单项List集合，获取到上传的数据
         */
        // 1、判断表单是否支持上传，表单不支持上传则抛异常
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        if (!isMultipart) {
            throw new UploadException("Form 表单不是 multipart/form-data 类型，不支持上传操作！");
        }

        // 2、创建文件上传工厂对象
        DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
        String webUploadPath = SysResourcesUtils.getWebUploadPath();
        diskFileItemFactory.setRepository(new File(webUploadPath + File.separator +"temp")); // 指定临时文件的存储路径

        // 3、创建表单解析器对象
        ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);

        servletFileUpload.setSizeMax(maxSize * 1024 * 1024); // 限制总上传文件的大小不能超过 maxSize bit

        //存放普通表单项
        List<FileItem> ordinaryItems = Collections.synchronizedList(new ArrayList<>());
        //存放文件表单项
        List<FileItem> fileItems = Collections.synchronizedList(new ArrayList<>());

        // 4、解析request对象，并得到一个表单项的List集合
        List<FileItem> fileItemList = null;
        try {
            fileItemList = servletFileUpload.parseRequest(request);
        } catch (FileUploadException e) {
            e.printStackTrace();
            throw new UploadException("上传失败，request 无法解析");
        }

        // 5、迭代（遍历）表单项List集合，获取到上传的数据
        for (FileItem item : fileItemList) {
            if (item.isFormField()) {
                //提取普通表单项
                ordinaryItems.add(item);
            }else {
                fileItems.add(item);
            }
        }
        Map<String,Object> map = new ConcurrentHashMap<>();
        map.put("ordinaryItems",ordinaryItems);
        map.put("fileItems",fileItems);

        return map;
    }

    /**
     * 通过 Spring的 multipartRequest 进行上传操作
     * @param request HttpServletRequest
     * @return 全部保存成功返回每个文件保存成功后在系统中的路径，否则返回null
     */
    public static List<String> upload(HttpServletRequest request){
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        List<MultipartFile> files = multipartRequest.getFiles("files");
        files = new ArrayList<>(files);     //将Arrays.asList()转为ArrayList
        MultipartFile file = multipartRequest.getFile("file");  //处理layui文件上传
        if (file != null) {
            files.add(file);
        }
        return save(files);
    }

    /**
     * 保存一堆文件
     * @param files：一堆文件
     * @return 全部保存成功返回每个文件保存成功后在系统中的路径，否则返回null
     */
    private static List<String> save(List<MultipartFile> files){
        String nowDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        String ctxPath = SysResourcesUtils.getWebUploadPath();
        File file = new File(ctxPath + File.separator + nowDate);
        if (!file.exists()) {
            file.mkdirs();// 创建文件根目录
        }
        List<String> filePaths = new CopyOnWriteArrayList<>();
        for (MultipartFile f : files) {
            String path = save(f, file);
            if (StringUtil.isEmpty(path)){
                return null;
            }else {
                filePaths.add(path);
            }
        }
        return filePaths;
    }

    /**
     * 保存一个文件
     * @param mf：MultipartFile
     * @param file_path：保存文件的路径
     * @return 返回保存成功后的文件路径
     */
    private static String save(MultipartFile mf, File file_path){
        String orgName = mf.getOriginalFilename();// 获取文件名
        String fileName = orgName.substring(0, orgName.lastIndexOf(".")) + "_" + System.currentTimeMillis() + orgName.substring(orgName.indexOf("."));
        String savePath = file_path.getPath() + File.separator + fileName;
        File savefile = new File(savePath);
        //保存文件
        String filePath = null;
        try {
            mf.transferTo(savefile);
            filePath = savePath;
        } catch (IOException e) {
            e.printStackTrace();
            LogUtil.warn(null,"文件保存","保存文件【"+orgName+"】失败");
            filePath = null;
        }
        return filePath;
    }
} 