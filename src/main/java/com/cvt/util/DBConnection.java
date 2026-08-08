package com.cvt.util;

import java.net.URI;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Central place that opens a JDBC connection to PostgreSQL.
 *
 * Reads config from environment variables so the SAME code works:
 *  - on your local machine (VS Code)
 *  - when deployed to Render (which gives you one connection string)
 *
 * Two ways to configure it (checked in this order):
 *
 * 1) DATABASE_URL - a single connection string, e.g. the "External
 *    Database URL" Render shows you for a PostgreSQL instance:
 *      postgres://user:password@host:5432/dbname
 *    Just set ONE env var called DATABASE_URL to that value and
 *    everything else is parsed out of it automatically.
 *
 * 2) Individual variables (used if DATABASE_URL is not set) - handy
 *    for local development where you don't want to build a URL by hand:
 *      DB_HOST      (default: localhost)
 *      DB_PORT      (default: 5432)
 *      DB_NAME      (default: child_vaccination_db)
 *      DB_USER      (default: postgres)
 *      DB_PASSWORD  (default: "" empty)
 */
public class DBConnection {

    private static String env(String key, String defaultValue) {
        String value = System.getenv(key);
        return (value == null || value.isEmpty()) ? defaultValue : value;
    }

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("PostgreSQL JDBC driver not found on classpath", e);
        }

        String databaseUrl = System.getenv("DATABASE_URL");

        if (databaseUrl != null && !databaseUrl.isEmpty()) {
            return connectUsingDatabaseUrl(databaseUrl);
        }

        String host = env("DB_HOST", "localhost");
        String port = env("DB_PORT", "5432");
        String dbName = env("DB_NAME", "child_vaccination_db");
        String user = env("DB_USER", "postgres");
        String password = env("DB_PASSWORD", "");

        String url = "jdbc:postgresql://" + host + ":" + port + "/" + dbName
                + "?sslmode=prefer";

        return DriverManager.getConnection(url, user, password);
    }

    /**
     * Parses a Render/Railway/Heroku-style connection string like:
     *   postgres://user:password@host:5432/dbname
     * into the pieces JDBC needs, and connects with SSL required
     * (Render's external Postgres endpoint requires SSL).
     */
    private static Connection connectUsingDatabaseUrl(String databaseUrl) throws SQLException {
        try {
            // JDBC needs "postgresql://" not "postgres://"
            String normalized = databaseUrl.replaceFirst("^postgres://", "postgresql://");
            URI uri = new URI(normalized);

            String userInfo = uri.getUserInfo(); // "user:password"
            String user = null;
            String password = null;
            if (userInfo != null) {
                String[] parts = userInfo.split(":", 2);
                user = parts[0];
                password = parts.length > 1 ? parts[1] : "";
            }

            String host = uri.getHost();
            int port = uri.getPort() == -1 ? 5432 : uri.getPort();
            String dbName = uri.getPath() != null && uri.getPath().startsWith("/")
                    ? uri.getPath().substring(1) : uri.getPath();

            String jdbcUrl = "jdbc:postgresql://" + host + ":" + port + "/" + dbName
                    + "?sslmode=require";

            return DriverManager.getConnection(jdbcUrl, user, password);
        } catch (Exception e) {
            throw new SQLException("Could not parse DATABASE_URL: " + e.getMessage(), e);
        }
    }
}
