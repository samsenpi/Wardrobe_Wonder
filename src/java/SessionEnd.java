

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
 * Servlet implementation class sessionEnd
 */
@WebServlet("/SessionEnd")
public class SessionEnd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SessionEnd() {
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
		
	       
	    
	        
		
		
		HttpSession st = request.getSession(false); // Don't create new session if it doesn't exist
    if (st != null) {
    	

		try {
	
			String lg=request.getParameter("value");
			//out.println("<h1> found</h1>");
			
			//  out.println("<h1>"+lg+"</h1>");
				if(lg.equals("true")& lg!= null ){
		
					st.invalidate();
					response.sendRedirect("./wlogin.html") ;
				}

			} catch (NullPointerException | IllegalArgumentException e) {
	
				e.getStackTrace();

			}
		
    }else {

    		out.println("<h1>no session found</h1>");
         
        
    }
    	
   			 
        

    


		
		
		
		
	}

}
