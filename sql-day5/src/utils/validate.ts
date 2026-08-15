export const validateUser = (
  name: unknown,
  email: unknown
): string | null => {
  if (typeof name !== "string" || name.trim() === "") {
    return "Name is required";
  }

  if (typeof email !== "string" || email.trim() === "") {
    return "Email is required";
  }

  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  if (!emailRegex.test(email.trim())) {
    return "Invalid email format";
  }

  return null;
};