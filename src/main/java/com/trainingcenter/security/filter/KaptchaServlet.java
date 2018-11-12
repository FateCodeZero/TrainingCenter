package com.trainingcenter.security.filter;

import com.google.code.kaptcha.Producer;
import com.google.code.kaptcha.util.Config;
import sun.misc.BASE64Encoder;

import javax.imageio.ImageIO;
import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Enumeration;
import java.util.Properties;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/12
 * Time: 2:41
 */

/**
 * 重新谷歌验证码生成器，为了实现 Ajax 异步刷新验证码
 * 暂时未成功
 */
public class KaptchaServlet extends HttpServlet implements Servlet {
    private Properties props = new Properties();
    private Producer kaptchaProducer = null;
    private String sessionKeyValue = null;
    private String sessionKeyDateValue = null;

    public KaptchaServlet() {
    }

    public void init(ServletConfig conf) throws ServletException {
        super.init(conf);
        ImageIO.setUseCache(false);
        Enumeration initParams = conf.getInitParameterNames();

        while (initParams.hasMoreElements()) {
            String key = (String) initParams.nextElement();
            String value = conf.getInitParameter(key);
            this.props.put(key, value);
        }

        Config config = new Config(this.props);
        this.kaptchaProducer = config.getProducerImpl();
        this.sessionKeyValue = config.getSessionKey();
        this.sessionKeyDateValue = config.getSessionDate();
    }

    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setDateHeader("Expires", 0L);
        resp.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
        resp.addHeader("Cache-Control", "post-check=0, pre-check=0");
        resp.setHeader("Pragma", "no-cache");
        resp.setContentType("image/jpeg");
        resp.setCharacterEncoding("UTF-8");
        String capText = this.kaptchaProducer.createText();
        req.getSession().setAttribute(this.sessionKeyValue, capText);
        req.getSession().setAttribute(this.sessionKeyDateValue, new Date());
        BufferedImage bi = this.kaptchaProducer.createImage(capText);

        ByteArrayOutputStream baos = new ByteArrayOutputStream();//io流
        ImageIO.write(bi, "jpg", baos);//写入流中
        byte[] bytes = baos.toByteArray();//转换成字节
        BASE64Encoder encoder = new BASE64Encoder();
        String png_base64 =  encoder.encodeBuffer(bytes);//转换成base64串
        png_base64 = png_base64.replaceAll("\n", "").replaceAll("\r", "");//删除 \r\n

        PrintWriter out = resp.getWriter();
        out.write(png_base64);
        out.flush();    //保证传输完全
        out.close();
    }
}