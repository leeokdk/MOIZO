package com.moim.common;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

public class CookieUtil { // 54일차(6일차)
	// cookie 생성과 조회를 좀 더 간단하게 하는 클래스
	private Map<String, Cookie> cookieMap = new HashMap<String, Cookie>();
	
	public CookieUtil(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				cookieMap.put(cookie.getName(), cookie);
			}
		}
	}
	// 쿠키 객체 생성함과 동시에
	// 멤버 변수 cookieMap에 request 가 갖고 있는 cookie를 저장함.
	
	public Cookie getSomeCookie(String name) {
		return cookieMap.get(name);
	}		// 쿠키 이름으로 조회를 하면 cookie 객체를 리턴해줌. 없으면 null 리턴
	
	public String getValue(String name) throws IOException{
		Cookie cookie = getSomeCookie(name);		// 위의 메서드로 쿠키가 있는지 확인하고
		if(cookie == null) {		// 만약  null 이라면 그대로 null 리턴하고
			return null;
		}else {		// null 이 아닌 값이 있다고 하면
			return URLDecoder.decode(cookie.getValue(), "utf-8");	
		}	// 인코딩 되어서 저장되어있는 쿠키라면 decode를 하여 캐릭터셋은 utf-8로 하고 한글로 인식 할 수 있게함.
	}
	
	public boolean exists(String name) {
		return  cookieMap.get(name) != null;	// 해당의 이름이 있는지 없는지 확인하고 false or true 리턴
	}
	// 여기까지는 CookieUtil 객체를 생성해야 사용이 가능한 메서드.
	
	
	
	
	// 여기부터는 CookieUtil 객체를 생성하지 않아도 되는 메서드.
	
	public static Cookie createCookie(String name, String value) throws IOException{
		return createCookie(name, value, "", -1);		// maxAge = -1 뜻은 브라우저를 끄는순간 -1이 되고 켜있는동안에는 1이 되어있는 상태로 적용하는 것
	}
	
	public static Cookie createCookie(String name, String value, String path) throws IOException{
		return createCookie(name, value, path, -1);		// maxAge = 일주일이 default
	}
	
	public static Cookie createCookie(String name, String value, int maxAge) throws IOException{
		return createCookie(name, value, "", maxAge);		// maxAge = 일주일이 default
	}
	
	public static Cookie createCookie(String name, String value, String path, int maxAge) throws IOException{
		Cookie cookie = new Cookie(name, value);
		cookie.setPath(path);
		cookie.setMaxAge(maxAge);
		return cookie;
	}
	
	
}
