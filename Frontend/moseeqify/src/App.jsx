import React from "react";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import Register from "./components/auth/Register";
import Login from "./components/auth/Login";
import PrivateRoute from "./components/PrivateRoute";
import { UserProvider } from "./contexts/UserContext"; // Import UserProvider

const App = () => {
  return (
    <Router>
      {/* Wrap your Routes with UserProvider */}
      <UserProvider>
        <Routes>
          <Route path="/register" element={<Register />} />
          <Route path="/login" element={<Login />} />
          <Route
            path="/"
            element={
              <PrivateRoute>
                <Login />
              </PrivateRoute>
            }
          />
        </Routes>
      </UserProvider>
    </Router>
  );
};

export default App;
