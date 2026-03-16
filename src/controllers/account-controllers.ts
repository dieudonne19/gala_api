import { RequestHandler } from "express";
import { v4 } from "uuid";
import { OAuth2Client } from 'google-auth-library';

import { AccountServices } from "@/services";
import { getPrismaClient } from "@/configs";
import { errorWrapper } from "@/utilities";
import { AccountValidator } from "@/validator";
import { ApiError } from "@/errors";

const googleClient = new OAuth2Client(process.env.GOOGLE_CLIENT_ID);

export class AccountController {
  static readonly signIn: RequestHandler = async (req, res, next) => {
    try {
      const { username, password } = req.body;
      AccountValidator.create({ username, password });
      const data = await AccountServices.signIn(username, password);
      res.json(data);
    } catch (err) {
      next(err);
    }
  };

  static readonly signUp: RequestHandler = async (req, res, next) => {
    try {
      const account = req.body;
      console.log('SignUp Request Body:', account);
      AccountValidator.create(account);
      const createdUser = await AccountServices.signUp(v4(), account);
      res.json(createdUser);
    } catch (err) {
      console.error('SignUp Error:', err);
      next(err);
    }
  };

  static readonly signInWithGoogle: RequestHandler = async (req, res, next) => {
    try {
      const { idToken } = req.body;

      if (!idToken) {
        throw new ApiError('idToken is required', 400);
      }

      const ticket = await googleClient.verifyIdToken({
        idToken: idToken,
        audience: process.env.GOOGLE_CLIENT_ID,
      });

      const payload = ticket.getPayload();
      if (!payload || !payload.email) {
        throw new ApiError('Invalid Google token', 401);
      }

      const { email, sub: googleId, name } = payload;

      let account = await AccountServices.findByGoogleId(googleId);

      if (!account) {
        account = await AccountServices.findByEmail(email);
      }

      if (!account) {
        account = await AccountServices.createGoogleUser({
          id: v4(),
          username: email,
          googleId: googleId,
          name: name || email,
        });
      } else if (!account.googleId) {
        account = await getPrismaClient().account.update({
          where: { id: account.id },
          data: { googleId: googleId }
        });
      }
      const token = AccountServices.generateToken(account);

      account.password = undefined;
      res.json({
        token: token,
        account: account
      });

    } catch (err) {
      console.error('Google Auth Error:', err);
      next(err);
    }
  };
}