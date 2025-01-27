const API_ROOT = '/api';
const USER_ROOT = `${API_ROOT}/user`;

export default Object.freeze({
  ping: `${API_ROOT}/ping`,
  healthCheck: `${API_ROOT}/health-check`,
  quotes: `${API_ROOT}/quotes`,
  auth_quotes: `${API_ROOT}/auth_quotes`,
  security: {
    SIGN_UP: `${API_ROOT}/signup`,
    LOGIN: `${API_ROOT}/login`,
  },
  user: {
    PROFILE: `${USER_ROOT}/profile`,
    CHANGE_PASSWORD: `${USER_ROOT}/change-password`,
    FORGOT_PASSWORD: `${USER_ROOT}/forgot-password`,
  },
  test: {
    TEST_ACTION: `${API_ROOT}/test/`,
  },
});
