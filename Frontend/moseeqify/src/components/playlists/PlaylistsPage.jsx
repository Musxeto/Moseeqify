import React, { useState, useEffect } from "react";
import axios from "axios";
import { Link } from "react-router-dom";

const PlaylistsPage = () => {
  const [playlists, setPlaylists] = useState([]);

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

  return (
    <div className="container mx-auto bg-black flex flex-col mb-24 mt-16">
      <h1 className="text-3xl font-bold text-white mb-4">Playlists</h1>
      <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
        {playlists.map((playlist) => (
          <div key={playlist.id}>
            <Link to={`/playlists/${playlist.id}`}>
              <div className="bg-gray-900 rounded-lg p-4">
                <h2 className="text-lg font-bold text-white mb-2">
                  {playlist.name}
                </h2>
                <p className="text-gray-400">{playlist.username}</p>
              </div>
            </Link>
          </div>
        ))}
      </div>
    </div>
  );
};

export default PlaylistsPage;
