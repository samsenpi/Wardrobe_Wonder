<%@ page language="java" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WardrobeWonders</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="./whome.css">
</head>
<body>
    <!-- Header -->
    <header>
        <div class="search">
            <h1>WardrobeWonders</h1>
            <form action="Search" method="post" class="search-form">
                <input type="search" name="search" placeholder="search">
                <button class="sbtn" type="submit"><i class="fa fa-search"></i></button>
            </form>
            
            <a href="./ViewCart.jsp">
                <button class="cart" type="button"><i class="fas fa-shopping-cart"></i></button>
            </a>
            
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
                <li class="nav-item"><a href="./men.jsp"> Men </a></li>
                <li class="nav-item"><a href="./kids.jsp"> Kids </a></li>
            </ul>
        </div>
    </header>
    
    <!-- Main Content (Shopping Cart) -->
    <main id="cart">
    
    <div class="cproduct">
        <h2>Your Shopping Cart</h2>
        <% 
            HttpSession session1 = request.getSession(false);
            if (session1 != null) {
                // Create a HashMap to store product IDs and quantities
                HashMap<String, Integer> cartItems = new HashMap<>();
                Enumeration<String> attributeNames = session1.getAttributeNames();
                int skipCount = 2; // Number of attributes to skip (session management)
                
                // Skip the first two attributes (session management)
              
                
                // Store remaining session attributes in HashMap (product ID -> quantity)
                while (attributeNames.hasMoreElements()) {
                    String productId = attributeNames.nextElement();
                    // Retrieve quantity as Object from session
                    Object quantityObj = session1.getAttribute(productId);
                    
                    try {
                        int quantity = Integer.parseInt(quantityObj.toString());
                        cartItems.put(productId, quantity);
                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                    }
                }
                
                // Check if there are items in the cart
                if (!cartItems.isEmpty()) {
                    %>
                    
                    <div class="cart-items">
                    <%
                    double grandTotal = 0.0; // Total price of all items in cart
                    
                    // Prepare list of product IDs for IN clause
                    StringJoiner productIdList = new StringJoiner(",", "(", ")");
                    for (String productId : cartItems.keySet()) {
                        productIdList.add("'" + productId + "'");
                    }
                    
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        String url = "jdbc:mysql://127.0.0.1:3306/ww_user";
                        Connection con = DriverManager.getConnection(url, "root", "root");
                        
                        // Statement with dynamic IN clause to fetch product details
                        String query = "SELECT * FROM product WHERE pid IN " + productIdList.toString();
                        Statement stmt = con.createStatement();
                        
                        // Execute the query
                        ResultSet rs = stmt.executeQuery(query);
                        
                        while (rs.next()) {
                            String productId = rs.getString("pid");
                            int quantity = cartItems.get(productId);
                            String productName = rs.getString("pname");
                            String productDescription = rs.getString("pdes");
                            String productPhoto = rs.getString("photo");
                            double productPrice = rs.getDouble("price");
                            double totalPrice = productPrice * quantity;
                            grandTotal += totalPrice;
                            %>
                            <div class="cart-item">
                                <img src="
                                <%= productPhoto %>" alt="<%= productName %>">
                                <div>
                                    <h3><%= productName %></h3>
                                    <p>Description: <%= productDescription %></p>
                                    <p>Price: $<%= productPrice %></p>
                                    <p>Quantity: <%= quantity %></p>
                                    <p>Total: $<%= totalPrice %></p>
                                    <form action="RemoveFromCart" method="post">
                                        <input type="hidden" name="productId" value="<%= productId %>">
                                        <button type="submit">Remove One</button>
                                    </form>
                                </div>
                            </div>
                            <%
                        }
                        
                        rs.close();
                        stmt.close();
                        con.close();
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    }
                    %>
                   
                    </div>
                     <div class="cart-total">
                        <strong>Grand Total: $<%= grandTotal %></strong>
                    </div>
                    </div>
                    <%
                } else {
                    %>
                    <p>Your cart is empty.</p>
                    <%
                }
            } else {
                %>
                <p>No session found. Please log in.</p>
                <%
            }
        %>
        
        <!-- Form for checkout (if needed) -->
        <!-- <form action="Checkout" method="post">
            <button type="submit">Proceed to Checkout</button>
        </form> -->
    </main>
    
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <script src="whome.js"></script>
</body>
</html>
