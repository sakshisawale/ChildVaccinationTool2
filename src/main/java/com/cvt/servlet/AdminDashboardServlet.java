package com.cvt.servlet;

import com.cvt.dao.ScheduleDAO;
import com.cvt.dao.VaccineDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            VaccineDAO vaccineDAO = new VaccineDAO();
            ScheduleDAO scheduleDAO = new ScheduleDAO();
            request.setAttribute("totalVaccines", vaccineDAO.getAllVaccines().size());
            request.setAttribute("upcomingCount", scheduleDAO.getUpcomingForAllChildren(30).size());
        } catch (SQLException e) {
            request.setAttribute("error", "Could not load dashboard stats.");
        }
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}
