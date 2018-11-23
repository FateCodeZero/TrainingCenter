package com.trainingcenter.aop;

import com.trainingcenter.bean.SysLog;
import com.trainingcenter.bean.User;
import com.trainingcenter.service.SysLogService;
import com.trainingcenter.service.UserService;
import com.trainingcenter.utils.LogUtil;
import com.trainingcenter.utils.StringUtil;
import com.trainingcenter.utils.SysResourcesUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.io.Serializable;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/19
 * Time: 15:14
 */
/**
 * 日志切面
 * 使用SpringAOP进行粗略的日志记录
 */
@Order(1)
@Aspect
@Component
public class LoggingAspect implements Serializable{
    @Qualifier("sysLogService")
    @Autowired
    private SysLogService sysLogService;
    @Qualifier("userService")
    @Autowired
    private UserService userService;
    private static ObjectMapper mapper = new ObjectMapper();

    /**
     * 定义切入点表达式
     * execution：执行
     目标方法：修饰符+返回值+包名+接口名+方法名+参数个数和类型
     如：public int com.yangyi.spring.aop.impl.ArithmeticCalculator.add(int, int)
        * com.yangyi.spring.aop.impl.*.*(..)
     第一个*表示任意修饰符合任意返回值，第二个*表示该包的所有类，第三个*表示对所有匹配的方法都起作用,
        两个点表示匹配所有参数
     */

    /**
     *  只拦截 *service.impl 包下的所有方法
     *  不记录日志本身的添加、修改、删除……
     *  不记录用户信息的修改……
     */
    @Pointcut("execution( * com.trainingcenter.service.impl..*(..)) " +
            " && !execution( * com.trainingcenter.service.impl.SysLogServiceImpl.*(..)) " +
            " && !execution( * com.trainingcenter.service.impl.UserServiceImpl.update(..)) " +
            " && !execution( * com.trainingcenter.service.impl.UserInfoServiceImpl.update(..))")
    private static void serviceMethods(){}

//    /**
//     * 前置通知
//     * @param joinpoint：可获取 类、方法、方法参数等信息的对象
//     */
//    @Before("serviceMethods()")
//    public void beforeMethod(JoinPoint joinpoint) {
//        Class<?> clazz = joinpoint.getTarget().getClass();
//        //获取方法名
//        String methodName = joinpoint.getSignature().getName();
//        //获取方法参数列表
//        List<Object> args = Arrays.asList(joinpoint.getArgs());
//
//        //添加日志
//        beforeLogging(clazz,methodName,args);
//    }
//
//    /**
//     * 后置通知：
//     * 		在com.yangyi.spring.aop.ArithmeticCalculator接口的每一个实现类的每一个方法开始执行之后
//     * 			执行一段代码。无论该方法是否出现异常。
//     * 		后置通知无法获方法取返回值，因为不知该方法在执行过程中是否会抛异常
//     * @param joinPoint：可获取 类、方法、方法参数等信息的对象
//     */
//    @After("serviceMethods()")
//    public void afterMethod(JoinPoint joinPoint) {}
//
//    /**
//     * 返回通知：
//     * 		在方法 正常结束 后执行的代码，只有方法正常结束才会执行，有异常不执行
//     * 			返回通知是可以获取到方法的返回值的！
//     * 			result：返回结果
//     * @param joinPoint：可获取 类、方法、方法参数等信息的对象
//     * @param result：方法返回结果
//     */
//    @AfterReturning(value="serviceMethods()", returning="result"	)
//    public void afterReturning(JoinPoint joinPoint, Object result) {
//
//        String methodName = joinPoint.getSignature().getName();
//
//        System.out.println("The method [ " + methodName + " ] ends { " + result + " }");
//    }
//
//    /**
//     * 异常通知：
//     * 在目标方法出现异常时会执行的代码。
//     * 		可以访问到异常对象，且可以指定在出现特定异常时再执行通知代码。
//     * @param joinPoint：执行方法的所有内容
//     * @param ex：抛出的异常
//     */
//    @AfterThrowing(value="serviceMethods()", throwing="ex"	)
//    public void afterThrowing(JoinPoint joinPoint, Exception ex) {
//
//        String methodName = joinPoint.getSignature().getName();
//
//        System.out.println("The method [ " + methodName + " ]  occurs exception " + ex );
//    }

