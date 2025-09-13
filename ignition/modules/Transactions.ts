import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const TransactionsModule = buildModule("TransactionsModule", (m) => {
  // Deploy the Transactions contract (no constructor args)
  const transactions = m.contract("Transactions");

  return { transactions };
});

export default TransactionsModule;
