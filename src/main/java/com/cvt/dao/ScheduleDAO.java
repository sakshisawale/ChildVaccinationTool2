package com.cvt.dao;

import com.cvt.model.Child;
import com.cvt.model.UpcomingVaccine;
import com.cvt.model.Vaccine;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 * Works out which vaccines are still due for a child (or for every child of a user),
 * based on: child's DOB + vaccine.recommended_age_days, skipping anything already
 * present in vaccine_log. Used by both the Admin "upcoming (next 30 days)" screen
 * and the User "upcoming vaccines for my child" screen.
 */
public class ScheduleDAO {

    private final ChildDAO childDAO = new ChildDAO();
    private final VaccineDAO vaccineDAO = new VaccineDAO();
    private final VaccineLogDAO logDAO = new VaccineLogDAO();

    /** All upcoming (including overdue) vaccines for one specific child. */
    public List<UpcomingVaccine> getUpcomingForChild(int childId) throws SQLException {
        Child child = childDAO.getChildById(childId);
        if (child == null) return new ArrayList<>();
        return computeForChild(child);
    }

    /** All upcoming vaccines across every child belonging to one user (parent view). */
    public List<UpcomingVaccine> getUpcomingForUser(int userId) throws SQLException {
        List<UpcomingVaccine> result = new ArrayList<>();
        for (Child child : childDAO.getChildrenByUser(userId)) {
            result.addAll(computeForChild(child));
        }
        return result;
    }

    /** Admin view: every child in the system whose next due vaccine falls within `withinDays`. */
    public List<UpcomingVaccine> getUpcomingForAllChildren(int withinDays) throws SQLException {
        List<UpcomingVaccine> result = new ArrayList<>();
        LocalDate cutoff = LocalDate.now().plusDays(withinDays);

        // NOTE: for a small/medium project this simple per-child loop is fine.
        // (For very large datasets you'd push this filtering into a single SQL query.)
        java.sql.Connection conn = null;
        try {
            conn = com.cvt.util.DBConnection.getConnection();
            java.sql.PreparedStatement ps = conn.prepareStatement("SELECT * FROM children");
            java.sql.ResultSet rs = ps.executeQuery();
            List<Child> allChildren = new ArrayList<>();
            while (rs.next()) {
                Child c = new Child();
                c.setChildId(rs.getInt("child_id"));
                c.setUserId(rs.getInt("user_id"));
                c.setChildName(rs.getString("child_name"));
                c.setDob(rs.getDate("dob"));
                c.setGender(rs.getString("gender"));
                allChildren.add(c);
            }
            for (Child child : allChildren) {
                for (UpcomingVaccine uv : computeForChild(child)) {
                    if (!uv.getDueDate().isAfter(cutoff)) {
                        result.add(uv);
                    }
                }
            }
        } finally {
            if (conn != null) conn.close();
        }
        return result;
    }

    private List<UpcomingVaccine> computeForChild(Child child) throws SQLException {
        List<UpcomingVaccine> result = new ArrayList<>();
        List<Vaccine> allVaccines = vaccineDAO.getAllVaccines();
        LocalDate dob = child.getDob().toLocalDate();

        for (Vaccine v : allVaccines) {
            boolean given = logDAO.alreadyLogged(child.getChildId(), v.getVaccineId());
            if (given) continue;

            LocalDate dueDate = dob.plusDays(v.getRecommendedAgeDays());
            UpcomingVaccine uv = new UpcomingVaccine(
                    child.getChildId(), child.getChildName(),
                    v.getVaccineId(), v.getVaccineName(), dueDate);
            result.add(uv);
        }
        // soonest due date first
        result.sort((a, b) -> a.getDueDate().compareTo(b.getDueDate()));
        return result;
    }
}
