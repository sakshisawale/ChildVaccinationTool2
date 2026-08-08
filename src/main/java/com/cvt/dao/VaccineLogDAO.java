package com.cvt.dao;

import com.cvt.model.VaccineLog;
import com.cvt.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VaccineLogDAO {

    public void addLog(VaccineLog log) throws SQLException {
        String sql = "INSERT INTO vaccine_log (child_id, vaccine_id, date_given, notes) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, log.getChildId());
            ps.setInt(2, log.getVaccineId());
            ps.setDate(3, log.getDateGiven());
            ps.setString(4, log.getNotes());
            ps.executeUpdate();
        }
    }

    /** true if this exact child+vaccine combo was already logged (avoids duplicate doses) */
    public boolean alreadyLogged(int childId, int vaccineId) throws SQLException {
        String sql = "SELECT 1 FROM vaccine_log WHERE child_id = ? AND vaccine_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, childId);
            ps.setInt(2, vaccineId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    /** Full vaccination history for one child, newest first. */
    public List<VaccineLog> getLogsByChild(int childId) throws SQLException {
        List<VaccineLog> list = new ArrayList<>();
        String sql = "SELECT vl.*, v.vaccine_name, c.child_name " +
                     "FROM vaccine_log vl " +
                     "JOIN vaccines v ON vl.vaccine_id = v.vaccine_id " +
                     "JOIN children c ON vl.child_id = c.child_id " +
                     "WHERE vl.child_id = ? ORDER BY vl.date_given DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, childId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    /** Every logged vaccination across ALL of this user's children (for the "vaccine log" screen). */
    public List<VaccineLog> getLogsByUser(int userId) throws SQLException {
        List<VaccineLog> list = new ArrayList<>();
        String sql = "SELECT vl.*, v.vaccine_name, c.child_name " +
                     "FROM vaccine_log vl " +
                     "JOIN vaccines v ON vl.vaccine_id = v.vaccine_id " +
                     "JOIN children c ON vl.child_id = c.child_id " +
                     "WHERE c.user_id = ? ORDER BY vl.date_given DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    private VaccineLog mapRow(ResultSet rs) throws SQLException {
        VaccineLog log = new VaccineLog();
        log.setLogId(rs.getInt("log_id"));
        log.setChildId(rs.getInt("child_id"));
        log.setVaccineId(rs.getInt("vaccine_id"));
        log.setDateGiven(rs.getDate("date_given"));
        log.setNotes(rs.getString("notes"));
        log.setVaccineName(rs.getString("vaccine_name"));
        log.setChildName(rs.getString("child_name"));
        return log;
    }
}
