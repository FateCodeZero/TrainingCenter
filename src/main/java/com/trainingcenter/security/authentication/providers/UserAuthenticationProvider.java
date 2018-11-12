package com.trainingcenter.security.authentication.providers;

import com.trainingcenter.utils.MD5Util;
import com.trainingcenter.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/3
 * Time: 13:43
 */

/**
 * 用户登录权限验证类
 */
public class UserAuthenticationProvider implements AuthenticationProvider {
    @Qualifier("loginInfoService")
    @Autowired
    private UserDetailsService userService;

    /**
     * 权限认证
     * @param authentication：
     *     Authentication是一个接口，用来表示用户认证信息的，
     *     在用户登录认证之前相关信息会封装为一个Authentication具体实现类的对象，
     *     在登录认证成功之后又会生成一个信息更全面，包含用户权限等信息的Authentication对象，
     *     然后把它保存在SecurityContextHolder所持有的SecurityContext中，供后续的程序进行调用，
     *      如访问权限的鉴定等。
     * @return
     * @throws AuthenticationException
     */
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        UsernamePasswordAuthenticationToken token = (UsernamePasswordAuthenticationToken) authentication;
        String username = token.getName();

        UserDetails userDetails;
        if (StringUtil.isNotEmpty(username)){
            userDetails = userService.loadUserByUsername(username);
        }else {
            throw new UsernameNotFoundException("用户名不存在");
        }
        if (userDetails == null){
            throw new UsernameNotFoundException("用户名或密码错误");
        }else if (!userDetails.isEnabled()){
            throw new DisabledException("该用户已被禁用");
        }else if (!userDetails.isAccountNonExpired()) {
            throw new AccountExpiredException("账号已过期");
        }else if (!userDetails.isAccountNonLocked()) {
            throw new LockedException("账号已被锁定");
        }else if (!userDetails.isCredentialsNonExpired()) {
            throw new CredentialsExpiredException("凭证已过期");
        }

        //数据库的密码
        String password = userDetails.getPassword();

        //获取authentication中储存的用户输入的密码，并使用相同的算法进行加密
        String credentials = (String) token.getCredentials();

        //BCrypt算法加密
//        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder(16);
//        String encode = passwordEncoder.encode(credentials);
        //两个密码进行匹配
//        if (!passwordEncoder.matches(encode,password)){
//            throw new BadCredentialsException("用户名或密码错误");
//        }

        //md5加密
        if (!password.equals(MD5Util.md5Encrypt(credentials))){
            throw new BadCredentialsException("用户名或密码错误");
        }

        //授权
        return new UsernamePasswordAuthenticationToken(userDetails,password,userDetails.getAuthorities());
    }

    public boolean supports(Class<?> authentication) {
        //返回true后才会执行上面的authenticate方法,这步能确保authentication能正确转换类型
        return UsernamePasswordAuthenticationToken.class.equals(authentication);
    }
}