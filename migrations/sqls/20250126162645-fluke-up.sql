CREATE TYPE status_enum AS ENUM ('Active', 'Inactive');

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(60) NOT NULL,
    status status_enum NOT NULL,
    created_by INT NOT NULL,
    created_on TIMESTAMP NOT NULL,
    updated_by INT NOT NULL,
    updated_on TIMESTAMP NOT NULL
);

CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    code INT NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    status status_enum NOT NULL,
    created_by INT NOT NULL,
    created_on TIMESTAMP NOT NULL,
    updated_by INT NOT NULL,
    updated_on TIMESTAMP NOT NULL
);

CREATE TABLE user_roles (
    user_id INT NOT NULL,
    role_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (role_id) REFERENCES roles(id),
    PRIMARY KEY (user_id, role_id)
);

CREATE TABLE airport (
    id SERIAL PRIMARY KEY,
    code VARCHAR NOT NULL UNIQUE,
    name VARCHAR NOT NULL UNIQUE,
    latitude DECIMAL NOT NULL,
    longitude DECIMAL NOT NULL,
    city VARCHAR NOT NULL,
    state VARCHAR NOT NULL,
    country VARCHAR NOT NULL,
    capacity SMALLINT NOT NULL,
    status VARCHAR CHECK (status IN ('active', 'inactive')) NOT NULL,
    created_by INT NOT NULL,
    created_on TIMESTAMP NOT NULL,
    updated_by INT NOT NULL,
    updated_on TIMESTAMP NOT NULL
);

CREATE TABLE airline (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR NOT NULL UNIQUE,
    flight_owned SMALLINT NOT NULL,
    status VARCHAR CHECK (status IN ('active', 'inactive', 'suspended')) NOT NULL,
    created_by INT NOT NULL,
    created_on TIMESTAMP NOT NULL,
    updated_by INT NOT NULL,
    updated_on TIMESTAMP NOT NULL
);

CREATE TABLE flight (
    id SERIAL PRIMARY KEY,
    flight_no VARCHAR NOT NULL UNIQUE,
    airline_id INT NOT NULL,
    base_airport_id INT NOT NULL,
    status VARCHAR CHECK (status IN ('active', 'inactive', 'cancelled')) NOT NULL,
    created_by INT NOT NULL,
    created_on TIMESTAMP NOT NULL,
    updated_by INT NOT NULL,
    updated_on TIMESTAMP NOT NULL,
    CONSTRAINT fk_airline FOREIGN KEY (airline_id) REFERENCES airline(id),
    CONSTRAINT fk_base_airport FOREIGN KEY (base_airport_id) REFERENCES airport(id)
);

CREATE TABLE route (
    id SERIAL PRIMARY KEY,
    takeoff_airport_id INT NOT NULL,
    landing_airport_id INT NOT NULL,
    flight_id INT NOT NULL,
    total_seats SMALLINT NOT NULL,
    seats_available SMALLINT NOT NULL,
    departure TIMESTAMP NOT NULL,
    arrival TIMESTAMP NOT NULL,
    price INT NOT NULL,
    status VARCHAR CHECK (status IN ('scheduled', 'delayed', 'canceled', 'completed')) NOT NULL,
    created_by INT NOT NULL,
    created_on TIMESTAMP NOT NULL,
    updated_by INT NOT NULL,
    updated_on TIMESTAMP NOT NULL,
    CONSTRAINT fk_takeoff_airport FOREIGN KEY (takeoff_airport_id) REFERENCES airport(id),
    CONSTRAINT fk_landing_airport FOREIGN KEY (landing_airport_id) REFERENCES airport(id),
    CONSTRAINT fk_flight FOREIGN KEY (flight_id) REFERENCES flight(id)
);

CREATE TYPE staff_status_enum AS ENUM ('active', 'inactive', 'on-leave');

CREATE TABLE staff (
    id SERIAL PRIMARY KEY,
    staff_no INT UNIQUE NOT NULL,
    email VARCHAR UNIQUE NOT NULL,
    name CHAR(50) NOT NULL,
    phone_no BIGINT NOT NULL,
    address TEXT NOT NULL,
    sex VARCHAR CHECK (sex IN ('male', 'female', 'other')) NOT NULL,
    birthdate DATE NOT NULL,
    role VARCHAR CHECK (role IN ('manager', 'pilot', 'crew', 'admin', 'maintenance')) NOT NULL,
    age SMALLINT NOT NULL,
    salary INT NOT NULL,
    status staff_status_enum NOT NULL,
    created_by INT NOT NULL,
    created_on TIMESTAMP NOT NULL,
    updated_by INT NOT NULL,
    updated_on TIMESTAMP NOT NULL
);

