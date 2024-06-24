<%@ page language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.ArrayList" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WardrobeWonders</title>
    <link rel="stylesheet" href="./whome.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <!-- header -->
    <header>
        <div class="search">
            <h1>WardrobeWonders</h1>
            <form action="Search" method="post" class="search-form">
                <input type="search" name="search" placeholder="search">
                <button class="sbtn" type="submit"><i class="fa fa-search"></i></button>
            </form>

            <form >
                <a href="./ViewCart.jsp">
   						 <button class="cart" type="button"><i class="fas fa-shopping-cart"></i></button>
				</a>
                <input type="hidden" name="value" value="true">
            </form>

            <form action="SessionEnd" method="post">
                <button class="logout" id="lg" type="submit"><i class="fas fa-sign-out-alt"></i></button>
                <input type="hidden" name="value" value="true">
            </form>

            <div class="dropdown">
                <button class="dropbtn">Category <i class="fas fa-caret-down"></i></button>
                <div id="myDropdown" class="dropdown-content">
                    <div class="women">
                        <a href="./women.jsp" onmouseover="showSubmenu('submenu-w')">Women</a>
                        <div class="submenu-w" onmouseover="showSubmenu('submenu-w')" onmouseout="hideSubmenu('submenu-w')">
                            <a href="./women_jacket.jsp">Women Jacket</a>
                            <a href="./women_shirt.jsp">Women Shirt</a>
                            <a href="./women_frock.jsp">Women Frocks</a>
                        </div>
                    </div>
                    <div class="men">
                        <a href="./men.jsp" onmouseover="showSubmenu('submenu-m')">Men</a>
                        <div class="submenu-m" onmouseover="showSubmenu('submenu-m')" onmouseout="hideSubmenu('submenu-m')">
                            <a href="./men_jacket.jsp">Men Jacket</a>
                            <a href="./men_shirt.jsp">Men Shirt</a>
                            <a href="./men_trousers.jsp">Men Trousers</a>
                        </div>
                     </div>
                     <div class="kids">
                          <a href="./kids.jsp" onmouseover="showSubmenu('submenu-k')">Kids</a>
                          <div class="submenu-k" onmouseover="showSubmenu('submenu-k')" onmouseout="hideSubmenu('submenu-k')">
                              <a href="./kids_jackets.jsp">Kids Jacket</a>
                              <a href="./kids_shirt.jsp">Kids Shirt</a>
                              <a href="./kids_trouser.jsp">Kids Trousers</a>
                          </div>
                     </div>
                </div>
            </div>
        </div>

        <div class="nav">
            <ul class="nav-list">
                <li class="nav-item"><a href="./whome.jsp"> Home </a></li>
                <li class="nav-item"><a href="./women.jsp"> Women </a></li>
                <li class="nav-item"><a href="./men.jsp"> Man </a></li>
                <li class="nav-item"><a href="./kids.jsp"> Kids </a></li>
            </ul>
        </div>
    </header>

    <main id="products">
        <%
            HttpSession s = request.getSession(false);
            if (s != null) {
                String type = (String) s.getAttribute("type1");
                String name = (String) s.getAttribute("username");
                if (type != null && "user".equals(type)) {
        %>
                    <p>Welcome <%= name %>!</p>
        <%
                } else {
        %>
                    <p>No user logged in.</p>
        <%
                    response.sendRedirect("./wlogin.html");
                }
            } else {
        %>  
                <p>No session found.</p>
        <%
            }
        %>
	<div class="wproduct">
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://127.0.0.1:3306/ww_user";
                Connection con = DriverManager.getConnection(url, "root", "root");
                Statement stm = con.createStatement();
                ResultSet rs = stm.executeQuery("SELECT * FROM product WHERE cid = 1");
                
                while (rs.next()) {
                    String id = rs.getString("pid");
                    String productName = rs.getString("pname");
                    String productDescription = rs.getString("pdes");
                    String productPhoto = rs.getString("photo");
                    double productPrice = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
        %>
                    <div class="items">
                        <img src="<%= productPhoto %>" alt="<%= productName %>">
                        <h3><%= productName %></h3>
                        <p>Description: <%= productDescription %></p>
                        <p>Price: $<%= productPrice %></p>
        
                        <div class="qna">
      			
      								<p>Quantity:</p>
      							  <select id="quantity-<%= id %>" name="quantity">
       				 
       				 					   
      			   								   <% for (int i = 1; i <= quantity; i++) { %>
           												     <option value="<%= i %>"><%= i %></option>
         											   <% } %>
       								 </select>
        		
   						 </div>
                        <div id="error-<%= id %>" style="color:red"></div>
                        
                        	<form action="AddToCart" method="post" onsubmit="return validateForm('<%= id %>')" >
                        	    <button type="submit">Add To Cart</button>
                            	<input type="hidden" name="product_id" value="<%= id %>">
                            	<input type="hidden" name="page_name" value="./men_jacket.jsp">
                            	
                            	<input type="hidden" name="product_name" value="<%= productName %>">
                            	<input type="hidden" name="quantity" id="hiddenQuantity-<%= id %>">
                        </form>
                    </div>
        <%
                }
                
                rs.close();
                stm.close();
                con.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        %>
         </div>
    </main>

  <script>
        function validateForm(productId) {
            var quantity = document.getElementById('quantity-' + productId).value;
            document.getElementById('hiddenQuantity-' + productId).value = quantity;
            if (!quantity) {
                alert('Please select a quantity before adding to cart.');
                return false; 
            } else if (quantity < 1) {
                document.getElementById('error-' + productId).innerText = "Sold Out!!";
                return false;
            } else {
                return true; 
            }
        }
    </script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <script src="whomse.js"></script>
</body>
</html>
