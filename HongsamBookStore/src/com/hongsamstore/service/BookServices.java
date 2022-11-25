package com.hongsamstore.service;

import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.hongsamstore.dao.BookDAO;
import com.hongsamstore.dao.CategoryDAO;
import com.hongsamstore.dao.OrderDAO;
import com.hongsamstore.dao.ReviewDAO;
import com.hongsamstore.entity.Book;
import com.hongsamstore.entity.Category;

public class BookServices extends CommonUtitlity {
	private BookDAO bookDAO;
	private CategoryDAO categoryDAO;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private ReviewDAO reviewDAO;

	public BookServices(HttpServletRequest request, HttpServletResponse response) {
		super();
		this.request = request;
		this.response = response;
		bookDAO = new BookDAO();
		categoryDAO = new CategoryDAO();
		reviewDAO = new ReviewDAO();
	}

	public void listBook() throws ServletException, IOException {
		listBook(null);
	}

	public void listBook(String message) throws ServletException, IOException {
		List<Book> listBooks = bookDAO.listAll();
		request.setAttribute("listBooks", listBooks);

		if (message != null) {
			request.setAttribute("message", message);
		}

		String listPage = "book_list.jsp";

		RequestDispatcher dispatcher = request.getRequestDispatcher(listPage);
		dispatcher.forward(request, response);
	}

	public void showBookNewForm() throws ServletException, IOException {
		List<Category> listCategory = categoryDAO.listAll();
		request.setAttribute("listCategory", listCategory);

		String newPage = "book_form.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(newPage);
		dispatcher.forward(request, response);
	}

	public void createBook() throws ServletException, IOException {
		String title = request.getParameter("title");

		Book extisBook = bookDAO.findByTitle(title);

		if (extisBook != null) {
			String message = "Could not create book because the title " + title + " already exits.";
			listBook(message);
			return;
		}

		Book newBook = new Book();
		readBookFields(newBook);

		Book createBook = bookDAO.create(newBook);

		if (createBook.getBookId() > 0) {
			String message = "A new book has been created successfully!";
			request.setAttribute("message", message);
			listBook(message);
		}
	}

	public void readBookFields(Book book) throws ServletException, IOException {
		Integer categoryId = Integer.parseInt(request.getParameter("category"));
		String title = request.getParameter("title");
		String author = request.getParameter("author");
		String description = request.getParameter("description");
		String isbn = request.getParameter("isbn");
		float price = Float.parseFloat(request.getParameter("price"));

		DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
		Date publishDate = null;

		try {
			publishDate = dateFormat.parse(request.getParameter("publishDate"));
		} catch (ParseException ex) {
			ex.printStackTrace();
			throw new ServletException("Error parsing publish date (format is MM/dd/yyyy)");
		}

		book.setTitle(title);
		book.setAuthor(author);
		book.setDescription(description);
		book.setIsbn(isbn);
		book.setPublishDate(publishDate);

		Category category = categoryDAO.get(categoryId);
		book.setCategory(category);
		book.setPrice(price);

		Part part = request.getPart("bookImage");

		if (part != null && part.getSize() > 0) {
			long size = part.getSize();
			byte[] imageBytes = new byte[(int) size];

			InputStream inputStream = part.getInputStream();
			inputStream.read(imageBytes);
			inputStream.close();

			book.setImage(imageBytes);
		}

	}

	public void editBook() throws ServletException, IOException {
		Integer bookId = Integer.parseInt(request.getParameter("id"));
		Book book = bookDAO.get(bookId);
		String destPage = "book_form.jsp";

		if (book != null) {
			List<Category> listCategory = categoryDAO.listAll();

			request.setAttribute("book", book);
			request.setAttribute("listCategory", listCategory);

		} else {
			destPage = "message.jsp";
			String message = "Could not find book with ID " + bookId;
			request.setAttribute("message", message);
		}

		RequestDispatcher requestDispatcher = request.getRequestDispatcher(destPage);
		requestDispatcher.forward(request, response);

	}

	public void updateBook() throws ServletException, IOException {
		Integer bookId = Integer.parseInt(request.getParameter("bookId"));
		String title = request.getParameter("title");

		Book exitsBook = bookDAO.get(bookId);
		Book bookByTitle = bookDAO.findByTitle(title);

		if (bookByTitle != null && !exitsBook.equals(bookByTitle)) {
			String message = "Could not Update book because there's another book having same title.";
			listBook(message);
			return;
		}

		readBookFields(exitsBook);
		bookDAO.update(exitsBook);

		String message = "The book has been updated successfylly";
		listBook(message);
	}

	public void deleteBook() throws ServletException, IOException {
		Integer bookId = Integer.parseInt(request.getParameter("id"));
		Book book =  bookDAO.get(bookId);
		
		if (book == null) {
			String message = "Could not find book with ID " + bookId 
					+ ", or it might have been deleted";
			showMessageBackend(message, request, response);
			
		} else {			
			if (!book.getReviews().isEmpty()) {
				String message = "Could not delete the book with ID " + bookId
						+ " because it has reviews";
				showMessageBackend(message, request, response);
			} else {
				OrderDAO orderDAO = new OrderDAO();
				long countByOrder = orderDAO.countOrderDetailByBook(bookId);
				
				if (countByOrder > 0) {
					String message = "Could not delete book with ID " + bookId
							+ " because there are orders associated with it.";
					showMessageBackend(message, request, response);
				} else {
					String message = "The book has been deleted successfully.";
					bookDAO.delete(bookId);			
					listBook(message);
				}
			}
		}
	}	

	public void listBookByCategory() throws ServletException, IOException {
		int categoryId = Integer.parseInt(request.getParameter("id"));
		List<Book> listBooks = bookDAO.listByCategory(categoryId);
		Category category = categoryDAO.get(categoryId);

		request.setAttribute("listBooks", listBooks);
		request.setAttribute("category", category);

		if (category == null) {
			String message = "Sorry, the category ID " + categoryId + " is not available.";
			request.setAttribute("message", message);
			request.getRequestDispatcher("frontend/message.jsp").forward(request, response);

			return;
		}

		String listPage = "/frontend/books_list_by_category.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(listPage);
		dispatcher.forward(request, response);
	}

	public void viewBookDetail() throws ServletException, IOException {
		Integer bookId = Integer.parseInt(request.getParameter("id"));
		Book book = bookDAO.get(bookId);

		String destPage = "frontend/book_detail.jsp";

		if (book != null) {
			request.setAttribute("book", book);

		} else {
			destPage = "frontend/message.jsp";
			String message = "Sorry, the book with ID " + bookId + " is not available.";
			request.setAttribute("message", message);
		}

		RequestDispatcher requestDispatcher = request.getRequestDispatcher(destPage);
		requestDispatcher.forward(request, response);
	}

	public void search() throws ServletException, IOException {
		String keyword = request.getParameter("keyword");
		List<Book> result = null;

		if (keyword.equals("")) {
			result = bookDAO.listAll();
		} else {
			result = bookDAO.search(keyword);
		}

		request.setAttribute("keyword", keyword);
		request.setAttribute("result", result);

		String searchPage = "frontend/search_result.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(searchPage);
		dispatcher.forward(request, response);
	}

}
