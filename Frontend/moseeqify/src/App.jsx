import React from "react";
import {
  BrowserRouter as Router,
  Route,
  Routes,
  useLocation,
} from "react-router-dom";
import Register from "./components/auth/Register";
import Login from "./components/auth/Login";
import PrivateRoute from "./components/PrivateRoute";
import { UserProvider } from "./contexts/UserContext";
import Home from "./components/home/Home";
import "./App.css";
import "./CustomAudioPlayer.scss";
import SongsPage from "./components/songs/SongsPage";
import MusicPlayer from "./components/musicPlayer/MusicPlayer";

const App = () => {
  let location = useLocation();

  // You can use the location object here to conditionally render components based on the current path

  return (
    <UserProvider>
      <Routes>
        <Route path="/register" element={<Register />} />
        <Route path="/login" element={<Login />} />
        <Route
          path="/"
          element={
            <PrivateRoute>
              <Home />
            </PrivateRoute>
          }
        />
        <Route
          path="/songs"
          element={
            <PrivateRoute>
              <SongsPage />
            </PrivateRoute>
          }
        />
      </Routes>

      {location.pathname !== "/register" && location.pathname !== "/login" && (
        <MusicPlayer
          url={
            "https://firebasestorage.googleapis.com/v0/b/moseeqify.appspot.com/o/Punk%20Monk.mp3?alt=media&token=6f8c6a54-70d0-45fb-8083-58b909e5c444"
          }
        />
      )}
    </UserProvider>
  );
};

export default App;
