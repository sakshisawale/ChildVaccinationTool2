package com.cvt.dao;

import com.cvt.model.Child;
import com.cvt.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ChildDAO {

    public void addChild(Child child) throws SQLException {
        String sql = "INSERT INTO children (user_id, child_name, dob, gender) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, child.getUserId());
            ps.setString(2, child.getChildName());
            ps.setDate(3, child.getDob());
            ps.setString(4, child.getGender());
            ps.executeUpdate();
        }
    }

    public List<Child> getChildrenByUser(int userId) throws SQLException {
        List<Child> list = new ArrayList<>();
        String sql = "SELECT * FROM children WHERE user_id = ? ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    public Child getChildById(int childId) throws SQLException {
        String sql = "SELECT * FROM children WHERE child_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, childId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    /** Ownership check: does this child belong to this user? Used before any
     *  update/view so one user can never see or log another user's child. */
    public boolean belongsToUser(int childId, int userId) throws SQLException {
        String sql = "SELECT 1 FROM children WHERE child_id = ? AND user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, childId);
            ps.setInt(2, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    private Child mapRow(ResultSet rs) throws SQLException {
        Child c = new Child();
        c.setChildId(rs.getInt("child_id"));
        c.setUserId(rs.getInt("user_id"));
        c.setChildName(rs.getString("child_name"));
        c.setDob(rs.getDate("dob"));
        c.setGender(rs.getString("gender"));
        return c;
    }
}
