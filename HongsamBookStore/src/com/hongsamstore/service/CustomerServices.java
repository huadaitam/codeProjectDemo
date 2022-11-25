package com.hongsamstore.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hongsamstore.dao.CustomerDAO;
import com.hongsamstore.dao.HashGenerator;
import com.hongsamstore.dao.OrderDAO;
import com.hongsamstore.dao.ReviewDAO;
import com.hongsamstore.entity.Category;
import com.hongsamstore.entity.Customer;

public class CustomerServices extends CommonUtitlity {
	private HttpServletRequest request;
	private HttpServletResponse response;
	private CustomerDAO customerDAO;
	private ReviewDAO reviewDAO;

	public CustomerServices(HttpServletRequest request, HttpServletResponse response) {
		super();
		this.request = request;
		this.response = response;
		customerDAO = new CustomerDAO();
		reviewDAO = new ReviewDAO();

	}

	public void listCustomers() throws ServletException, IOException {
		listCustomers(null);
	}

	public void listCustomers(String message) throws ServletException, IOException {
		CustomerDAO customerDAO = new CustomerDAO();
		List<Customer> listCustomer = customerDAO.listAll();

		if (message != null) {
			request.setAttribute("message", message);
		}

		request.setAttribute("listCustomer", listCustomer);

		String listpage = "customer_list.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(listpage);
		dispatcher.forward(request, response);
	}

	public void createCustomer() throws ServletException, IOException {
		String email = request.getParameter("email");
		Customer exitsCustomer = customerDAO.findByEmail(email);

		if (exitsCustomer != null) {
			String message = "Could not create new customer: the email " + email
					+ " is already register by another customers";
			listCustomers(message);
		} else {
			String fullName = request.getParameter("fullName");
			String password = request.getParameter("password");
			String phone = request.getParameter("phone");
			String address = request.getParameter("address");
			String city = request.getParameter("city");
			String zipcode = request.getParameter("zipcode");
			String country = request.getParameter("country");

			Customer newCustomer = new Customer();
			newCustomer.setEmail(email);
			newCustomer.setFullname(fullName);
			newCustomer.setPassword(password);
			newCustomer.setPhone(phone);
			newCustomer.setAddress(address);
			newCustomer.setCity(city);
			newCustomer.setZipcode(zipcode);
			newCustomer.setCountry(country);

			customerDAO.create(newCustomer);

			String message = "New customer has been created successfully!";
			listCustomers(message);
		}

	}

	public void editCustomer() throws ServletException, IOException {
		Integer customerId = Integer.parseInt(request.getParameter("id"));
		Customer customer = customerDAO.get(customerId);

		String editpage = "customer_form.jsp";

		if (customer != null) {
			request.setAttribute("customer", customer);
		} else {
			editpage = "message.jsp";
			String message = "Could not find book with ID " + customerId + ", or it might have been deleted";
			request.setAttribute("message", message);
		}

		RequestDispatcher requestDispatcher = request.getRequestDispatcher(editpage);
		requestDispatcher.forward(request, response);

	}

	public void updateCustomer() throws ServletException, IOException {
		Integer customerId = Integer.parseInt(request.getParameter("customerId"));
		String email = request.getParameter("email");

		Customer exitsCustomer = customerDAO.findByEmail(email);
		String message = null;

		if (exitsCustomer != null && exitsCustomer.getCustomerId() != customerId) {
			message = "Could not update the customer ID " + customerId + " because there's an existing customer"
					+ " having the same";
		} else {
			String fullName = request.getParameter("fullName");
			String password = request.getParameter("password");
			String phone = request.getParameter("phone");
			String address = request.getParameter("address");
			String city = request.getParameter("city");
			String zipcode = request.getParameter("zipcode");
			String country = request.getParameter("country");
			String encryptedPassword = HashGenerator.generateMD5(password);
			
			Customer customerById = customerDAO.get(customerId);
			customerById.setCustomerId(customerId);
			customerById.setEmail(email);
			customerById.setFullname(fullName);
			customerById.setPassword(encryptedPassword);
			customerById.setPhone(phone);
			customerById.setAddress(address);
			customerById.setCity(city);
			customerById.setZipcode(zipcode);
			customerById.setCountry(country);

			customerDAO.update(customerById);

			message = "The customer has been update successfully!";
		}

		listCustomers(message);
	}

