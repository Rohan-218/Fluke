import Joi from 'joi';
import {
  requiredStringValidator,
  requiredEmailValidator,
  requiredDateValidator,
  requiredPhoneNumberValidator,
} from '../../../utils';

export default Joi.object(((messageKey) => ({
  fullName: requiredStringValidator(messageKey, 'fullName'),
  email: requiredEmailValidator(messageKey, 'email'),
  sex: Joi.string()
    .valid('Male', 'Female', 'Other')
    .required()
    .messages({
      'any.required': `${messageKey}.sex is required`,
      'string.base': `${messageKey}.sex must be a string`,
      'any.only': `${messageKey}.sex must be one of 'Male', 'Female', or 'Other'`,
    }),
  passportNumber: requiredStringValidator(messageKey, 'passportNumber'),
  phoneNumber: requiredPhoneNumberValidator(messageKey, 'phoneNumber'),
  birthdate: requiredDateValidator(messageKey, 'birthdate', { onlyPast: true }),
  nationality: requiredStringValidator(messageKey, 'nationality'),
  password: requiredStringValidator(messageKey, 'password'),
}))('signup')).options({ stripUnknown: true });
