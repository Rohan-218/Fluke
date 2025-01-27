import Right from './right';
import { HttpException, formatErrorResponse } from '../utils';

class Role {
  roles = Object.freeze([
    'USER',
    'NO_RIGHTS',
    'ADMIN',
    'SUPER_ADMIN', // Replaced CLIENT with SUPER_ADMIN
  ]);

  static roleValues = Object.freeze({
    USER: 'USER',
    ADMIN: 'ADMIN',
    SUPER_ADMIN: 'SUPER_ADMIN', // Included SUPER_ADMIN
  });

  roleIds = Object.freeze({
    USER: 1,
    ADMIN: 1,
    SUPER_ADMIN: 3, // Added roleId for SUPER_ADMIN
  });

  USER = Right.userRights();

  ADMIN = [].concat(
    Right.userRights(), // General rights
    Right.adminRights() // Quotes-specific rights
  );

  SUPER_ADMIN = [].concat(
    Right.userRights(), // General rights
    Right.adminRights(), // Admin rights
    Right.superAdminRights() // Add rights specific to SUPER_ADMIN (assuming this is defined)
  );

  NO_RIGHTS = [];

  /**
   * @type {string[]}
   */
  rights;

  /**
   * @type {string}
   */
  role;

  constructor(role) {
    if (this.roles.indexOf(role) === -1) {
      throw new HttpException.BadRequest(formatErrorResponse('role', 'notFound'));
    }
    this.role = role;
    this.rights = this[role];
  }

  /**
   * Checks if the user has the right
   * @param {string} right
   * @returns {boolean}
   */
  hasRight(right) {
    return (this.rights && this.rights.indexOf(right) !== -1);
  }

  /**
   * Gets the rights available for this role
   * @returns {string[]}
   */
  getRights() {
    return this.rights;
  }

  /**
   * Gets the role id based on the role
   * @returns {number}
   */
  getId() {
    return this.roleIds[this.role] || 0;
  }

  /**
   * Gets the name of the role
   * @returns {string}
   */
  getRoleName() {
    return this.role;
  }
}

export default Role;
