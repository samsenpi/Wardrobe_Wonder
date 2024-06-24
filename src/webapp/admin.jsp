
<%@ page language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.*" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WardrobeWonders</title>
    <link rel="stylesheet" href="./whome.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
   
               
         
    <main id="admin">


 		<%
            // Retrieving session attribute
            HttpSession s = request.getSession(false); // Don't create new session if it doesn't exist
            if (s != null) {
                String type = (String) session.getAttribute("type1");
                String name = (String) session.getAttribute("username");
               
                if(type != null && "admin".equals(type)){
                
        %>
                    <p>Welcome <%= name %>!</p>
        <%
                }else if (type != null && "user".equals(type)) {
                	
                	response.sendRedirect("./whome.jsp") ;
                	
                	
                }else {
        %>
                    <p>No user logged in.</p>
                    
        <%
        			response.sendRedirect("./wlogin.html") ;
                }
            } else {
        %>	
                <p>No session found.</p>
        <%
            }
        %>

		<!-- 
				form
		 -->
   <h1>Admin Panel</h1>
    <form class="container"  onsubmit="return validate()">
       
       
        <div id="productIdField" style="display: none;">
            <label for="productId">Product ID:</label>
            <input type="text" name="productId" id="productId">
            <span id="productId_err" class="err"></span>
        </div>

        <label for="productName">Product Name:</label>
        <input type="text" name="productName" id="productName">
        <span id="productName_err" class="err"></span>

        <label for="productDescription">Product Description:</label>
        <input type="text" name="productDescription" id="productDescription">
        <span id="productDescription_err" class="err"></span>

        <label for="productPrice">Product Price:</label>
        <input type="number" name="productPrice" id="productPrice" step="0.01">
        <span id="productPrice_err" class="err"></span>

        <label for="productPhoto">Product Photo:</label>
        <input type="text" name="productPhoto" id="productPhoto">
        <span id="productPhoto_err" class="err"></span>

		 <label for="category">Select Category:</label>
       
        <select name="category" id="category">
            <option value="">Select a category</option>
            <option value="women_shirt">Women Shirt</option>
            <option value="women_jacket">Women Jacket</option>
            <option value="women_frock">Women Frock</option>
            <option value="men_shirt">Men Shirt</option>
            <option value="men_jacket">Men Jacket</option>
            <option value="men_trouser">Men Trouser</option>
            <option value="kids_shirt">Kids Shirt</option>
            <option value="kids_jacket">Kids Jacket</option>
            <option value="kids_trouser">Kids Trouser</option>
        </select>
       
        <span id="category_err" class="err"></span>

        <label for="operation">Select Operation:</label>
        <select name="operation" id="operation" onchange="toggleProductIdField()">
            <option value="">Select an operation</option>
            <option value="insert">Insert</option>
            <option value="update">Update</option>
            <option value="delete">Delete</option>
        </select>
        <span id="operation_err" class="err"></span>
		
        <button type="submit" name="submit" class="button" value="perform">Perform Operation</button>
    </form>

   
   
   <%
    if (request.getParameter("submit") != null) {
        String category = request.getParameter("category");
        String operation = request.getParameter("operation");
        String productId = request.getParameter("productId");
        String productName = request.getParameter("productName");
        String productDescription = request.getParameter("productDescription");
        String productPrice = request.getParameter("productPrice");
        String productPhoto = request.getParameter("productPhoto");

        int cid = 0; // Default cid value
        
        // Determine cid based on category
        switch (category) {
            case "women_shirt":
                cid = 5;
                break;
            case "women_jacket":
                cid = 4;
                break;
            case "women_frock":
                cid = 6;
                break;
            case "men_shirt":
                cid = 2;
                break;
            case "men_jacket":
                cid = 1;
                break;
            case "men_trouser":
                cid = 3;
                break;
            case "kids_shirt":
                cid = 8;
                break;
            case "kids_jacket":
                cid = 7;
                break;
            case "kids_trouser":
                cid = 9;
                break;
            default:
                break;
        }

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://127.0.0.1:3306/ww_user";
            con = DriverManager.getConnection(url, "root", "root");

            if ("insert".equalsIgnoreCase(operation)) {
                String query = "INSERT INTO product ( pname, pdes, price, photo, cid) VALUES ( ?, ?, ?, ?, ?)";
                ps = con.prepareStatement(query);
                
                ps.setString(1, productName);
                ps.setString(2, productDescription);
                ps.setDouble(3, Double.parseDouble(productPrice));
                ps.setString(4, productPhoto);
                ps.setInt(5, cid);
            } else if ("update".equalsIgnoreCase(operation)) {
                String query = "UPDATE product SET pname=?, pdes=?, price=?, photo=?, cid=? WHERE pid=?";
                ps = con.prepareStatement(query);
                ps.setString(1, productName);
                ps.setString(2, productDescription);
                ps.setDouble(3, Double.parseDouble(productPrice));
                ps.setString(4, productPhoto);
                ps.setInt(5, cid);
                ps.setString(6, productId);
            } else if ("delete".equalsIgnoreCase(operation)) {
                String query = "DELETE FROM product WHERE pid=?";
                ps = con.prepareStatement(query);
                ps.setString(1, productId);
            }

            if (ps != null) {
                int result = ps.executeUpdate();
                if (result > 0) {
                    out.println("<p>Operation " + operation + " completed successfully for product ID: " + productId + ".</p>");
                } else {
                    out.println("<p>Operation " + operation + " failed for product ID: " + productId + ".</p>");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
   
   
   
   
    </main>

    
    
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <script src="whome.js"></script>
</body>
</html>
