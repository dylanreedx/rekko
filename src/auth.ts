import {EdgeDBAdapter} from '@auth/edgedb-adapter';
import NextAuth from 'next-auth';
import Spotify from 'next-auth/providers/spotify';
import {createClient} from 'edgedb';

const client = createClient({dsn: process.env.AUTH_EDGEDB_DSN});

export const {auth, handlers, signIn, signOut} = NextAuth({
  providers: [
    /* eslint-disable */
    // @ts-ignore
    Spotify({
      clientId: process.env.SPOTIFY_CLIENT_ID,
      clientSecret: process.env.SPOTIFY_CLIENT_SECRET,
    }),
  ],
  adapter: EdgeDBAdapter(client),
  // callbacks: {
  //   authorized({auth, request: {nextUrl}}) {
  //     const isLoggedIn = !!auth?.user;
  //     const isOnDashboard = nextUrl.pathname.startsWith('/dashboard');
  //     if (isOnDashboard) {
  //       if (isLoggedIn) return true;
  //       return false; // Redirect unauthenticated users to login page
  //     } else if (isLoggedIn) {
  //       return Response.redirect(new URL('/dashboard', nextUrl));
  //     }
  //     return true;
  //   },
  // },
});
