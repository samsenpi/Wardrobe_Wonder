

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.*;

/**
 * Servlet implementation class RemoveFromCart
 */
@WebServlet("/RemoveFromCart")
public class RemoveFromCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RemoveFromCart() {
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
		
		doGet(request, response);
		
		
		 HttpSession nss = request.getSession(false);
	        if (nss != null) {
	            String productId = request.getParameter("productId");
	            if (productId != null) {
	                Integer quantity = (Integer) nss.getAttribute(productId);
	                if (quantity != null && quantity > 0) {
	                    if (quantity == 1) {
	                        nss.removeAttribute(productId);
	                    } else {
	                        nss
	                        .setAttribute(productId, quantity - 1);
	                    }
	                }
	            }
	        }
	        response.sendRedirect("ViewCart.jsp");
	    }
	}


