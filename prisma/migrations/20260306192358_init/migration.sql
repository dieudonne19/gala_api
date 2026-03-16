-- CreateTable
CREATE TABLE "Account" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "username" TEXT NOT NULL,
    "password" TEXT,
    "googleId" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "__role__" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT
);

-- CreateTable
CREATE TABLE "__user_role__" (
    "accountId" TEXT NOT NULL,
    "roleId" TEXT NOT NULL,

    PRIMARY KEY ("accountId", "roleId"),
    CONSTRAINT "__user_role___accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "__user_role___roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "__role__" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "File" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "path" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Wallet" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "description" TEXT,
    "amount" INTEGER NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" DATETIME DEFAULT CURRENT_TIMESTAMP,
    "haveAutomaticIncome" BOOLEAN DEFAULT false,
    "automaticIncomeAmount" INTEGER DEFAULT 0,
    "automaticIncomeDay" INTEGER DEFAULT 1,
    "color" TEXT NOT NULL DEFAULT '#00ff00',
    "isArchived" BOOLEAN NOT NULL DEFAULT false,
    "iconRef" TEXT,
    "accountId" TEXT NOT NULL,
    CONSTRAINT "Wallet_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Label" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "createdAt" DATETIME DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "color" TEXT NOT NULL DEFAULT '#00ff00',
    "iconRef" TEXT,
    "isArchived" BOOLEAN NOT NULL DEFAULT false,
    "accountId" TEXT NOT NULL,
    CONSTRAINT "Label_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Transaction" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "date" DATETIME NOT NULL,
    "type" TEXT NOT NULL,
    "description" TEXT,
    "amount" INTEGER NOT NULL,
    "createdAt" DATETIME DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME,
    "walletId" TEXT NOT NULL,
    "accountId" TEXT NOT NULL,
    CONSTRAINT "Transaction_walletId_fkey" FOREIGN KEY ("walletId") REFERENCES "Wallet" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "Transaction_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Goal" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "createdAt" DATETIME DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "startingDate" DATETIME NOT NULL,
    "endingDate" DATETIME NOT NULL,
    "color" TEXT NOT NULL DEFAULT '#00ff00',
    "iconRef" TEXT,
    "isArchived" BOOLEAN NOT NULL DEFAULT false,
    "amount" INTEGER NOT NULL,
    "accountId" TEXT NOT NULL,
    "walletId" TEXT,
    CONSTRAINT "Goal_walletId_fkey" FOREIGN KEY ("walletId") REFERENCES "Wallet" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "Goal_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_LabelToTransaction" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_LabelToTransaction_A_fkey" FOREIGN KEY ("A") REFERENCES "Label" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_LabelToTransaction_B_fkey" FOREIGN KEY ("B") REFERENCES "Transaction" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Account_username_key" ON "Account"("username");

-- CreateIndex
CREATE UNIQUE INDEX "Account_googleId_key" ON "Account"("googleId");

-- CreateIndex
CREATE UNIQUE INDEX "__role___name_key" ON "__role__"("name");

-- CreateIndex
CREATE UNIQUE INDEX "File_path_key" ON "File"("path");

-- CreateIndex
CREATE UNIQUE INDEX "Wallet_name_key" ON "Wallet"("name");

-- CreateIndex
CREATE UNIQUE INDEX "_LabelToTransaction_AB_unique" ON "_LabelToTransaction"("A", "B");

-- CreateIndex
CREATE INDEX "_LabelToTransaction_B_index" ON "_LabelToTransaction"("B");
