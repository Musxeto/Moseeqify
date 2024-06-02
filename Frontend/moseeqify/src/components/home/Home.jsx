import React from "react";
import Navbar from "../navbar/Navbar";
import HomeBody from "./HomeBody";

const Home = () => {
  return (
    <>
      <Navbar />
      <div className="container bg-black flex flex-col mt-16 ">
        <HomeBody />
      </div>
    </>
  );
};

export default Home;