	public void deleteCustomer() throws ServletException, IOException {
		Integer customerId = Integer.parseInt(request.getParameter("id"));
		Customer customer = customerDAO.get(customerId);
		
		if (customer != null) {
			ReviewDAO reviewDAO = new ReviewDAO();
			long reviewCount = reviewDAO.countByCustomer(customerId);
			
			if (reviewCount > 0) {
				String message = "Could not delete customer with ID " + customerId
						+ " because he/she posted reviews for books.";
				showMessageBackend(message, request, response);
			} else {
				OrderDAO orderDAO = new OrderDAO();
				long orderCount = orderDAO.countByCustomer(customerId);
				
				if (orderCount > 0) {
					String message = "Could not delete customer with ID " + customerId 
							+ " because he/she placed orders.";
					showMessageBackend(message, request, response);
				} else {
					customerDAO.delete(customerId);			
					String message = "The customer has been deleted successfully.";
					listCustomers(message);
				}
			}
		} else {
			String message = "Could not find customer with ID " + customerId + ", "
					+ "or it has been deleted by another admin";
			showMessageBackend(message, request, response);
		}
		
	}	
	
	private void updateCustomerFieldFromForm(Customer customer) {
		String email = request.getParameter("email");
		String fullName = request.getParameter("fullName");
		String password = request.getParameter("password");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String city = request.getParameter("city");
		String zipcode = request.getParameter("zipcode");
		String country = request.getParameter("country");
		String encryptedPassword = HashGenerator.generateMD5(password);

		if(email != null && !email.equals("")) {
			customer.setEmail(email);
		}
		
		customer.setFullname(fullName);
		
		if(password != null && !password.equals("")) {
			customer.setPassword(encryptedPassword);
		}

		customer.setPhone(phone);
		customer.setAddress(address);
		customer.setCity(city);
		customer.setZipcode(zipcode);
		customer.setCountry(country);
	}

	public void registerCustomer() throws ServletException, IOException {
		String email = request.getParameter("email");
		Customer exitsCustomer = customerDAO.findByEmail(email);
		String message = "";

		if (exitsCustomer != null) {
			message = "Could not register by another: the email " + email + " is already register by another customers";
		} else {
			String fullName = request.getParameter("fullName");
			String password = request.getParameter("password");

			Customer newCustomer = new Customer();
			newCustomer.setEmail(email);
			newCustomer.setFullname(fullName);
			newCustomer.setPassword(password);


			customerDAO.create(newCustomer);

			message = "you have register successfully!";
		}
		String messagePageString = "frontend/message.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(messagePageString);
		request.setAttribute("message", message);
		requestDispatcher.forward(request, response);
	}

	public void showLogin() throws ServletException, IOException {
		String loginPageString = "frontend/login.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(loginPageString);
		dispatcher.forward(request, response);		
	}

	public void doLogin() throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		Customer customer = customerDAO.checkLogin(email, password);
		
		if (customer == null) {
			String message = "Login failed!";
			request.setAttribute("message", message);
			
			showLogin();
		} else {
			HttpSession session = request.getSession();
			session.setAttribute("checkCustomer", customer);
			
			Object objRedirectURL =  session.getAttribute("redirectURL");
			
			if(objRedirectURL != null) {
				String redirectURL = (String) objRedirectURL;
				session.removeAttribute("redirectURL");
				response.sendRedirect(redirectURL);
			} else {
				showCustomerProfile();
			}
		}
	}
	
	public void showCustomerProfile() throws ServletException, IOException {
		String profilePage = "frontend/customer_profile.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(profilePage);
		dispatcher.forward(request, response);
	}

	public void showCustomerProfileEditform() throws ServletException, IOException {
		String profilePage = "frontend/edit_profile.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(profilePage);
		dispatcher.forward(request, response);
	}

	public void updateCustomerProfile() throws ServletException, IOException {
		Customer customer = (Customer) request.getSession().getAttribute("checkCustomer");
		updateCustomerFieldFromForm(customer);
		customerDAO.update(customer);
		
		showCustomerProfile();
	}
}
