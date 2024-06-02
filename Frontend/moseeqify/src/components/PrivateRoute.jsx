// PrivateRoute.js
import React from "react";
import { Navigate, Route } from "react-router-dom";

const PrivateRoute = ({ children }) => {
  const currentUser = 10;

  if (currentUser) {
    return children;
  } else {
    return <Navigate to={"/login"} />;
  }
};

export default PrivateRoute;
