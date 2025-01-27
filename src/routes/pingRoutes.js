import {
  routes, featureLevel, get, publicGet,
} from './utils';
import { Right } from '../auth';
import { messageResponse } from '../utils';

/**
   * Token/Health Check endpoints
 * */
export default () => {
  publicGet(
    featureLevel.production,
    routes.HEALTH_CHECK,
    async () => messageResponse('ok'),
  );

  get(
    featureLevel.production,
    Right.general.PING,
    routes.PING,
    async () => messageResponse('ok'),
  );
};
