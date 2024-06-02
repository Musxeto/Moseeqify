import React from "react";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import Register from "./components/auth/Register";
import Login from "./components/auth/Login";
import PrivateRoute from "./components/PrivateRoute";
import { UserProvider } from "./contexts/UserContext";
import Home from "./components/home/Home";
import "./App.css";
import "./CustomAudioPlayer.scss";
import SongsPage from "./components/songs/SongsPage";
const App = () => {
  return (
    <Router>
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
      </UserProvider>
    </Router>
  );
};

export default App;
