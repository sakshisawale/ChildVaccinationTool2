package com.cvt.servlet;

import com.cvt.dao.VaccineDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/view-vaccines")
public class ViewVaccinesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("vaccines", new VaccineDAO().getAllVaccines());
        } catch (SQLException e) {
            request.setAttribute("error", "Could not load vaccines.");
        }
        request.getRequestDispatcher("/admin/view-vaccines.jsp").forward(request, response);
    }
}
