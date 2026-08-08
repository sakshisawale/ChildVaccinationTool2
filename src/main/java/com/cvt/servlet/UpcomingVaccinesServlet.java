package com.cvt.servlet;

import com.cvt.dao.ScheduleDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

/** User: view upcoming vaccines for ALL of their children (not-yet-logged doses). */
@WebServlet("/user/upcoming-vaccines")
public class UpcomingVaccinesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = (int) request.getSession().getAttribute("userId");
        try {
            request.setAttribute("upcoming", new ScheduleDAO().getUpcomingForUser(userId));
        } catch (SQLException e) {
            request.setAttribute("error", "Could not load upcoming vaccines.");
        }
        request.getRequestDispatcher("/user/upcoming-vaccines.jsp").forward(request, response);
    }
}
