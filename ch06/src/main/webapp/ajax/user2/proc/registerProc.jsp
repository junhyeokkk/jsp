<%@page import="sub1.User2VO"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	//JSON 문자열 스트림 처리
	BufferedReader reader = request.getReader();
	StringBuilder requestBody = new StringBuilder();
	
	String line;
	while((line = reader.readLine()) != null){
		requestBody.append(line);
	}
	reader.close();
	
	//JSON 파싱
	Gson gson = new Gson();
	User2VO user2 = gson.fromJson(requestBody.toString(), User2VO.class);
	
	
	System.out.println(user2);
	
	int rowCount = 0;
	
	try{
		//1단계 - JNDI 서비스 객체 생성
		Context ctx = (Context) new InitialContext().lookup("java:comp/env");
				
		//2단계 - 커넥션 가져오기
		DataSource ds = (DataSource)ctx.lookup("jdbc/studydb");
		Connection conn = ds.getConnection();
		
		//2단계 - SQL실행 객체 생성
		String sql = "insert into user2 values (?,?,?,?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, user2.getUid());
		pstmt.setString(2, user2.getName());
		pstmt.setString(3, user2.getBirth());
		pstmt.setString(4, user2.getAddr());
		
		
		//3단계 - SQL 실행
		rowCount = pstmt.executeUpdate();
		
		//4단계 - 결과 처리(SELECT)

		//5단계 - 데이터베이스 종료
		pstmt.close();
		conn.close();
		
	} catch(Exception e){
		e.printStackTrace();
		System.out.println("오류");
		
	}
	
	//목록이동
	//response.sendRedirect("/ch06/user1/list.jsp");
	//String jsonData = "{\"result\":"+result+"}";
	
	//JSON 출력
	JsonObject json = new JsonObject();
	json.addProperty("result",rowCount);
	
	out.print(json.toString());

%>