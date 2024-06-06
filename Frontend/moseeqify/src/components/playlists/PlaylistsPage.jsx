import React, { useState, useEffect } from "react";
import axios from "axios";
import CreatePlaylistModal from "./CreatePlaylistModal";
import { Link } from "react-router-dom";

const PlaylistsPage = () => {
  const [playlists, setPlaylists] = useState([]);
  const [isModalOpen, setIsModalOpen] = useState(false);

  useEffect(() => {
    const fetchPlaylists = async () => {
      try {
        const response = await axios.get("http://localhost:5000/playlists");
        setPlaylists(response.data);
      } catch (error) {
        console.error("Error fetching playlists:", error);
      }
    };

    fetchPlaylists();
  }, []);

  const handleCreatePlaylist = (newPlaylist) => {
    setPlaylists([...playlists, newPlaylist]);
  };

  return (
    <>
      <div className="container mx-auto bg-black flex flex-col mt-16">
        <h1 className="text-3xl font-bold text-white mb-4">Playlists</h1>
        <button
          className="bg-red-500 text-white px-4 py-4 rounded mb-4 mr-20 ml-20"
          onClick={() => setIsModalOpen(true)}
        >
          Create Playlist
        </button>
        <div className="flex flex-col space-y-2">
          {playlists.map((playlist) => (
            <Link to={`/playlists/${playlist.id}`}>
              <div key={playlist.id} className="bg-gray-800 p-4 rounded-lg">
                <h2 className="text-xl font-bold text-white">
                  {playlist.name}
                </h2>
              </div>
            </Link>
          ))}
        </div>
      </div>
      <CreatePlaylistModal
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        onCreate={handleCreatePlaylist}
      />
    </>
  );
};

export default PlaylistsPage;
