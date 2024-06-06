import React, { useContext, useState } from "react";
import { FaPlay, FaPlus } from "react-icons/fa";
import axios from "axios";
import { useMusic } from "../contexts/MusicContext";
import { useUser } from "../contexts/UserContext";
import AddSongToPlaylistModal from "./songs/AddSongToPlaylistModal";

const Song = ({ title, artist, url, songId }) => {
  const { setCurrentSongUrl } = useMusic();
  const { user } = useUser();
  const [isModalOpen, setIsModalOpen] = useState(false); // State to control modal visibility

  const handlePlay = async () => {
    try {
      console.log("Play button clicked");
      console.log("Song ID:", songId);
      setCurrentSongUrl(url);

      await axios.post(`http://localhost:5000/save-to-history/${songId}`, {
        username: user.username,
      });

      console.log("Song played successfully");
    } catch (error) {
      console.error("Error playing song:", error);
    }
  };

  const handleOpenModal = () => {
    setIsModalOpen(true);
  };

  const handleCloseModal = () => {
    setIsModalOpen(false);
  };

  return (
    <div className="flex items-center justify-between p-4 bg-gray-900 rounded-lg mb-2 w-full">
      <div className="flex flex-col">
        <span className="text-lg font-bold text-white">{title}</span>
        <span className="text-sm text-gray-400">{artist}</span>
      </div>
      <div className="flex items-center">
        <button
          className="text-white bg-red-500 p-2 rounded-full hover:bg-red-600 mr-2"
          onClick={handlePlay}
        >
          <FaPlay />
        </button>
        <button
          className="text-white bg-green-500 p-2 rounded-full hover:bg-green-600"
          onClick={handleOpenModal} // Open modal when button is clicked
        >
          <FaPlus />
        </button>
      </div>
      <AddSongToPlaylistModal
        isOpen={isModalOpen}
        onClose={handleCloseModal}
        songId={songId}
      />
    </div>
  );
};

export default Song;
