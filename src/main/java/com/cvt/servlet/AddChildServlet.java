package com.cvt.servlet;

import com.cvt.dao.ChildDAO;
import com.cvt.model.Child;
import com.cvt.util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;

@WebServlet("/user/add-child")
public class AddChildServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/user/add-child.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = (int) request.getSession().getAttribute("userId");
        String name = request.getParameter("childName");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");

        if (!ValidationUtil.isNotEmpty(name) || name.trim().length() < 2) {
            request.setAttribute("error", "Child's name is required (min 2 characters).");
            request.getRequestDispatcher("/user/add-child.jsp").forward(request, response);
            return;
        }
        if (!ValidationUtil.isValidDateOfBirth(dob)) {
            request.setAttribute("error", "Please enter a valid date of birth (not in the future, within last 18 years).");
            request.getRequestDispatcher("/user/add-child.jsp").forward(request, response);
            return;
        }
        if (!ValidationUtil.isValidGender(gender)) {
            request.setAttribute("error", "Please select a valid gender.");
            request.getRequestDispatcher("/user/add-child.jsp").forward(request, response);
            return;
        }

        try {
            Child child = new Child();
            child.setUserId(userId);
            child.setChildName(name.trim());
            child.setDob(Date.valueOf(dob));
            child.setGender(gender);
            new ChildDAO().addChild(child);
            response.sendRedirect(request.getContextPath() + "/user/view-children");
        } catch (SQLException e) {
            request.setAttribute("error", "Database error while saving child record.");
            request.getRequestDispatcher("/user/add-child.jsp").forward(request, response);
        }
    }
}
