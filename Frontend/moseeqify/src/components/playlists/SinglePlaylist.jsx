import React, { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import axios from "axios";
import Song from "../Song";

const SinglePlaylist = () => {
  const { playlistId } = useParams();
  const [playlist, setPlaylist] = useState(null);

  useEffect(() => {
    const fetchPlaylist = async () => {
      try {
        const response = await axios.get(
          `http://localhost:5000/playlists/${playlistId}`
        );
        setPlaylist(response.data);
      } catch (error) {
        console.error("Error fetching playlist:", error);
      }
    };

    fetchPlaylist();
  }, [playlistId]);

  if (!playlist) {
    return <div>Loading...</div>;
  }

  return (
    <div className="container pb-32 mx-auto bg-black flex flex-col mb-24 mt-16">
      <h1 className="text-3xl font-bold text-white mb-4">{playlist.name}</h1>
      <h2 className="text-xl font-bold text-white mb-4">
        Created by: {playlist.username}
      </h2>

      <h3 className="text-xl font-bold text-white mb-2">Songs</h3>
      <div className="flex flex-col space-y-2">
        {playlist.songs.map((song) => (
          <Song
            key={song.id}
            title={song.title}
            artist={song.artist}
            url={song.url}
            songId={song.id}
          />
        ))}
      </div>
    </div>
  );
};

export default SinglePlaylist;
