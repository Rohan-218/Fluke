const API_ROOT = '/api';
const USER_ROOT = `${API_ROOT}/user`;
const USERS_ROOT = `${API_ROOT}/users`;
const FLIGHTS_ROOT = `${API_ROOT}/flights`;
const AIRLINE_ROOT = `${API_ROOT}/airline`;
const AIRPORT_ROOT = `${API_ROOT}/airport`;
const STAFF_ROOT = `${API_ROOT}/staff`;
const BOOKINGS_ROOT = `${API_ROOT}/bookings`;
const ROUTE_ROOT = `${API_ROOT}/route`;

export default Object.freeze({
  HEALTH_CHECK: `${API_ROOT}/health-check`,
  PING: `${API_ROOT}/ping`,
  LOGIN: `${API_ROOT}/login`,
  LOGOUT: `${API_ROOT}/logout`,
  SIGNUP: `${API_ROOT}/signup`,
  USER: {
    ROOT: `${USER_ROOT}`,
    PROFILE: `${USER_ROOT}/profile`,
    CHANGE_PASSWORD: `${USER_ROOT}/change-password`,
  },
  ROUTE: {
    ROOT: `${ROUTE_ROOT}`,
    DETAIL: `${ROUTE_ROOT}/:routeId`,
    FILTER: `${ROUTE_ROOT}/filter`,
  },
  BOOKINGS: {
    ROOT: `${BOOKINGS_ROOT}`,
    DETAIL: `${BOOKINGS_ROOT}/:bookingId`,
    PASSENGERS: `${BOOKINGS_ROOT}/:bookingId/passengers`,
    FILTER: `${BOOKINGS_ROOT}/filter`,
  },
  USERS: {
    ROOT: `${USERS_ROOT}`,
    DETAIL: `${USERS_ROOT}/:userId`,
    FILTER: `${USERS_ROOT}/filter`,
    BOOKINGS_FILTER: `${USERS_ROOT}/:userId/bookings/filter`,
  },
  FLIGHTS: {
    ROOT: `${FLIGHTS_ROOT}`,
    DETAIL: `${FLIGHTS_ROOT}/:flightId`,
    FILTER: `${FLIGHTS_ROOT}/filter`,
  },
  AIRLINE: {
    ROOT: `${AIRLINE_ROOT}`,
    DETAIL: `${AIRLINE_ROOT}/:airlineId`,
    FILTER: `${AIRLINE_ROOT}/filter`,
  },
  AIRPORT: {
    ROOT: `${AIRPORT_ROOT}`,
    DETAIL: `${AIRPORT_ROOT}/:airportId`,
    FILTER: `${AIRPORT_ROOT}/filter`,
  },
  PASSENGERS: {
    FILTER: `${API_ROOT}/passengers/filter`,
  },
  STAFF: {
    ROOT: `${STAFF_ROOT}`,
    DETAIL: `${STAFF_ROOT}/:staffId`,
    ASSIGN_ROOT: `${STAFF_ROOT}/assign-route/:routeId`,
    ASSIGN_ROOT_TO_STAFF: `${STAFF_ROOT}/:staffId/assign-route/:routeId`,
    FILTER: `${STAFF_ROOT}/filter`,
  },
  ROLES: `${API_ROOT}/roles`,
  TEST: {
    TEST_ACTION: `${API_ROOT}/test`,
  }
});
