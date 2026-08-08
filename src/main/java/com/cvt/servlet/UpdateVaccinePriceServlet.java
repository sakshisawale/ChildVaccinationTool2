package com.cvt.servlet;

import com.cvt.dao.VaccineDAO;
import com.cvt.util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;

@WebServlet("/admin/update-price")
public class UpdateVaccinePriceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("vaccines", new VaccineDAO().getAllVaccines());
        } catch (SQLException e) {
            request.setAttribute("error", "Could not load vaccines.");
        }
        request.getRequestDispatcher("/admin/update-price.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("vaccineId");
        String price = request.getParameter("price");

        if (!ValidationUtil.isValidInt(id) || !ValidationUtil.isPositiveNumber(price)) {
            request.getSession().setAttribute("error", "Invalid vaccine or price value.");
            response.sendRedirect(request.getContextPath() + "/admin/update-price");
            return;
        }

        try {
            new VaccineDAO().updatePrice(Integer.parseInt(id), new BigDecimal(price));
            request.getSession().setAttribute("success", "Price updated successfully.");
        } catch (SQLException e) {
            request.getSession().setAttribute("error", "Database error while updating price.");
        }
        response.sendRedirect(request.getContextPath() + "/admin/update-price");
    }
}
