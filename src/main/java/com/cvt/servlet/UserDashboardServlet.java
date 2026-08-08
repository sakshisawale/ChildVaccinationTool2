package com.cvt.servlet;

import com.cvt.dao.ChildDAO;
import com.cvt.dao.ScheduleDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/user/dashboard")
public class UserDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = (int) request.getSession().getAttribute("userId");
        try {
            request.setAttribute("childCount", new ChildDAO().getChildrenByUser(userId).size());
            request.setAttribute("upcomingCount", new ScheduleDAO().getUpcomingForUser(userId).size());
        } catch (SQLException e) {
            request.setAttribute("error", "Could not load dashboard stats.");
        }
        request.getRequestDispatcher("/user/dashboard.jsp").forward(request, response);
    }
}
