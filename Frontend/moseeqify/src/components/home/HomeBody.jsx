import React from "react";
import Welcome from "./Welcome";
import ListeningHistory from "./ListeningHistory";
import MusicPlayer from "../musicPlayer/MusicPlayer";

const HomeBody = () => {
  return (
    <div className="flex flex-col  overflow-hidden">
      <div className="navbar fixed top-0 w-full z-50"></div>
      <div className="flex flex-1 overflow-hidden">
        <div className="w-2/3 ">
          <Welcome />
        </div>
        <div className="w-1/3 ">
          <ListeningHistory />
        </div>
      </div>
    </div>
  );
};

export default HomeBody;
