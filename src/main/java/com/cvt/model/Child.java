package com.cvt.model;

import java.sql.Date;

public class Child {
    private int childId;
    private int userId;
    private String childName;
    private Date dob;
    private String gender;

    public Child() {}

    public int getChildId() { return childId; }
    public void setChildId(int childId) { this.childId = childId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getChildName() { return childName; }
    public void setChildName(String childName) { this.childName = childName; }

    public Date getDob() { return dob; }
    public void setDob(Date dob) { this.dob = dob; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
}
