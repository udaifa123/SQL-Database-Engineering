import { Request, Response, NextFunction } from "express";
import { pool } from "../config/db";
import { validateUser } from "../utils/validate";

// ========================================
// GET ALL USERS
// GET /users
// ========================================

export const getUsers = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const result = await pool.query(`
      SELECT
        id,
        name,
        email,
        created_at
      FROM users
      ORDER BY id ASC
    `);

    res.status(200).json({
      success: true,
      count: result.rows.length,
      users: result.rows,
    });
  } catch (error) {
    next(error);
  }
};

// ========================================
// GET USER BY ID
// GET /users/:id
// ========================================

export const getUserById = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const { id } = req.params;

    const result = await pool.query(
      `
      SELECT
        id,
        name,
        email,
        created_at
      FROM users
      WHERE id = $1
      `,
      [id]
    );

    if (result.rows.length === 0) {
      res.status(404).json({
        success: false,
        message: "User not found",
      });

      return;
    }

    res.status(200).json({
      success: true,
      user: result.rows[0],
    });
  } catch (error) {
    next(error);
  }
};

// ========================================
// CREATE USER
// POST /users
// ========================================

export const createUser = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const { name, email } = req.body;

    // Validation
    const validationError = validateUser(name, email);

    if (validationError) {
      res.status(400).json({
        success: false,
        message: validationError,
      });

      return;
    }

    const result = await pool.query(
      `
      INSERT INTO users (name, email)
      VALUES ($1, $2)
      RETURNING id, name, email, created_at
      `,
      [name.trim(), email.trim().toLowerCase()]
    );

    res.status(201).json({
      success: true,
      message: "User created successfully",
      user: result.rows[0],
    });
  } catch (error: any) {
    // PostgreSQL UNIQUE constraint error
    if (error.code === "23505") {
      res.status(409).json({
        success: false,
        message: "Email already exists",
      });

      return;
    }

    next(error);
  }
};

// ========================================
// UPDATE USER
// PUT /users/:id
// ========================================

export const updateUser = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const { id } = req.params;
    const { name, email } = req.body;

    // Validation
    const validationError = validateUser(name, email);

    if (validationError) {
      res.status(400).json({
        success: false,
        message: validationError,
      });

      return;
    }

    const result = await pool.query(
      `
      UPDATE users
      SET
        name = $1,
        email = $2
      WHERE id = $3
      RETURNING id, name, email, created_at
      `,
      [name.trim(), email.trim().toLowerCase(), id]
    );

    if (result.rows.length === 0) {
      res.status(404).json({
        success: false,
        message: "User not found",
      });

      return;
    }

    res.status(200).json({
      success: true,
      message: "User updated successfully",
      user: result.rows[0],
    });
  } catch (error: any) {
    if (error.code === "23505") {
      res.status(409).json({
        success: false,
        message: "Email already exists",
      });

      return;
    }

    next(error);
  }
};

// ========================================
// DELETE USER
// DELETE /users/:id
// ========================================

export const deleteUser = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const { id } = req.params;

    const result = await pool.query(
      `
      DELETE FROM users
      WHERE id = $1
      RETURNING id, name, email
      `,
      [id]
    );

    if (result.rows.length === 0) {
      res.status(404).json({
        success: false,
        message: "User not found",
      });

      return;
    }

    res.status(200).json({
      success: true,
      message: "User deleted successfully",
      user: result.rows[0],
    });
  } catch (error) {
    next(error);
  }
};