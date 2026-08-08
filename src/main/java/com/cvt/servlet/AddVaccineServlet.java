package com.cvt.servlet;

import com.cvt.dao.VaccineDAO;
import com.cvt.model.Vaccine;
import com.cvt.util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;

@WebServlet("/admin/add-vaccine")
public class AddVaccineServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/add-vaccine.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("vaccineName");
        String description = request.getParameter("description");
        String ageDays = request.getParameter("recommendedAgeDays");
        String doseNumber = request.getParameter("doseNumber");
        String price = request.getParameter("price");

        if (!ValidationUtil.isNotEmpty(name) || name.trim().length() < 2) {
            request.setAttribute("error", "Vaccine name is required (min 2 characters).");
            request.getRequestDispatcher("/admin/add-vaccine.jsp").forward(request, response);
            return;
        }
        if (!ValidationUtil.isValidInt(ageDays) || Integer.parseInt(ageDays) < 0) {
            request.setAttribute("error", "Recommended age (in days) must be a non-negative number.");
            request.getRequestDispatcher("/admin/add-vaccine.jsp").forward(request, response);
            return;
        }
        if (!ValidationUtil.isValidInt(doseNumber) || Integer.parseInt(doseNumber) < 1) {
            request.setAttribute("error", "Dose number must be 1 or higher.");
            request.getRequestDispatcher("/admin/add-vaccine.jsp").forward(request, response);
            return;
        }
        if (!ValidationUtil.isPositiveNumber(price)) {
            request.setAttribute("error", "Price must be a valid non-negative number.");
            request.getRequestDispatcher("/admin/add-vaccine.jsp").forward(request, response);
            return;
        }

        try {
            Vaccine v = new Vaccine();
            v.setVaccineName(name.trim());
            v.setDescription(description == null ? "" : description.trim());
            v.setRecommendedAgeDays(Integer.parseInt(ageDays));
            v.setDoseNumber(Integer.parseInt(doseNumber));
            v.setPrice(new BigDecimal(price));

            new VaccineDAO().addVaccine(v);
            response.sendRedirect(request.getContextPath() + "/admin/view-vaccines");
        } catch (SQLException e) {
            request.setAttribute("error", "Database error while saving vaccine.");
            request.getRequestDispatcher("/admin/add-vaccine.jsp").forward(request, response);
        }
    }
}
