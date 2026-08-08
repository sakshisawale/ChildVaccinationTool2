package com.cvt.util;

import java.time.LocalDate;
import java.util.regex.Pattern;

/**
 * All server-side input validation lives here so every servlet
 * validates data the SAME way (never trust the client alone).
 */
public class ValidationUtil {

    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[\\w.+-]+@[\\w-]+\\.[a-zA-Z]{2,}$");

    // 10 digit Indian mobile number, optionally with +91
    private static final Pattern PHONE_PATTERN =
            Pattern.compile("^(\\+91[- ]?)?[6-9]\\d{9}$");

    // At least 8 chars, 1 letter, 1 number
    private static final Pattern PASSWORD_PATTERN =
            Pattern.compile("^(?=.*[A-Za-z])(?=.*\\d).{8,}$");

    public static boolean isNotEmpty(String value) {
        return value != null && !value.trim().isEmpty();
    }

    public static boolean isValidEmail(String email) {
        return isNotEmpty(email) && EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    public static boolean isValidPhone(String phone) {
        return isNotEmpty(phone) && PHONE_PATTERN.matcher(phone.trim()).matches();
    }

    public static boolean isValidPassword(String password) {
        return isNotEmpty(password) && PASSWORD_PATTERN.matcher(password).matches();
    }

    public static boolean isValidDateOfBirth(String dobStr) {
        if (!isNotEmpty(dobStr)) return false;
        try {
            LocalDate dob = LocalDate.parse(dobStr);
            LocalDate today = LocalDate.now();
            // must not be in the future, and not more than 18 years old
            return !dob.isAfter(today) && !dob.isBefore(today.minusYears(18));
        } catch (Exception e) {
            return false;
        }
    }

    public static boolean isValidGender(String gender) {
        return "Male".equals(gender) || "Female".equals(gender) || "Other".equals(gender);
    }

    public static boolean isPositiveNumber(String value) {
        if (!isNotEmpty(value)) return false;
        try {
            double d = Double.parseDouble(value);
            return d >= 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    public static boolean isValidInt(String value) {
        if (!isNotEmpty(value)) return false;
        try {
            Integer.parseInt(value);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    public static boolean isValidPastOrTodayDate(String dateStr) {
        if (!isNotEmpty(dateStr)) return false;
        try {
            LocalDate d = LocalDate.parse(dateStr);
            return !d.isAfter(LocalDate.now());
        } catch (Exception e) {
            return false;
        }
    }
}
