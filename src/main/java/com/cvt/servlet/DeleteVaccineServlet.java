package com.cvt.servlet;

import com.cvt.dao.VaccineDAO;
import com.cvt.util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/delete-vaccine")
public class DeleteVaccineServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        if (ValidationUtil.isValidInt(id)) {
            try {
                new VaccineDAO().deleteVaccine(Integer.parseInt(id));
            } catch (SQLException e) {
                request.getSession().setAttribute("error", "Could not delete vaccine (it may already be logged for a child).");
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/view-vaccines");
    }
}
