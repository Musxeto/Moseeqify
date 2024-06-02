import React from "react";
import { Link, useNavigate } from "react-router-dom";
import { useUser } from "../../contexts/UserContext";
import Search from "./Search"; // import the Search component

const Navbar = () => {
  const navigate = useNavigate();
  const { user, setUser } = useUser();

  const handleLogout = () => {
    setUser(null);
    navigate("/login");
  };

  return (
    <nav className="bg-black text-white p-4 flex justify-between items-center border-b-2 border-red-500">
      <Link to="/" className="flex items-center text-xl font-bold">
        <img src="/logo.png" alt="Moseeqify" className="h-16 mr-2" />{" "}
      </Link>
      <div className="hidden md:flex space-x-10 text-xl">
        {" "}
        {/* Hide on small screens */}
        <Link to="/" className="hover:text-gray-400">
          Home
        </Link>
        <Link to="/playlists" className="hover:text-gray-400">
          Playlists
        </Link>
        <Link to="/songs" className="hover:text-gray-400">
          Songs
        </Link>
        <Link to="/albums" className="hover:text-gray-400">
          Albums
        </Link>
      </div>
      <Search /> {/* Use the Search component */}
      {user && (
        <button
          onClick={handleLogout}
          className="bg-red-500 w-16 text-white p-2 rounded-lg"
        >
          Logout
        </button>
      )}
    </nav>
  );
};

export default Navbar;
