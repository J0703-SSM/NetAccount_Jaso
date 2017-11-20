package com.lanou.user.Interceptor;

import com.lanou.user.domain.Admin;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * Created by dllo on 17/11/17.
 */
public class PrivilegeInterceptor implements HandlerInterceptor {
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {

        String uri = request.getRequestURI();

        Map<String,String> loginPrivi = (Map<String, String>) request.getServletContext().getAttribute("loginPrivi");

        //角色
        if (uri.indexOf("role_") != -1 &&  loginPrivi.get("1") == null){
            request.getRequestDispatcher("/WEB-INF/nopower.jsp").forward(request,response);
        }
        //管理员
        if (uri.indexOf("admin_") != -1 &&  loginPrivi.get("2") == null){
            request.getRequestDispatcher("/WEB-INF/nopower.jsp").forward(request,response);
        }
        //资费
        if (uri.indexOf("fee_") != -1 &&  loginPrivi.get("3") == null){
            request.getRequestDispatcher("/WEB-INF/nopower.jsp").forward(request,response);
        }
//未开放
        if (uri.indexOf("account") != -1 ){
            request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request,response);
        }
        if (uri.indexOf("bill") != -1 ){
            request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request,response);
        }
        if (uri.indexOf("report") != -1 ){
            request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request,response);
        }
        if (uri.indexOf("service") != -1 ){
            request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request,response);
        }



        return true;
    }

    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
