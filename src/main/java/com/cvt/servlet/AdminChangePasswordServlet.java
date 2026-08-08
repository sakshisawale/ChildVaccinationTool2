package com.cvt.servlet;

import com.cvt.dao.AdminDAO;
import com.cvt.model.Admin;
import com.cvt.util.PasswordUtil;
import com.cvt.util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/change-password")
public class AdminChangePasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int adminId = (int) request.getSession().getAttribute("adminId");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        try {
            AdminDAO adminDAO = new AdminDAO();
            String username = (String) request.getSession().getAttribute("adminUsername");
            Admin admin = adminDAO.findByUsername(username);

            if (admin == null || !PasswordUtil.checkPassword(currentPassword, admin.getPassword())) {
                request.setAttribute("error", "Current password is incorrect.");
            } else if (!ValidationUtil.isValidPassword(newPassword)) {
                request.setAttribute("error", "New password must be at least 8 characters with a letter and a number.");
            } else if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "New passwords do not match.");
            } else {
                adminDAO.updatePassword(adminId, PasswordUtil.hashPassword(newPassword));
                request.setAttribute("success", "Password changed successfully.");
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error while changing password.");
        }
        request.getRequestDispatcher("/admin/change-password.jsp").forward(request, response);
    }
}
