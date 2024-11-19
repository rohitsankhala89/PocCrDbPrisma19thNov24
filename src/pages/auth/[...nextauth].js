import NextAuth from "next-auth";
import CredentialsProvider from "next-auth/providers/credentials";
import { PrismaAdapter } from "@next-auth/prisma-adapter";
import prisma from "../../../prisma/schema.prisma"; 

export default NextAuth({
  providers: [
    CredentialsProvider({
      name: "Credentials",
      credentials: {
        email: { label: "Email", type: "email" },
        password: { label: "Password", type: "password" },
      },
      async authorize(credentials) {
        // Validate user credentials (email and password) from your database
        const user = await prisma.users.findUnique({
          where: { email: credentials.email },
        });

        if (user && user.password === credentials.password) {
          // You should hash and compare the password securely in a real app
          return { id: user.id, email: user.email }; // Return the user object
        } else {
          return null; // Authentication failed
        }
      },
    }),
  ],
  adapter: PrismaAdapter(prisma),
  pages: {
    signIn: '/auth/signin',  // Custom sign-in page
  },
  session: {
    strategy: "jwt", // Store the session in a JWT
  },
  callbacks: {
    async jwt({ token, user }) {
      if (user) {
        token.id = user.id;
        token.email = user.email;
      }
      return token;
    },
    async session({ session, token }) {
      session.user.id = token.id;
      session.user.email = token.email;
      return session;
    },
  },
  secret: process.env.NEXTAUTH_SECRET,  // Add your secret here for secure sessions
});
