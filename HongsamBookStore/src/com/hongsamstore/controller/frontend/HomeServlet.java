package com.hongsamstore.controller.frontend;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hongsamstore.controller.BaseServlet;
import com.hongsamstore.dao.BookDAO;
import com.hongsamstore.dao.CategoryDAO;
import com.hongsamstore.entity.Book;
import com.hongsamstore.entity.Category;

@WebServlet("")
public class HomeServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
       
    public HomeServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		BookDAO bookDAO = new BookDAO();
		
		List<Book> listNewBook = bookDAO.listNewBooks();
		List<Book> listBestSellingBooks = bookDAO.listBestSellingBooks();
		List<Book> listMostFavoredBooks = bookDAO.listMostFavoredBooks();
		List<Book> listBooks = bookDAO.listAll();
		
		request.setAttribute("listNewBook", listNewBook);
		request.setAttribute("listBestSellingBooks", listBestSellingBooks);
		request.setAttribute("listMostFavoredBooks", listMostFavoredBooks);
		request.setAttribute("listBooks", listBooks);
		
		String homepage = "frontend/index.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(homepage);
		dispatcher.forward(request, response);
	}

}
