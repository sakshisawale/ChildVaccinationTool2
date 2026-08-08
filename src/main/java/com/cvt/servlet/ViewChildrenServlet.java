package com.cvt.servlet;

import com.cvt.dao.ChildDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/user/view-children")
public class ViewChildrenServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = (int) request.getSession().getAttribute("userId");
        try {
            request.setAttribute("children", new ChildDAO().getChildrenByUser(userId));
        } catch (SQLException e) {
            request.setAttribute("error", "Could not load children records.");
        }
        request.getRequestDispatcher("/user/view-children.jsp").forward(request, response);
    }
}
