import React from "react";
import Navbar from "../navbar/Navbar";
import Welcome from "./Welcome";
import ListeningHistory from "./ListeningHistory";
import HomeBody from "./HomeBody";
import MusicPlayer from "../musicPlayer/MusicPlayer";

const Home = () => {
  return (
    <>
      <Navbar />
      <div className="container mx-auto bg-black flex flex-col mt-16">
        <HomeBody />
      </div>
    </>
  );
};

export default Home;
