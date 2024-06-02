// PrivateRoute.js
import React from "react";
import { Navigate, Route } from "react-router-dom";
import { useUser } from "../contexts/UserContext";

const PrivateRoute = ({ children }) => {
  const { currentUser } = useUser();

  if (currentUser) {
    return children;
  } else {
    return <Navigate to={"/login"} />;
  }
};

export default PrivateRoute;
