package com.cvt.servlet;

import com.cvt.dao.UserDAO;
import com.cvt.model.User;
import com.cvt.util.PasswordUtil;
import com.cvt.util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/user-register")
public class UserRegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // keep entered values so the form can be re-shown without re-typing everything
        request.setAttribute("fullName", fullName);
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);

        if (!ValidationUtil.isNotEmpty(fullName) || fullName.trim().length() < 3) {
            request.setAttribute("error", "Full name must be at least 3 characters.");
            request.getRequestDispatcher("/user-register.jsp").forward(request, response);
            return;
        }
        if (!ValidationUtil.isValidEmail(email)) {
            request.setAttribute("error", "Please enter a valid email address.");
            request.getRequestDispatcher("/user-register.jsp").forward(request, response);
            return;
        }
        if (!ValidationUtil.isValidPhone(phone)) {
            request.setAttribute("error", "Please enter a valid 10-digit mobile number.");
            request.getRequestDispatcher("/user-register.jsp").forward(request, response);
            return;
        }
        if (!ValidationUtil.isValidPassword(password)) {
            request.setAttribute("error", "Password must be at least 8 characters and include a letter and a number.");
            request.getRequestDispatcher("/user-register.jsp").forward(request, response);
            return;
        }
        if (password == null || !password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/user-register.jsp").forward(request, response);
            return;
        }

        try {
            UserDAO userDAO = new UserDAO();
            if (userDAO.emailExists(email.trim())) {
                request.setAttribute("error", "An account with this email already exists.");
                request.getRequestDispatcher("/user-register.jsp").forward(request, response);
                return;
            }

            User user = new User();
            user.setFullName(fullName.trim());
            user.setEmail(email.trim());
            user.setPhone(phone.trim());
            user.setPassword(PasswordUtil.hashPassword(password));
            userDAO.registerUser(user);

            request.setAttribute("success", "Account created successfully. Please log in.");
            request.getRequestDispatcher("/user-login.jsp").forward(request, response);

        } catch (SQLException e) {
            request.setAttribute("error", "Server/database error. Please try again later.");
            request.getRequestDispatcher("/user-register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/user-register.jsp").forward(request, response);
    }
}
