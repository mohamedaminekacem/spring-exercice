package com.example.interceptors;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.LocalTime;

public class LunchHoursInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
        LocalTime currentTime = LocalTime.now();
        LocalTime closingTime = LocalTime.of(13, 0);
        LocalTime openingTime = LocalTime.of(13, 1);

        if (currentTime.isAfter(closingTime) && currentTime.isBefore(openingTime)){
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access is denied at lunchTime");
            return false;
        }
        return true;
    }
}
