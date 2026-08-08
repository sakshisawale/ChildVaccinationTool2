package com.cvt.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Wraps BCrypt so passwords are NEVER stored or compared as plain text.
 */
public class PasswordUtil {

    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(10));
    }

    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) return false;
        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (IllegalArgumentException e) {
            // hashedPassword was not a valid bcrypt hash
            return false;
        }
    }
}
