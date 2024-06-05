import React, { useState, useEffect } from "react";
import axios from "axios";
import Navbar from "../navbar/Navbar";
import Song from "../Song";
import MusicPlayer from "../musicPlayer/MusicPlayer";
const SongsPage = () => {
  const [songs, setSongs] = useState([]);

  useEffect(() => {
    const fetchSongs = async () => {
      try {
        const response = await axios.get("http://localhost:5000/songs");
        setSongs(response.data);
      } catch (error) {
        console.error("Error fetching songs:", error);
      }
    };

    fetchSongs();
  }, []);

  return (
    <>
      <div className="container mx-auto bg-black flex flex-col mt-16">
        <h1 className="text-3xl font-bold text-white mb-4">Songs</h1>
        <div className="flex flex-col space-y-2">
          {songs.map((song) => (
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
    </>
  );
};

export default SongsPage;
