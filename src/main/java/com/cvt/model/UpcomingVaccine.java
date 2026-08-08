package com.cvt.model;

import java.time.LocalDate;

/**
 * Not a DB table - this is a computed result:
 * (child + vaccine not yet logged) -> due date = child's DOB + recommended_age_days
 */
public class UpcomingVaccine {
    private int childId;
    private String childName;
    private int vaccineId;
    private String vaccineName;
    private LocalDate dueDate;
    private boolean overdue;

    public UpcomingVaccine() {}

    public UpcomingVaccine(int childId, String childName, int vaccineId, String vaccineName, LocalDate dueDate) {
        this.childId = childId;
        this.childName = childName;
        this.vaccineId = vaccineId;
        this.vaccineName = vaccineName;
        this.dueDate = dueDate;
        this.overdue = dueDate.isBefore(LocalDate.now());
    }

    public int getChildId() { return childId; }
    public void setChildId(int childId) { this.childId = childId; }

    public String getChildName() { return childName; }
    public void setChildName(String childName) { this.childName = childName; }

    public int getVaccineId() { return vaccineId; }
    public void setVaccineId(int vaccineId) { this.vaccineId = vaccineId; }

    public String getVaccineName() { return vaccineName; }
    public void setVaccineName(String vaccineName) { this.vaccineName = vaccineName; }

    public LocalDate getDueDate() { return dueDate; }
    public void setDueDate(LocalDate dueDate) { this.dueDate = dueDate; }

    public boolean isOverdue() { return overdue; }
    public void setOverdue(boolean overdue) { this.overdue = overdue; }
}
