package com.hongsamstore.service;

import java.io.IOException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hongsamstore.dao.BookDAO;
import com.hongsamstore.dao.CategoryDAO;
import com.hongsamstore.entity.Category;
import com.hongsamstore.entity.Users;

public class CategoryServices {
	private CategoryDAO categoryDAO;
	private HttpServletRequest request;
	private HttpServletResponse response;

	public CategoryServices(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;

		categoryDAO = new CategoryDAO();
	}

	public void listCategory(String message) throws ServletException, IOException {
		
		List<Category> listCategory = categoryDAO.listAll();

		request.setAttribute("listCategory", listCategory);
		request.setAttribute("message", message);

		String listPage = "category_list.jsp";
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(listPage);

		dispatcher.forward(request, response);
	}
	
	public void listCategory() throws ServletException, IOException {
		listCategory(null);
	}

	public void createCategory() throws ServletException, IOException {
		String name = request.getParameter("name");
		Category exitsCategory = categoryDAO.findByName(name);
		
		if(exitsCategory != null) {
			String message = "Could not create category." + " A category with name " + name + " already exits.";
			request.setAttribute("message", message);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("message.jsp");
			dispatcher.forward(request, response);
		} else {
			Category newCateogry = new Category(name);
			categoryDAO.create(newCateogry);
			
			String message = "New Category create Succesfuly!";
			listCategory(message);
		}
	}
	
	public void editCategory() throws ServletException, IOException {
		int categoryId = Integer.parseInt(request.getParameter("id"));
		Category category = categoryDAO.get(categoryId);
		request.setAttribute("category", category);
		
		String editPage = "category_form.jsp";
		
		if (category == null) {
			editPage = "message.jsp";
			String errorMessage = "Could not find user with ID " + categoryId;
			request.setAttribute("message", errorMessage);
		} else {
			request.setAttribute("category", category);			
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(editPage);
		dispatcher.forward(request, response);
	}

	public void updateCategory() throws ServletException, IOException {
		int categoryId = Integer.parseInt(request.getParameter("categoryId"));
		String categoryName = request.getParameter("name");
		
		Category categoryById = categoryDAO.get(categoryId);
		Category categoryByName = categoryDAO.findByName(categoryName);
		
		if(categoryByName != null && categoryById.getCategoryId() != categoryByName.getCategoryId()) {
			String message = "Could not update category. " +  "A category with name " + categoryName + " already exits.";
			
			request.setAttribute("message", message);
			RequestDispatcher dispatcher = request.getRequestDispatcher("message.jsp");
			dispatcher.forward(request, response);
		} else {
			categoryById.setName(categoryName);
			categoryDAO.update(categoryById);
			String message = "Category has been updated Successfully!";
			listCategory(message);
		};
	}

	public void deleteCategory() throws ServletException, IOException {
		int categoryId = Integer.parseInt(request.getParameter("id"));
		BookDAO bookDAO = new BookDAO();
		
		long numberOfBook = bookDAO.countByCategory(categoryId);
		
		String message = "The category ID " + categoryId + " has been removed successfully!";
		
		Category category = categoryDAO.get(categoryId);
		
		if (category == null) {
			message = "Could not find category with ID " + categoryId
					+ ", or it might have been deleted by another admin";
			
			request.setAttribute("message", message);
			request.getRequestDispatcher("message.jsp").forward(request, response);			
		} else {
			if(numberOfBook > 0) {
				message = "Could not deletr category with ID " + categoryId
						+ ", because it contains some books";
				
				request.setAttribute("message", message);
				request.getRequestDispatcher("message.jsp").forward(request, response);
			} else {
				categoryDAO.delete(categoryId);
				listCategory(message);
			}
		}	
		
	}
}
