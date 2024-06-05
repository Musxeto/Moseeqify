import React, { useContext } from "react";
import { FaPlay } from "react-icons/fa";
import axios from "axios"; // Import Axios
import { useMusic } from "../contexts/MusicContext";
import { useUser } from "../contexts/UserContext"; // Import useUser hook

const Song = ({ title, artist, url, songId }) => {
  const { setCurrentSongUrl } = useMusic();
  const { user } = useUser(); // Access the user context

  const handlePlay = async () => {
    try {
      console.log("Play button clicked");
      console.log("Song ID:", songId); // Add this line to check the songId
      setCurrentSongUrl(url);

      // Make a POST request to save the song to history with the username from context
      await axios.post(`http://localhost:5000/save-to-history/${songId}`, {
        username: user.username,
      });

      console.log("Song played successfully");
    } catch (error) {
      console.error("Error playing song:", error);
    }
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
