<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<h2><center> <br>Available Items</h2></center></br>
<%@ page language="java" %>
<%@ page import ="java.sql.*" %>
<%
String uname=request.getParameter("uname");
String password=request.getParameter("password");

Class.forName("com.mysql.jdbc.Driver");

Connection cn= DriverManager.getConnection("jdbc:mysql://localhost:3306/billing","root","");
String sql = "Select * from shop";
        PreparedStatement pstmt = cn.prepareStatement(sql);
        ResultSet rs1 = pstmt.executeQuery();
        out.println("<table border=1 align='center'>");
            out.println("<tr>");
            out.println("<th>ID</th>");
            out.println("<th>Name</th>");
            out.println("<th>Price</th>");
            out.println("</tr>");
        while (rs1.next()) {
            String id = rs1.getString("id");
            String item = rs1.getString("item");
            String price = rs1.getString("price");
            out.println("<tr>");
            out.println("<td>");
            out.println(id);
            out.println("</td>");
            out.println("<td>");
            out.println( item );
            out.println("</td>");
            out.println("<td>");
            out.println(price);
            out.println("</td>");
            out.println("</tr>");
            
        }
        out.println("</table>");
        out.println("<br>");


PreparedStatement   st5 = cn.prepareStatement("Select uname,pass from login where uname=? and pass=?");

st5.setString(1,uname);

st5.setString(2, password);

ResultSet rs=st5.executeQuery();

if(rs.next())
{
out.println("<h1><center>Enter the item id to add to cart:</center></h1>");
out.println("<form name='crd' action='add.jsp' method='post'>");
out.println("<table frame='box' align='center'><tr><td>Item Id:</td><td><input type='text' name='id'/></td></tr><tr><td><input type='submit' value='add'/></tr></td></table>");
out.println("</form>");
out.println("</br>");
out.println("<form action = 'cart.jsp' align='center'>");
out.println(" <input type = 'submit' value='view cart'>");
out.println("</form> ");
}
else
{
    out.println("invalin login");
}
   


rs.close();
st5.close();
cn.close();
%>
</body>
</html>


