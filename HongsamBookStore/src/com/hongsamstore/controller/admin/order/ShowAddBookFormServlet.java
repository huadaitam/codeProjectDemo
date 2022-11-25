package com.hongsamstore.controller.admin.order;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hongsamstore.dao.BookDAO;
import com.hongsamstore.entity.Book;

@WebServlet("/admin/add_book_form")
public class ShowAddBookFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ShowAddBookFormServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		BookDAO bookDAO = new BookDAO();
		List<Book> listBooks = bookDAO.listAll();
		request.setAttribute("listBooks", listBooks);
		
		String addFormPage = "add_book_form.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(addFormPage);
		dispatcher.forward(request, response);
	}

}
