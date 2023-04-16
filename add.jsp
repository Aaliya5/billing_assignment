<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%
	int itemId = Integer.parseInt(request.getParameter("id"));
	
	Connection conn = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/billing", "root", "");
		
		String sql = "SELECT * FROM shop WHERE id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, itemId);
		ResultSet rs = stmt.executeQuery();
		
		if (rs.next()) {
			HttpSession session = request.getSession();
			Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
			if (cart == null) {
				cart = new HashMap<Integer, Integer>();
				session.setAttribute("cart", cart);
			}
			
			int quantity = 1;
			if (cart.containsKey(itemId)) {
				quantity += cart.get(itemId);
			}
			cart.put(itemId, quantity);
			
		    response.sendRedirect("home.jsp");
		} else {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
		}
		
		rs.close();
		stmt.close();
		conn.close();
	} 
    catch (Exception e) {
		e.printStackTrace();
	}
%>
