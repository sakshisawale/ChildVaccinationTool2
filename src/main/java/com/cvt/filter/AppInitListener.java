package com.cvt.filter;

import com.cvt.dao.AdminDAO;
import com.cvt.util.PasswordUtil;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.SQLException;

/**
 * Runs once when the app starts on the server.
 * If there is no admin account yet, it creates the default one:
 *   username: admin
 *   password: Admin@123
 * with a properly BCrypt-hashed password (never plain text in the DB).
 * CHANGE THIS PASSWORD after your first login via "Change Password".
 */
@WebListener
public class AppInitListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            AdminDAO adminDAO = new AdminDAO();
            if (!adminDAO.anyAdminExists()) {
                String hashed = PasswordUtil.hashPassword("Admin@123");
                adminDAO.insertAdmin("admin", hashed, "admin@childvax.com");
                System.out.println("[ChildVaccinationTool] Default admin created -> username: admin / password: Admin@123");
            }
        } catch (SQLException e) {
            System.err.println("[ChildVaccinationTool] Could not verify/create default admin. "
                    + "Check your DB connection (DB_HOST/DB_USER/DB_PASSWORD env vars). " + e.getMessage());
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // nothing to clean up
    }
}
