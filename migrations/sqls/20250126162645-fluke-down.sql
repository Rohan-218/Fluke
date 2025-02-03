-- Drop Triggers
DROP TRIGGER IF EXISTS trg_users_updated_on ON users;
DROP TRIGGER IF EXISTS trg_roles_updated_on ON roles;
DROP TRIGGER IF EXISTS trg_user_roles_updated_on ON user_roles;
DROP TRIGGER IF EXISTS trg_airport_updated_on ON airport;
DROP TRIGGER IF EXISTS trg_airline_updated_on ON airline;
DROP TRIGGER IF EXISTS trg_flight_updated_on ON flight;
DROP TRIGGER IF EXISTS trg_route_updated_on ON route;
DROP TRIGGER IF EXISTS trg_staff_updated_on ON staff;
DROP TRIGGER IF EXISTS trg_route_staff_updated_on ON route_staff;
DROP TRIGGER IF EXISTS trg_booking_updated_on ON booking;
DROP TRIGGER IF EXISTS trg_passenger_updated_on ON passenger;
DROP TRIGGER IF EXISTS trg_user_booking_updated_on ON user_booking;
DROP TRIGGER IF EXISTS trg_user_details_updated_on ON user_details;

-- Drop Function
DROP FUNCTION IF EXISTS set_updated_on;

-- Drop Tables
DROP TABLE IF EXISTS user_login_history;
DROP TABLE IF EXISTS user_login_details;
DROP TABLE IF EXISTS user_booking;
DROP TABLE IF EXISTS user_roles;
DROP TABLE IF EXISTS user_details;
DROP TABLE IF EXISTS passenger;
DROP TABLE IF EXISTS booking;
DROP TABLE IF EXISTS route_staff;
DROP TABLE IF EXISTS route;
DROP TABLE IF EXISTS flight;
DROP TABLE IF EXISTS airline;
DROP TABLE IF EXISTS airport;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS users;

-- Drop Types
DROP TYPE IF EXISTS status_enum;
DROP TYPE IF EXISTS staff_status_enum;
DROP TYPE IF EXISTS booking_status;