CREATE TABLE route_staff (
    staff_id INT NOT NULL,
    assigned_route_id INT NOT NULL,
    PRIMARY KEY (staff_id, assigned_route_id),
    CONSTRAINT fk_staff FOREIGN KEY (staff_id) REFERENCES staff (id) ON DELETE CASCADE,
    CONSTRAINT fk_route FOREIGN KEY (assigned_route_id) REFERENCES route (id) ON DELETE CASCADE
);

CREATE TYPE booking_status AS ENUM ('Pending', 'Confirmed', 'Cancelled', 'Completed');

CREATE TABLE booking (
    id SERIAL PRIMARY KEY,
    route_id INT NOT NULL,
    seats_booked SMALLINT NOT NULL,
    status booking_status NOT NULL,
    total_price INT NOT NULL,
    created_on TIMESTAMP NOT NULL,
    updated_on TIMESTAMP NOT NULL,
    created_by INT NOT NULL,
    updated_by INT NOT NULL,
    CONSTRAINT fk_route FOREIGN KEY (route_id) REFERENCES route (id) ON DELETE CASCADE
);

CREATE TABLE passenger (
    id SERIAL PRIMARY KEY,
    booking_id INT NOT NULL,
    passport_no VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    sex VARCHAR(10) NOT NULL, 
    age SMALLINT NOT NULL,
    phone_no BIGINT NOT NULL,
    nationality VARCHAR(100) NOT NULL,
    status VARCHAR(50) NOT NULL,
    created_by INT NOT NULL,
    created_on TIMESTAMP NOT NULL,
    updated_by INT NOT NULL,
    updated_on TIMESTAMP NOT NULL,
    CONSTRAINT fk_booking FOREIGN KEY (booking_id) REFERENCES booking (id) ON DELETE CASCADE
);

CREATE TABLE user_booking (
    booking_id INT NOT NULL,
    user_id INT NOT NULL,
    PRIMARY KEY (booking_id, user_id),
    FOREIGN KEY (booking_id) REFERENCES booking(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE user_details (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    passport_no VARCHAR(255) UNIQUE,
    name VARCHAR(255) NOT NULL,
    phone_no BIGINT NOT NULL,
    sex VARCHAR CHECK (sex IN ('Male', 'Female', 'Other')) NOT NULL,
    birthdate DATE NOT NULL,
    age SMALLINT NOT NULL,
    nationality VARCHAR(255) NOT NULL,
    status status_enum NOT NULL,
    created_by INT NOT NULL,
    created_on TIMESTAMP NOT NULL,
    updated_by INT NOT NULL,
    updated_on TIMESTAMP NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE OR REPLACE FUNCTION set_updated_on()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_on = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_users_updated_on BEFORE UPDATE ON users FOR EACH ROW EXECUTE FUNCTION set_updated_on();

CREATE TRIGGER trg_roles_updated_on BEFORE UPDATE ON roles FOR EACH ROW EXECUTE FUNCTION set_updated_on();

CREATE TRIGGER trg_user_roles_updated_on BEFORE UPDATE ON user_roles FOR EACH ROW EXECUTE FUNCTION set_updated_on();

CREATE TRIGGER trg_airport_updated_on BEFORE UPDATE ON airport FOR EACH ROW EXECUTE FUNCTION set_updated_on();

CREATE TRIGGER trg_airline_updated_on BEFORE UPDATE ON airline FOR EACH ROW EXECUTE FUNCTION set_updated_on();

CREATE TRIGGER trg_flight_updated_on BEFORE UPDATE ON flight FOR EACH ROW EXECUTE FUNCTION set_updated_on();

CREATE TRIGGER trg_route_updated_on BEFORE UPDATE ON route FOR EACH ROW EXECUTE FUNCTION set_updated_on();

CREATE TRIGGER trg_staff_updated_on BEFORE UPDATE ON staff FOR EACH ROW EXECUTE FUNCTION set_updated_on();

CREATE TRIGGER trg_route_staff_updated_on BEFORE UPDATE ON route_staff FOR EACH ROW EXECUTE FUNCTION set_updated_on();

CREATE TRIGGER trg_booking_updated_on BEFORE UPDATE ON booking FOR EACH ROW EXECUTE FUNCTION set_updated_on();

CREATE TRIGGER trg_passenger_updated_on BEFORE UPDATE ON passenger FOR EACH ROW EXECUTE FUNCTION set_updated_on();

CREATE TRIGGER trg_user_booking_updated_on BEFORE UPDATE ON user_booking FOR EACH ROW EXECUTE FUNCTION set_updated_on();

CREATE TRIGGER trg_user_details_updated_on BEFORE UPDATE ON user_details FOR EACH ROW EXECUTE FUNCTION set_updated_on();
