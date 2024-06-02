import React from "react";
import { Navigate, Route } from "react-router-dom";
import { useUser } from "../contexts/UserContext";

const PrivateRoute = ({ children }) => {
  const { user } = useUser();

  if (user) {
    return children;
  } else {
    return <Navigate to={"/login"} />;
  }
};

export default PrivateRoute;
