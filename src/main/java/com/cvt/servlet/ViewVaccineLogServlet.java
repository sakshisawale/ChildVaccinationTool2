package com.cvt.servlet;

import com.cvt.dao.VaccineLogDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/user/vaccine-log")
public class ViewVaccineLogServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = (int) request.getSession().getAttribute("userId");
        try {
            request.setAttribute("logs", new VaccineLogDAO().getLogsByUser(userId));
        } catch (SQLException e) {
            request.setAttribute("error", "Could not load vaccination history.");
        }
        request.getRequestDispatcher("/user/vaccine-log.jsp").forward(request, response);
    }
}
