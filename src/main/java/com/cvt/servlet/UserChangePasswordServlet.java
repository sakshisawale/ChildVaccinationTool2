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

@WebServlet("/user/change-password")
public class UserChangePasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/user/change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = (int) request.getSession().getAttribute("userId");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.findById(userId);

            if (user == null || !PasswordUtil.checkPassword(currentPassword, user.getPassword())) {
                request.setAttribute("error", "Current password is incorrect.");
            } else if (!ValidationUtil.isValidPassword(newPassword)) {
                request.setAttribute("error", "New password must be at least 8 characters with a letter and a number.");
            } else if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "New passwords do not match.");
            } else {
                userDAO.updatePassword(userId, PasswordUtil.hashPassword(newPassword));
                request.setAttribute("success", "Password changed successfully.");
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error while changing password.");
        }
        request.getRequestDispatcher("/user/change-password.jsp").forward(request, response);
    }
}
