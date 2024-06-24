

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
 * Servlet implementation class Wlogin
 */
@WebServlet("/Wlogin")
public class Wlogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Wlogin() {
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

	        String name=request.getParameter("username");
	        String email = request.getParameter("email");
	        String passwd = request.getParameter("password");
	        
//	            int at = email.indexOf('@');
//	            int dot = email.indexOf('.', at + 1);
//	            int len = email.length();
	        
	        out.println("<html>");
	        out.println("<head><title>Response</title></head>");
	        out.println("<body bgcolor=\"lightblue\">");
	        
	        try {
	            

	            
//	            if ((at > -1) && (dot > -1) && (len > dot + 1)) {

	                Class.forName("com.mysql.jdbc.Driver");
	              
	                String url = "jdbc:mysql://127.0.0.1:3306/ww_user";

			        Connection con=DriverManager.getConnection(url, "root", "root");

			        Statement s = con.createStatement();
			        String query = "SELECT * FROM user WHERE username=? AND email=? AND password=?";
			        PreparedStatement ps = con.prepareStatement(query);
			        ps.setString(1, name);
			        ps.setString(2, email);
			        ps.setString(3, passwd);

			        ResultSet rs = ps.executeQuery();

			      
	                out.println("<h1>response</h1>");
	                if(rs.next()){

	                	 String uname = rs.getString("username");

		            	    String type= rs.getString("type");
		            	    
	                	
	            	    out.println("<h1>Record found</h1>");

	            	   

	            	   // out.println("<h1>User Name: "+uname+" </h1>");
	        	  //  out.println("<h1>User type: "+ type+ " </h1>");

    	    
	        	    	HttpSession session = request.getSession(true);
	        	    	session.setAttribute("username",uname);
	        	    	session.setAttribute("type1",type);
	        	    	//request.setAttribute("username", uname);
////	        	    	//String type2 = (String) request.getAttribute("username");  
//	        	    	
	        	    	if (type== null) {  
    	    			
    	    			response.sendRedirect("./wlogin.html");  
	        	    	
	        	    	} else if ("admin".equals(type)){  
//	        	    			        	    	 RequestDispatcher dispatcher = request.getRequestDispatcher("./adminhome.jsp");
////////	        	         dispatcher.forward(request, response);
//////    	    			
	        	    		response.sendRedirect("./admin.jsp"); 
////    	    
//////	        	    	
	        	    	}else   {  
////    	    		
////    	    	
	        	    			response.sendRedirect("./whome.jsp");  
////	        	    	
    	    	} 
//////	        	    	
	       	   	 
            } else{
	                	 out.println("<h1>No record found</h1>");
	                      }


	            out.println("</body></html>");
	                       s.close();
	                       con.close();

	                

	        } catch (ClassNotFoundException e) {
	            e.printStackTrace();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }catch(Exception e){

		          out.println(e);
		        }
	        //out.close();
	        
	        
	       


	}

}
