
<%@ page language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %> 

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
            <button class="sbtn" onclick="true"> <i class="fa fa-search"></i></button>
           	</form>


            <button class="cart"><i class="fas fa-shopping-cart"></i> </button>
           
			
             <form action="SessionEnd" method="post" >
 
 					 <button class="logout" id="lg"  onclick=" true"><i class="fas fa-sign-out-alt"></i> </button>
 					 <input id="hiddenValue" type="hidden" name="value" value="true">
 					 
 					 
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
                          	  <a href="./kids.jsp" onmouseover="showSubmenu('submenu-k')">kids</a>
                          	  <div class="submenu-k" onmouseover="showSubmenu('submenu-k')" onmouseout="hideSubmenu('submenu-k')">
                              	  <a href="./kids_jackets.jsp">Kids Jacket</a>
                           	     <a href="./kids_shirt.jsp">kids Shirt</a>
                              	  <a href="./kids_trouser.jsp">kids Trousers</a>
                           	  </div>
                    	 </div>
                </div>
            </div>
        

		</div>

           <div class="nav">
            <ul class="nav-list">
                <li class="nav-item" ><a href="./whome.jsp"> Home </a></li>
                <li class="nav-item" ><a href="./women.jsp"> women </a></li>
                <li class="nav-item" ><a href="./men.jsp"> Man </a></li>
                <li class="nav-item" ><a href="./kids.jsp"> kids </a></li>
                
            </ul>
        </div>

                  
                   
                    
                   
                    
                
          

        
    </header>

    <main id="products">


 <%
            // Retrieving session attribute
            HttpSession s = request.getSession(false); // Don't create new session if it doesn't exist
            if (s != null) {
                String type = (String) session.getAttribute("type1");
                String name = (String) session.getAttribute("username");
                if (type != null && "user".equals(type)) {
        %>
                    <p>Welcome <%= name %>!</p>
        <%
                } else {
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

          <h2> women Product Categories</h2>

        <section id="product-categories" >
          
            
           
            <div class="category">
                <a href="./women_frock.jsp">
                    <img src="./images/thumbnails/women_frocks.jpg" alt="Women Frocks">
                    <span>Women Frocks</span>
                </a>
            </div>
            <div class="category">
                <a href="./women_shirt.jsp">
                    <img src="./images/thumbnails/women shirts.jpg" alt="Women Shirts">
                    <span>Women Shirts</span>
                </a>
            </div>

            <div class="category">
                <a href="./women_jacket.jsp">
                    <img src="./images/thumbnails/women jackets.jpg" alt="women jacket">
                    <span>women jacket</span>
                </a>
            </div>



		</section>







    </main>

    <footer>
        <p>&copy; WardrobeWonders. All rights reserved.</p>
    </footer> 
    
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <script src="whome.js"></script>
</body>
</html>