    /**
     * 环绕通知
     * @param pjd
     * @return
     */
    @Around(value="serviceMethods()")
    public Object aroundMethod(ProceedingJoinPoint pjd) throws Throwable {
        Class<?> clazz = pjd.getTarget().getClass(); //目标对象
        String methodName = pjd.getSignature().getName(); //方法名
        Object[] args = pjd.getArgs(); //方法参数
        String argsJsonStr = null;  //方法参数的json字符串
        Object result;  //方法返回结果

        try {
            argsJsonStr = mapper.writeValueAsString(args);
        } catch (IOException e) {
            LogUtil.error(this,"【Jackson】数据转换","对象转为转为Json字符串时失败",e);
            e.printStackTrace();
        }

        //执行目标方法
        //前置通知
        LogUtil.debug(clazz,"方法执行之前","【"+clazz+"类的【"+methodName+"】方法【即将执行】，方法参数为：\n【"+argsJsonStr+"】");

        //数据库只记录添加、修改、删除的信息
        if (methodName.equals("register") || methodName.equals("add") || methodName.equals("update") || methodName.equals("delete")){
            beforeLogging(clazz,methodName,Arrays.asList(args));
        }

        //执行目标方法
        result = pjd.proceed();     //异常直接上抛，使用统一从异常处理器处理

        //返回通知
        LogUtil.debug(clazz,"方法执行结果","获取【"+clazz+"类的【"+methodName+"】方法的【执行结果】，返回结果为：\n【"+mapper.writeValueAsString(result)+"】");

        //后置通知
        LogUtil.debug(clazz,"方法执行结束","【"+clazz+"类的【"+methodName+"】方法【执行结束】");

        return result;
    }

    /**
     * 操作类型为 添加 的日志记录
     * @param methodName：方法名
     * @param args：方法参数
     * @param clazz：方法所属的类
     */
    private void beforeLogging(Class<?> clazz,String methodName,List<Object> args){
        String currentUsername = SysResourcesUtils.getCurrentUsername(); //当前登录人账号
        StringBuffer title;   //日志标题
        StringBuffer content; //日志类容
        SysLog sysLog = new SysLog();  //日志对象
        User currentUser;  //当前登录对象

        if (StringUtil.isNotEmpty(currentUsername)){
            currentUser = userService.getUserByUsername(currentUsername); //当前登录对象

            //避免空指针异常
            if (currentUser != null){
                sysLog.setId(UUID.randomUUID().toString());
                sysLog.setOpUserId(currentUser.getId());
                sysLog.setOpTime(new Date());
            }

            if (methodName.equals("add")){
                sysLog.setOpType("添加");
                title = new StringBuffer("数据添加");
                content = new StringBuffer("用户：【");
                content.append(currentUsername);
                content.append("】正在添加数据，数据信息为：\n");
                try {
                    content.append(mapper.writeValueAsString(args));
                } catch (IOException e) {
                    LogUtil.error(this,"【Jackson】数据转换","对象转为json字符串时失败",e);
                    e.printStackTrace();
                }

                sysLog.setOpContent(content.toString());
                //文件日志记录
                LogUtil.info(clazz,title.toString(),content.toString());
                //数据库日志记录
                if (currentUser != null){   //数据库日志的操作人不能为空
                    sysLogService.add(sysLog);
                }
            }

            if (methodName.equals("update")){
                sysLog.setOpType("更新");
                title = new StringBuffer("数据更新");
                content = new StringBuffer("用户：【");
                content.append(currentUsername);
                content.append("】正在更新数据，数据信息为：\n");
                try {
                    content.append(mapper.writeValueAsString(args));
                } catch (IOException e) {
                    LogUtil.error(this,"【Jackson】数据转换","对象转为json字符串时失败",e);
                    e.printStackTrace();
                }

                sysLog.setOpContent(content.toString());
                //文件日志记录
                LogUtil.info(clazz,title.toString(),content.toString());
                //数据库日志记录
                if (currentUser != null){   //数据库日志的操作人不能为空
                    sysLogService.add(sysLog);
                }
            }

            if (methodName.equals("delete")){
                sysLog.setOpType("删除");
                title = new StringBuffer("数据删除");
                content = new StringBuffer("用户：【");
                content.append(currentUsername);
                content.append("】正在删除数据，删除对象ID为：\n");
                try {
                    content.append(mapper.writeValueAsString(args));
                } catch (IOException e) {
                    LogUtil.error(this,"【Jackson】数据转换","对象转为json字符串时失败",e);
                    e.printStackTrace();
                }

                sysLog.setOpContent(content.toString());
                //文件日志记录
                LogUtil.info(clazz,title.toString(),content.toString());
                //数据库日志记录
                if (currentUser != null){   //数据库日志的操作人不能为空
                    sysLogService.add(sysLog);
                }
            }
        }
    }
}