import cors from "cors";
import dotenv from "dotenv";
import express, { json } from "express";

import { errorHandler, securityHandler } from "@/middlewares";
import { authRouter, goalListRouter, goalRouter, labelRouter, swaggerRouter, transactionListRouter, transactionRouter } from "@/routes";

import { walletRouter } from "./routes/wallet-routes";

dotenv.config();

export const server = async () => {
  try {
    const PORT = process.env.PORT || 8080;

    const app = express();
    app.use(json());
    app.use(cors());
    app.use((req, res, next) => {
      res.setHeader("Cross-Origin-Opener-Policy", "same-origin-allow-popups");
      next();
    });
    app.get("/health", (req, res) => {
      res.status(200).json({ status: "ok" });
    });

    app.use("/auth", authRouter);

    app.use("/account/:accountId/wallet/:walletId/transaction", securityHandler, transactionRouter);
    app.use("/account/:accountId/transaction", securityHandler, transactionListRouter);

    app.use("/account/:accountId/label", securityHandler, labelRouter);
    app.use("/account/:accountId/wallet", securityHandler, walletRouter);
    app.use("/account/:accountId/wallet/:walletId/goal", securityHandler, goalRouter);
    app.use("/account/:accountId/goal", securityHandler, goalListRouter);
    app.use("/", swaggerRouter);

    app.listen(PORT, () => {
      console.log(`Server running on port ${PORT}`);
    });

    app.use(errorHandler);
  } catch (err) {
    console.log(err);
  }
};
