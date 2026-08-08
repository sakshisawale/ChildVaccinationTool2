package com.cvt.dao;

import com.cvt.model.Vaccine;
import com.cvt.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VaccineDAO {

    public void addVaccine(Vaccine v) throws SQLException {
        String sql = "INSERT INTO vaccines (vaccine_name, description, recommended_age_days, dose_number, price) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, v.getVaccineName());
            ps.setString(2, v.getDescription());
            ps.setInt(3, v.getRecommendedAgeDays());
            ps.setInt(4, v.getDoseNumber());
            ps.setBigDecimal(5, v.getPrice());
            ps.executeUpdate();
        }
    }

    public List<Vaccine> getAllVaccines() throws SQLException {
        List<Vaccine> list = new ArrayList<>();
        String sql = "SELECT * FROM vaccines ORDER BY recommended_age_days ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    public Vaccine getVaccineById(int id) throws SQLException {
        String sql = "SELECT * FROM vaccines WHERE vaccine_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public void deleteVaccine(int id) throws SQLException {
        String sql = "DELETE FROM vaccines WHERE vaccine_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public void updatePrice(int id, java.math.BigDecimal newPrice) throws SQLException {
        String sql = "UPDATE vaccines SET price = ? WHERE vaccine_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBigDecimal(1, newPrice);
            ps.setInt(2, id);
            ps.executeUpdate();
        }
    }

    private Vaccine mapRow(ResultSet rs) throws SQLException {
        Vaccine v = new Vaccine();
        v.setVaccineId(rs.getInt("vaccine_id"));
        v.setVaccineName(rs.getString("vaccine_name"));
        v.setDescription(rs.getString("description"));
        v.setRecommendedAgeDays(rs.getInt("recommended_age_days"));
        v.setDoseNumber(rs.getInt("dose_number"));
        v.setPrice(rs.getBigDecimal("price"));
        return v;
    }
}
