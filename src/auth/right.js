/**
 * Rights are the lowest abstraction level items in the authorization system.
 * The decision if user has access to some
 * feature or not is ultimately decided on the fact if that specific user
 * has the required. Rights are
 * never added to database in any form: they are aggregated via Roles.
 * This allows flexible tuning and
 * changing of Right items during development:
 * if you find a specific use case where current Rights
 * options are not fitting then add a new one. Just remember to
 * add that Right to appropriate Roles.
 */
class Right {
  static general = Object.freeze({
    /* General Rights */
    PING: 'PING',
    TEST_API: 'TEST_API',
    VIEW_ROUTES: 'VIEW_ROUTES',
  });

  static user = Object.freeze({
    /* User Rights */
    UPDATE_PROFILE: 'UPDATE_PROFILE',
    VIEW_PROFILE: 'VIEW_PROFILE',
    CHANGE_PASSWORD: 'CHANGE_PASSWORD',
    BOOKING: 'BOOKING',
    VIEW_BOOKING: 'VIEW_BOOKING',
    UPDATE_BOOKING: 'UPDATE_BOOKING',
    UPDATE_BOOKING_PASSENGER: 'UPDATE_BOOKING_PASSENGER',
  });

  static admin = Object.freeze({
    /* Admin-specific Rights */
    MANAGE_USERS: 'MANAGE_USERS',
    MANAGE_ROUTES: 'MANAGE_ROUTES',
    MANAGE_FLIGHTS: 'MANAGE_FLIGHTS',
    MANAGE_AIRLINE: 'MANAGE_AIRLINE',
    MANAGE_AIRPORT: 'MANAGE_AIRPORT',
    MANAGE_BOOKING: 'MANAGE_BOOKING',
    MANAGE_STAFF: 'MANAGE_STAFF',
  });

  static superAdmin = Object.freeze({
    /* Super Admin-specific Rights */
    MANAGE_ROLES: 'MANAGE_ROLES',
    VIEW_ALL_DATA: 'VIEW_ALL_DATA',
    DELETE_ANY_USER: 'DELETE_ANY_USER',
    FULL_ACCESS: 'FULL_ACCESS',
  });

  // helper methods

  /**
   * @returns {string[]}
   */
  static userRights() {
    return [].concat(
      Right.getRightArray(this.general),
      Right.getRightArray(this.user),
    );
  }

  /**
   * @returns {string[]}
   */
  static adminRights() {
    return [].concat(
      Right.getRightArray(this.general),
      Right.getRightArray(this.user),
      Right.getRightArray(this.admin),
    );
  }

  /**
   * @returns {string[]}
   */
  static superAdminRights() {
    return [].concat(
      Right.getRightArray(this.general),
      Right.getRightArray(this.user),
      Right.getRightArray(this.admin),
      Right.getRightArray(this.superAdmin),
    );
  }

  /**
   * @param {object} rights
   * @returns {string[]}
   */
  static getRightArray(rights) {
    return Object.freeze(Object.keys(rights).map((key) => rights[key]));
  }

  /**
   * @returns {boolean}
   */
  static hasPermission(rights, val) {
    return rights.indexOf(val) !== -1;
  }

  /**
   * @param {string} val
   * @returns {boolean}
   */
  static exists(val) {
    const index = this.userRights().indexOf(val);
    return index !== -1;
  }
}

export default Right;
