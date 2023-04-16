<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<html>
<head>
	<title>cart</title>
</head>
<body>
	<h1>cart</h1>
	
	<%
		HttpSession session = request.getSession();
		Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
		
		if (cart == null || cart.isEmpty()) {
			out.println("<p>Cart is empty.</p>");
		} else {
			out.println("<table>");
			out.println("<tr><th>Item</th><th>Quantity</th><th>Price</th></tr>");
			Connection conn = null;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/billing", "root", "");
				
				String sql = "SELECT * FROM shop WHERE id=?";
				PreparedStatement stmt = conn.prepareStatement(sql);
				
				double total = 0.0;
				for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
					int itemId = entry.getKey();
					int quantity = entry.getValue();
					
					stmt.setInt(1, itemId);
					ResultSet rs = stmt.executeQuery();
					
					if (rs.next()) {
						String name = rs.getString("item");
						double price = rs.getDouble("price");
						
						out.println("<tr><td>" + name + "</td><td>" + quantity + "</td><td>" + price + "</td></tr>");
						total += price * quantity;
					}
					
					rs.close();
				}
				
				stmt.close();
				conn.close();
				
				out.println("<tr><td colspan='2'><b>Total:</b></td><td><b>Rs." + total + "</b></td></tr>");
			} catch (Exception e) {
				e.printStackTrace();
			}
			
            out.println("<h1>Payment:</h1>")
			out.println("</table>");
			out.println("<form action='final.jsp' method='post' align='center'>");
			out.println("<input type='submit' value='Pay'>");
			out.println("</form>");
		}
	%>
	
</body>
</html>
