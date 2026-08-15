import express from "express";
import cors from "cors";
import dotenv from "dotenv";

import userRoutes from "./routes/userRoutes";
import { errorHandler } from "./middleware/errorHandler";

dotenv.config();

const app = express();

const PORT = process.env.PORT || 5000;

// ========================================
// MIDDLEWARE
// ========================================

app.use(cors());

app.use(express.json());

// ========================================
// HOME ROUTE
// ========================================

app.get("/", (req, res) => {
  res.status(200).json({
    success: true,
    message: "Day 5 PostgreSQL API is running 🚀",
  });
});

// ========================================
// USER ROUTES
// ========================================

app.use("/users", userRoutes);

// ========================================
// ERROR HANDLER
// ========================================

app.use(errorHandler);

// ========================================
// START SERVER
// ========================================

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});