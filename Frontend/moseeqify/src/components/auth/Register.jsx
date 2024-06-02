import React, { useState } from "react";
import axios from "axios";
import { Link } from "react-router-dom";
import { toast, ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";

const Register = () => {
  const [formData, setFormData] = useState({
    username: "",
    email: "",
    name: "",
    password: "",
    dob: "",
  });

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.post(
        "http://localhost:5000/register",
        formData
      );
      toast.success("User registered successfully!");
    } catch (error) {
      toast.error("Registration error: " + error.response.data.message);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-black">
      <div className="bg-black p-8 rounded-lg border-2 border-red-500 shadow-white w-full max-w-md">
        <h2 className="text-3xl font-bold mb-6 text-center text-white">
          Register on Moseeqify
        </h2>
        <form onSubmit={handleSubmit} className="space-y-6">
          <input
            type="text"
            name="username"
            placeholder="Username"
            value={formData.username}
            onChange={handleChange}
            className="w-full p-3 border border-red-500 rounded-lg bg-gray-200 text-black placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ff5757"
          />
          <input
            type="email"
            name="email"
            placeholder="Email"
            value={formData.email}
            onChange={handleChange}
            className="w-full p-3 border border-red-500 rounded-lg bg-gray-200 text-black placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ff5757"
          />
          <input
            type="text"
            name="name"
            placeholder="Name"
            value={formData.name}
            onChange={handleChange}
            className="w-full p-3 border border-red-500 rounded-lg bg-gray-200 text-black placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ff5757"
          />
          <input
            type="password"
            name="password"
            placeholder="Password"
            value={formData.password}
            onChange={handleChange}
            className="w-full p-3 border border-red-500 rounded-lg bg-gray-200 text-black placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ff5757"
          />
          <input
            type="date"
            name="dob"
            placeholder="Date of Birth"
            value={formData.dob}
            onChange={handleChange}
            className="w-full p-3 border border-red-500 rounded-lg bg-gray-200 text-black placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-ff5757"
          />
          <div className="flex justify-between items-center">
            <span className="text-sm text-gray-400">
              Already have an account?
            </span>
            <Link to="/login" className="text-red-500 hover:text-red-400">
              Login
            </Link>
          </div>
          <button
            type="submit"
            className="w-full bg-red-500 text-white p-3 rounded-xl hover:bg-red-600"
          >
            Register
          </button>
        </form>
        <ToastContainer />
      </div>
    </div>
  );
};

export default Register;
