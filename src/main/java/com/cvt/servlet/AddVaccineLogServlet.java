package com.cvt.servlet;

import com.cvt.dao.ChildDAO;
import com.cvt.dao.VaccineDAO;
import com.cvt.dao.VaccineLogDAO;
import com.cvt.model.VaccineLog;
import com.cvt.util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;

/** User: log that a child actually received a specific vaccine dose. */
@WebServlet("/user/add-vaccine-log")
public class AddVaccineLogServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = (int) request.getSession().getAttribute("userId");
        try {
            request.setAttribute("children", new ChildDAO().getChildrenByUser(userId));
            request.setAttribute("vaccines", new VaccineDAO().getAllVaccines());
        } catch (SQLException e) {
            request.setAttribute("error", "Could not load form data.");
        }
        request.getRequestDispatcher("/user/add-vaccine-log.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = (int) request.getSession().getAttribute("userId");
        String childIdStr = request.getParameter("childId");
        String vaccineIdStr = request.getParameter("vaccineId");
        String dateGiven = request.getParameter("dateGiven");
        String notes = request.getParameter("notes");

        if (!ValidationUtil.isValidInt(childIdStr) || !ValidationUtil.isValidInt(vaccineIdStr)) {
            forwardWithError(request, response, "Please select a child and a vaccine.");
            return;
        }
        if (!ValidationUtil.isValidPastOrTodayDate(dateGiven)) {
            forwardWithError(request, response, "Date given cannot be in the future.");
            return;
        }

        int childId = Integer.parseInt(childIdStr);
        int vaccineId = Integer.parseInt(vaccineIdStr);

        try {
            ChildDAO childDAO = new ChildDAO();
            // security: make sure this child actually belongs to the logged-in user
            if (!childDAO.belongsToUser(childId, userId)) {
                forwardWithError(request, response, "Invalid child selected.");
                return;
            }

            VaccineLogDAO logDAO = new VaccineLogDAO();
            if (logDAO.alreadyLogged(childId, vaccineId)) {
                forwardWithError(request, response, "This vaccine has already been logged for this child.");
                return;
            }

            VaccineLog log = new VaccineLog();
            log.setChildId(childId);
            log.setVaccineId(vaccineId);
            log.setDateGiven(Date.valueOf(dateGiven));
            log.setNotes(notes == null ? "" : notes.trim());
            logDAO.addLog(log);

            response.sendRedirect(request.getContextPath() + "/user/vaccine-log");
        } catch (SQLException e) {
            forwardWithError(request, response, "Database error while saving vaccine log.");
        }
    }

    private void forwardWithError(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        int userId = (int) request.getSession().getAttribute("userId");
        try {
            request.setAttribute("children", new ChildDAO().getChildrenByUser(userId));
            request.setAttribute("vaccines", new VaccineDAO().getAllVaccines());
        } catch (SQLException ignored) { }
        request.setAttribute("error", message);
        request.getRequestDispatcher("/user/add-vaccine-log.jsp").forward(request, response);
    }
}
