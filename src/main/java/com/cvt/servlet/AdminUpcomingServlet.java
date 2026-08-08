package com.cvt.servlet;

import com.cvt.dao.ScheduleDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

/** Admin: view every child (across all users) with a dose due in the next 30 days. */
@WebServlet("/admin/upcoming-vaccines")
public class AdminUpcomingServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("upcoming", new ScheduleDAO().getUpcomingForAllChildren(30));
        } catch (SQLException e) {
            request.setAttribute("error", "Could not load upcoming vaccines.");
        }
        request.getRequestDispatcher("/admin/upcoming-vaccines.jsp").forward(request, response);
    }
}
