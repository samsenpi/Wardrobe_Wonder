
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Search
 */
@WebServlet("/Search")
public class Search extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Search() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
		
		
			 PrintWriter out = response.getWriter();
	        
	        response.setContentType("text/html");

		
	        String search=request.getParameter("search");
	        
		
	        if (search != null && !search.isEmpty()) {
	            search = search.toLowerCase().replaceAll("\\s", "");  
	            
//	            String[] words = search.toLowerCase().split("\\s+");
	            
//	            if ("women".equals( search) ||"womens".equals( search)||"womans".equals( search)||"woman".equals( search) ) {
//                	response.sendRedirect("./women.jsp") ;
//                	
//                }else if ("men".equals( search) ||"mens".equals( search)||"mans".equals( search)||"man".equals( search) ) {
//                	response.sendRedirect("./men.jsp") ;
//                	
//                }  if ("kids".equals( search) ||"kid".equals( search)||"childrens".equals( search)||"children".equals( search) ) {
//                	response.sendRedirect("./kids.jsp") ;
//                	
//                }   

	            try {
	                Class.forName("com.mysql.jdbc.Driver");
	                String url = "jdbc:mysql://127.0.0.1:3306/ww_user";
	                Connection con = DriverManager.getConnection(url, "root", "root");
	                String query = "SELECT * FROM category WHERE LOWER(CategoryName) LIKE ?";
	                PreparedStatement ps = con.prepareStatement(query);
	                ps.setString(1, "%" + search+"%");

	                ResultSet product = ps.executeQuery();

	                out.println("<h1>Search Results for: " + search+"</h1>");
	                
	                if (product.next()) {
	                    String categoryName = product.getString("categoryName");
	                    
	                    
	                    if ("menshirts".equals( categoryName) ) {
	                    	response.sendRedirect("./men_shirt.jsp") ;
	                    	
	                    } else if ("mentrousers".equals( categoryName) ) {
	                    	response.sendRedirect("./men_trouser.jsp") ;
	                    	
	                    } else if ("menjackets".equals( categoryName) ) {
	                    	response.sendRedirect("./men_jacket.jsp") ;
	                    	
	                    }else if ("womenshirts".equals( categoryName) ) 
	                    {
	                    	
		                    	response.sendRedirect("./women_shirt.jsp") ;
		                    	
		                  } else if ("womenfrocks".equals( categoryName) ) {
		                    	response.sendRedirect("./women_frock.jsp") ;
		                    	
		                    } else if ("womenjackets".equals( categoryName) ) {
		                    	response.sendRedirect("./women_jacket.jsp") ;
		                    	
		                    }else if ("kidshirts".equals( categoryName) ) {
		                    	response.sendRedirect("./kids_shirt.jsp") ;
		                    	
		                    } else if ("kidtrouser".equals( categoryName) ) {
		                    	response.sendRedirect("./kids_trouser.jsp") ;
		                    	
		                    } else if ("kidjackets".equals( categoryName) ) {
		                    	response.sendRedirect("./kids_jackets.jsp") ;
		                    	
		                    }
		                    
		                    else {
		                    	 out.println("<p>Category: " + categoryName + "</p>");
		                    }
		                   
		                    
	                    
	                   
	                }else {
	                	 out.println("<p>Error:  product not databasr</p>");
	                }

	                ps.close();
	                con.close();
	            } catch (ClassNotFoundException | SQLException e) {
	                out.println("<p>Error: " + e.getMessage() + "</p>");
	            }
	        } else {
	            out.println("<h1>No search query provided.</h1>");
	        }

	        out.close();
	    }
	}
