# 2FA Coding Test Mobile App

A simple mobile application for demonstrating a basic two-factor authentication (2FA) flow.

## Screens

### 1. Create User Screen
- Allows users to create a new account by providing user id, email and password.
- Creates and stores the user in supabase database and sent verification email.

### 2. Sign In Screen
- Users sign in with their email and password.
- Initiates the 2FA process by sending a verification code.

### 3. Verification Screen
- Prompts users to enter the verification code received via email.
- Completes the authentication upon successful verification.

