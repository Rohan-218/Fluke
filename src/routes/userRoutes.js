import { Container } from 'typedi';
import {
  routes, featureLevel, get, put,
  publicPost,
} from './utils';
import { Right } from '../auth';
import { UserService } from '../services';
import {
  changeUserPasswordSchema,
  forgotPasswordSchema,
} from '../models';

export default () => {
  get(
    featureLevel.production,
    Right.general.VIEW_PROFILE,
    routes.USER.PROFILE,
    async (req) => {
      const service = Container.get(UserService);
      return await service.fetchUserProfile({ ...req.currentUser });
    },
  );

  put(
    featureLevel.production,
    Right.general.CHANGE_PASSWORD,
    routes.USER.CHANGE_PASSWORD,
    async (req) => {
      const service = Container.get(UserService);
      const data = await changeUserPasswordSchema.validateAsync(req.body);
      return await service.changePassword(data, { ...req.currentUser });
    },
  );

  publicPost(
    featureLevel.production,
    routes.user.FORGOT_PASSWORD,
    async (req) => {
      const service = Container.get(UserService);
      const { email } = await forgotPasswordSchema.validateAsync(req.body);
      return await service.forgetPassword(email);
    },
  );
};
