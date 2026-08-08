package com.cvt.model;

import java.sql.Date;

public class VaccineLog {
    private int logId;
    private int childId;
    private int vaccineId;
    private Date dateGiven;
    private String notes;

    // extra display-only fields populated by joined queries
    private String childName;
    private String vaccineName;

    public VaccineLog() {}

    public int getLogId() { return logId; }
    public void setLogId(int logId) { this.logId = logId; }

    public int getChildId() { return childId; }
    public void setChildId(int childId) { this.childId = childId; }

    public int getVaccineId() { return vaccineId; }
    public void setVaccineId(int vaccineId) { this.vaccineId = vaccineId; }

    public Date getDateGiven() { return dateGiven; }
    public void setDateGiven(Date dateGiven) { this.dateGiven = dateGiven; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public String getChildName() { return childName; }
    public void setChildName(String childName) { this.childName = childName; }

    public String getVaccineName() { return vaccineName; }
    public void setVaccineName(String vaccineName) { this.vaccineName = vaccineName; }
}
