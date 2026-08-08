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
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin-login")
public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (!ValidationUtil.isNotEmpty(username) || !ValidationUtil.isNotEmpty(password)) {
            request.setAttribute("error", "Username and password are required.");
            request.getRequestDispatcher("/admin-login.jsp").forward(request, response);
            return;
        }

        try {
            AdminDAO adminDAO = new AdminDAO();
            Admin admin = adminDAO.findByUsername(username.trim());

            if (admin != null && PasswordUtil.checkPassword(password, admin.getPassword())) {
                HttpSession session = request.getSession(true);
                session.setAttribute("adminId", admin.getAdminId());
                session.setAttribute("adminUsername", admin.getUsername());
                session.setMaxInactiveInterval(30 * 60); // 30 minutes
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                request.setAttribute("error", "Invalid username or password.");
                request.getRequestDispatcher("/admin-login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Server/database error. Please try again later.");
            request.getRequestDispatcher("/admin-login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin-login.jsp").forward(request, response);
    }
}
