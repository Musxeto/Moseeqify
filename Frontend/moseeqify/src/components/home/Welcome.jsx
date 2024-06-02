import React from "react";
import { motion } from "framer-motion";
import { useUser } from "../../contexts/UserContext";
import { Link } from "react-router-dom";

const Welcome = () => {
  const { user } = useUser();

  return (
    <motion.div
      className="text-6xl font-bold text-red-500 text-center mt-10"
      initial={{ opacity: 0, y: -50 }}
      animate={{ opacity: 1, y: 2 }}
      transition={{ duration: 1 }}
    >
      <div>Welcome, {user ? user.name : "Guest"}!</div>
      <div className="mt-4 space-between">
        <Link
          to="/songs"
          className="text-xl text-white border-2 border-red-300 bg-red-500 px-4 py-2 rounded-md mr-4"
        >
          Songs
        </Link>
        <Link
          to="/albums"
          className="text-xl text-white bg-red-500 border-2 border-red-300 px-4 py-2 rounded-md"
        >
          Albums
        </Link>
      </div>
    </motion.div>
  );
};

export default Welcome;
