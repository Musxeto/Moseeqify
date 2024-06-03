import React from "react";
import { FaPlay } from "react-icons/fa";
import { useMusic } from "../contexts/MusicContext";

const Song = ({ title, artist, url }) => {
  const { setCurrentSongUrl } = useMusic();

  const handlePlay = () => {
    console.log("Play button clicked");
    setCurrentSongUrl(url);
  };

  return (
    <div className="flex items-center justify-between p-4 bg-gray-900 rounded-lg mb-2 w-full">
      <div className="flex flex-col">
        <span className="text-lg font-bold text-white">{title}</span>
        <span className="text-sm text-gray-400">{artist}</span>
      </div>
      <button
        className="text-white bg-red-500 p-2 rounded-full hover:bg-red-600"
        onClick={handlePlay}
      >
        <FaPlay />
      </button>
    </div>
  );
};

export default Song;
