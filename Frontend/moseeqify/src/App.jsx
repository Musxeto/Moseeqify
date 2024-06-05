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
import AlbumsPage from "./components/albums/AlbumsPage";
import SingleAlbum from "./components/albums/SingleAlbum";
import Navbar from "./components/navbar/Navbar";
import PlaylistsPage from "./components/playlists/PlaylistsPage"; // Import PlaylistsPage

const App = () => {
  let location = useLocation();

  return (
    <UserProvider>
      {location.pathname !== "/register" && location.pathname !== "/login" && (
        <Navbar />
      )}
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
        <Route
          path="/albums"
          element={
            <PrivateRoute>
              <AlbumsPage />
            </PrivateRoute>
          }
        />
        <Route
          path="/albums/:albumId"
          element={
            <PrivateRoute>
              <SingleAlbum />
            </PrivateRoute>
          }
        />
        <Route
          path="/playlists"
          element={
            <PrivateRoute>
              <PlaylistsPage />
            </PrivateRoute>
          }
        />
      </Routes>

      {location.pathname !== "/register" && location.pathname !== "/login" && (
        <MusicPlayer />
      )}
    </UserProvider>
  );
};

export default App;
