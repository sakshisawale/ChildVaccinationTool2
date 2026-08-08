package com.cvt.model;

import java.math.BigDecimal;

public class Vaccine {
    private int vaccineId;
    private String vaccineName;
    private String description;
    private int recommendedAgeDays;
    private int doseNumber;
    private BigDecimal price;

    public Vaccine() {}

    public int getVaccineId() { return vaccineId; }
    public void setVaccineId(int vaccineId) { this.vaccineId = vaccineId; }

    public String getVaccineName() { return vaccineName; }
    public void setVaccineName(String vaccineName) { this.vaccineName = vaccineName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getRecommendedAgeDays() { return recommendedAgeDays; }
    public void setRecommendedAgeDays(int recommendedAgeDays) { this.recommendedAgeDays = recommendedAgeDays; }

    public int getDoseNumber() { return doseNumber; }
    public void setDoseNumber(int doseNumber) { this.doseNumber = doseNumber; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
}
